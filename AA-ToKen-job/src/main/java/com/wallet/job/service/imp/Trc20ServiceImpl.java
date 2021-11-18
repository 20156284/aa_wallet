package com.wallet.job.service.imp;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.wallet.job.benum.RecordStatus;
import com.wallet.job.benum.RecordType;
import com.wallet.job.benum.protocolType;
import com.wallet.job.entity.Bo.ChatAddressBO;
import com.wallet.job.entity.TxIdGroupByAddressVO;
import com.wallet.job.mapper.ChatWalletMapper;
import com.wallet.job.service.Trc20Service;
import com.wallet.job.util.ErrorCode;
import com.wallet.job.util.HttpUtil;
import com.wallet.job.util.SuccessCode;
import com.wallet.job.util.eth.AddrUtil;
import com.wallet.job.util.eth.RSAUtil;
import com.wallet.job.util.trx.JsonUtil;
import com.wallet.job.util.trx.TronUtil;
import com.wallet.job.util.trx.TrxUtil;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.web3j.crypto.ECKeyPair;
import org.web3j.crypto.Keys;
import org.web3j.crypto.WalletFile;
import org.web3j.utils.Numeric;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class Trc20ServiceImpl implements Trc20Service {
    private static Logger logger = LoggerFactory.getLogger(Trc20ServiceImpl.class);
    @Autowired
    private TrxUtil trxUtil;
    @Autowired
    ChatWalletMapper chatWalletMapper;

    @Override
    public Map<String, Object> newAddress(ChatAddressBO chatAddressBO) {
        TronUtil tronUtil = new TronUtil();
        AddrUtil addrUtil = new AddrUtil();
        Map map = new HashMap();
        int erro = ErrorCode.NEW_ADDRESS_ERROR;
        if (chatAddressBO.getType() == 2) {
            erro = ErrorCode.MNEMONIC_ADDRESS_ERROR;
        }
        try {
            String mnemonic = chatAddressBO.getMnemonic();
            String TRX_MNEMONIC_ = "m/44'/195'/0'/0/0";
            Map<String, Object> ethMap = addrUtil.ethGenerateBip39Wallet(chatAddressBO.getMnemonic(), TRX_MNEMONIC_, "123456");
            ECKeyPair eCKeyPair = (ECKeyPair) ethMap.get("eCKeyPair");
            WalletFile walletFile = (WalletFile) ethMap.get("walletFile");
            String address = walletFile.getAddress();
            String privateKey = eCKeyPair.getPrivateKey().toString(16);
            String publicKey = eCKeyPair.getPublicKey().toString(16);
            if (StringUtils.isBlank(mnemonic)) {
                mnemonic = (ethMap.get("mnemonic").toString());
            }
            String trx_address = tronUtil.hexStringTobase58check("41" + address);
            map.put("address", trx_address);
            map.put("privateKey", privateKey);
            map.put("mnemonic", mnemonic);
            //是否存在
            int conut = chatWalletMapper.getCountAddress(chatAddressBO.getAppId(), trx_address, chatAddressBO.getProtocol());
            if (conut == 0) {
                int insertCount = chatWalletMapper.addAddress(trx_address,
                        publicKey, RSAUtil.publicEncrypt(privateKey), RSAUtil.publicEncrypt(mnemonic),
                        chatAddressBO.getProtocol(), null);
                if (insertCount != 1) {
                    throw new Exception(String.valueOf(ErrorCode.SYS_ERROR));
                }
            }

        } catch (Exception e) {
            logger.warn("地址錯誤信息:{}", e.getMessage());
            return HttpUtil.returnData(null, erro);
        }
        return HttpUtil.returnData(map, SuccessCode.SUCCESS);
    }

    //{
//        "msg": "成功",
//        "data": {
//        "privateKey": "66fc95deaf97055d3109f101219e9fd61638fe38d15ff30ed1820660f480c9a9",
//        "address": "TQrNHepxRs67jEqQjipQowmJsKYw9Htc1t",
//        "mnemonic": "peanut trade gate food adult myself accident skull pioneer member miss tomato"
//        },
//        "retcode": 0
//        }

    @Override
    public Map<String, Object> getAddress(ChatAddressBO chatAddressBO) {
        TronUtil tronUtil = new TronUtil();
        Map map = new HashMap();
        String address = "";
        try {
            address = Keys.toChecksumAddress(Keys.getAddress(ECKeyPair.create(Numeric.toBigInt(chatAddressBO.getPrivateKey()))));
            address = tronUtil.hexStringTobase58check(address.replace("0x", "41"));
            map.put("address", address);
            map.put("privateKey", chatAddressBO.getPrivateKey());
            //是否存在
            int conut = chatWalletMapper.getCountAddress(chatAddressBO.getAppId(), address, chatAddressBO.getProtocol());
            if (conut == 0) {
                int insertCount = chatWalletMapper.addAddress(address, null, RSAUtil.publicEncrypt(chatAddressBO.getPrivateKey()), null, chatAddressBO.getProtocol(), null);
                if (insertCount != 1) {
                    throw new Exception(String.valueOf(ErrorCode.SYS_ERROR));
                }
            }
        } catch (Exception e) {
            logger.warn("地址錯誤信息:{}", e.getMessage());
            return HttpUtil.returnData(null, ErrorCode.PRIVATEKEY_ADDRESS_ERROR);
        }
        return HttpUtil.returnData(map, SuccessCode.SUCCESS);
    }

    @Override
    public Map<String, Object> chatWalletTransfer(ChatAddressBO chatAddressBO) {
        Map map = new HashMap();
        try {
            String toAddress = chatAddressBO.getToAddress();
            BigDecimal amount = new BigDecimal(chatAddressBO.getNumber());
            String coinType = chatAddressBO.getCoinKey();
            String fromAddress = chatAddressBO.getFromAddress();
            String privateKey = chatAddressBO.getPrivateKey();
            BigDecimal fee = BigDecimal.ZERO;
            String transaction = null;
            String txid = "";
            //验证地址
            if (!trxUtil.validateAddress(toAddress)) {
                logger.info("【转账失败】验证地址有误，转出地址: {}, 转入地址: {}, 转出额度: {}, 币种: {}",
                        fromAddress, toAddress, amount, coinType);
                return HttpUtil.returnData(null, ErrorCode.ADDRESS_NO_ERROR);
            }

            //TRX 提币
            if (coinType.equals("TRX")) {
                //获取免费的宽带信息一条交易消耗的Bandwidth Points = 交易字节数 * Bandwidth Points费率,当前Bandwidth Points费率 = 1。
                BigDecimal accountResource = trxUtil.getaAccountresource(fromAddress, true);
                if (accountResource.compareTo(new BigDecimal("500")) < 0) {
                    //免费宽带不足则付手续费
                    fee = new BigDecimal(5);
                }
                //链上金额
                BigDecimal balance = trxUtil.getAccount(fromAddress, true);
                if (balance.compareTo(amount.add(fee)) < 0) {
                    logger.info("【转账失败】余额不足 转出地址: {}, 转入地址: {}, 转出额度: {}, 币种: {},余额:{},手续费:{}",
                            fromAddress, toAddress, amount, coinType, balance, fee);
                    return HttpUtil.returnData(null, ErrorCode.AMOUNT_NO_ERROR);
                }
                //创建一个转账的Transaction
                transaction = trxUtil.createTransaction(fromAddress, toAddress, new BigInteger(String.valueOf(trxUtil.getAccountMultiply(amount))), null, true);
            } else {
                //获取合约地址
                String contractAddress = chatWalletMapper.getContractAddressOne(chatAddressBO.getProtocol(), chatAddressBO.getCoinKey());
                if (StringUtils.isBlank(contractAddress)) {
                    logger.info("合约地址不存在。");
                    return HttpUtil.returnData(null, ErrorCode.WITHDRAWAL_NO_ERROR);
                }
                //链上金额TRX
                BigDecimal balance = trxUtil.getAccount(fromAddress, true);
                //判断手续费
                fee = new BigDecimal(5);
                if (balance.compareTo(fee) < 0) {
                    logger.info("【转账失败】手续费不足 转出地址: {}, 转入地址: {}, 转出额度: {}, 币种: {},ETH余额:{},手续费:{}",
                            fromAddress, toAddress, amount, coinType, balance, fee);
                    return HttpUtil.returnData(null, ErrorCode.AMOUNT_FEE_NO_ERROR);
                }
                //判断代币余额
                BigDecimal tokenBalance = trxUtil.getTokenAccountByAddress(fromAddress, contractAddress);
                if (tokenBalance.compareTo(amount) < 0) {
                    logger.info("【转账失败】余额不足 转出地址: {}, 转入地址: {}, 转出额度: {}, 币种: {},余额:{}}",
                            fromAddress, toAddress, amount, coinType, tokenBalance);
                    return HttpUtil.returnData(null, ErrorCode.AMOUNT_NO_ERROR);
                }
                //转换为hex地址
                String hexAddress = TronUtil.base58ToHexString(fromAddress);
                String hexToAddress = TronUtil.base58ToHexString(toAddress);
                String addZeroHexAddress = TronUtil.zeroAdd(hexToAddress, 64);
                contractAddress = TronUtil.base58ToHexString(contractAddress);
                //转换为hex金额
                String sendAmountStr = (amount.movePointRight(6).setScale(0, BigDecimal.ROUND_DOWN)).stripTrailingZeros().toPlainString();
                String addZeroHexSendAmount = TronUtil.zeroAdd(Long.toHexString(new Long(sendAmountStr)), 64);
                String parameter = addZeroHexAddress + addZeroHexSendAmount;
                //创建一个转账的Transaction
                Long feeLimit = new Long(1000000) * fee.longValue();
                transaction = trxUtil.triggersmartcontract(contractAddress, "transfer(address,uint256)", parameter, feeLimit, 0L, hexAddress);
            }
            // 签名
            JSONObject transactionSig = trxUtil.getTransactionSign(transaction, privateKey);
            if (transactionSig == null) {
                logger.error(coinType + "签名失败: {}", transactionSig);
                return HttpUtil.returnData(null, ErrorCode.WITHDRAWAL_NO_ERROR);
            }
            //广播
            txid = trxUtil.broadcastTransaction(transactionSig.getString("txID"),
                    JSON.parseObject(transactionSig.getString("raw_data")),
                    transactionSig.getString("raw_data_hex"),
                    transactionSig.getBoolean("visible"),
                    transactionSig.getJSONArray("signature").toArray(new String[]{}));
            if (StringUtils.isBlank(txid)) {
                logger.info("【转账失败】 转出地址: {}, 转入地址: {}, 转出额度: {}, 币种: {}",
                        fromAddress, toAddress, amount, coinType);
                return HttpUtil.returnData(null, ErrorCode.WITHDRAWAL_NO_ERROR);
            }
            map.put("txId", txid);
        } catch (Exception e) {
            return HttpUtil.returnData(null, ErrorCode.WITHDRAWAL_NO_ERROR);
        } finally {
        }
        return HttpUtil.returnData(map, SuccessCode.SUCCESS);

    }

    @Override
    public Map<String, Object> chatWalletgetBalance(ChatAddressBO chatAddressBO) {
        Map map = new HashMap();
        BigDecimal balance = BigDecimal.ZERO;
        try {
            List<Map<String, Object>> listsMap = chatWalletMapper.getContractAddressList(chatAddressBO.getProtocol());
            if (listsMap != null && listsMap.size() > 0) {
                for (Map<String, Object> m : listsMap) {
                    if (m.get("contract_address") != null) {
                        balance = trxUtil.getTokenAccountByAddress(chatAddressBO.getFromAddress(), m.get("contract_address").toString());
                    } else {
                        balance = trxUtil.getAccount(chatAddressBO.getFromAddress(), true);
                    }
                    map.put(m.get("coinKey"), balance);
                }
            }

        } catch (Exception e) {
            return HttpUtil.returnData(null, ErrorCode.SYS_ERROR);
        }
        return HttpUtil.returnData(map, SuccessCode.SUCCESS);
    }

    @Override
    public Map<String, Object> deleteAddress(ChatAddressBO chatAddressBO) {
        Map map = new HashMap();
        chatWalletMapper.deleteAddress(chatAddressBO.getProtocol(), chatAddressBO.getAddress());
        chatWalletMapper.deleteAddressTransfer(chatAddressBO.getProtocol(), chatAddressBO.getAddress());
        return HttpUtil.returnData(map, SuccessCode.SUCCESS);
    }

    @Override
    public Map<String, Object> getTransfer(ChatAddressBO chatAddressBO) {
        Map<String, Object> data = new HashMap<>();
        List<Map<String, Object>> listMap = chatWalletMapper.getTransfer(chatAddressBO.getProtocol(),
                chatAddressBO.getAddress(), chatAddressBO.getCoinKey(), chatAddressBO.getTransferType(), chatAddressBO.getTransferStatus());
        return HttpUtil.returnData(listMap, SuccessCode.SUCCESS);
    }

    /**
     * 功能描述: <br>
     * 〈TRC20扫块〉
     *
     * @Param: [coinType, appId]
     * @Author: tangjie
     * @Date: 2020/7/31 14:49
     */
    @Override
    public void blockChainSweepingTrc20(String protocol) {
        try {
            logger.warn("开始" + protocol + "充值扫块");
            //查询平台同步高度
            Map<String, Object> blockScannerMap = chatWalletMapper.getBlockScanner(protocol);
            BigInteger pt_blockHeight = BigInteger.ZERO;
            if (blockScannerMap != null && blockScannerMap.get("block_height") != null) {
                pt_blockHeight = new BigInteger(blockScannerMap.get("block_height").toString());
            }
            //获取最新高度
            Map<String, Object> blockHeightMap = trxUtil.getNowBlock();
            BigInteger blockHeight = new BigInteger(blockHeightMap.get("blockHeight").toString());
            if (blockScannerMap == null || blockScannerMap.get("block_height") == null) {
                //无该节点，初始化该节点
                chatWalletMapper.addBlockScanner(protocol, blockHeightMap.get("BlockId").toString(), blockHeight);
                logger.warn("【扫描区块】 初始化" + protocol + "节点信息 coinKey: {},高度:{}", protocol, blockHeightMap.get("BlockId").toString());
            }
            //判断平台高度
            while (pt_blockHeight.intValue() <= blockHeight.intValue()) {
                //获取当前区块转账信息
                Map<String, Object> result = JsonUtil.GsonToMaps(trxUtil.getBlockByNum(pt_blockHeight).toString());
                if (result == null) {
                    continue;
                }
                List<Map<Object, Object>> transactions = (List<Map<Object, Object>>) result.get("transactions");
                if (transactions != null) {
                    for (Map<Object, Object> r : transactions) {
                        Map<Object, Object> result_raw_data = (Map<Object, Object>) r.get("raw_data");
                        List<Map<Object, Object>> contract = (List<Map<Object, Object>>) result_raw_data.get("contract");
                        if (contract != null) {
                            for (Map<Object, Object> parameter : contract) {
                                List<Map<Object, Object>> rets = (List<Map<Object, Object>>) r.get("ret");
                                for (Map<Object, Object> contractRet : rets) {
                                    if (contractRet.get("contractRet") == null || !contractRet.get("contractRet").toString().equals("SUCCESS")) {
                                        continue;
                                    }
                                }
                                Map<Object, Object> value = (Map<Object, Object>) parameter.get("parameter");
                                Map<Object, Object> values = (Map<Object, Object>) value.get("value");
                                String type = parameter.get("type").toString();
                                String txID = "";
                                BigDecimal amount = BigDecimal.ZERO;
                                String from_address_Base58 = "";
                                String to_address_Base58 = "";
                                String coinKey = "";
                                //TRX
                                if (values.get("to_address") != null && r.get("txID") != null && type.equals("TransferContract")) {
                                    txID = r.get("txID").toString();
                                    // 获取接收地址
                                    String to_address = values.get("to_address").toString();
                                    //扫块是Hex地址 转Base58 地址
                                    to_address_Base58 = TronUtil.hexStringTobase58check(to_address);
                                    from_address_Base58 = TronUtil.hexStringTobase58check(values.get("owner_address").toString());
                                    coinKey = "TRX";
                                    if (values.get("amount") != null && values.get("data") == null) {
                                        amount = trxUtil.getAccountDivide(new BigDecimal(values.get("amount").toString()));
                                    }
                                }
                                //TRC20 扫块,逻辑处理
                                if (values != null && values.get("contract_address") != null && values.get("data") != null
                                        && type.equals("TriggerSmartContract")) {
                                    txID = r.get("txID").toString();
                                    //扫块是Hex地址 41->T,合约地址
                                    String tokenCollectionAddress_address = TronUtil.hexStringTobase58check(values.get("contract_address").toString());
                                    //获取平台的合约地址
                                    Map<String, Object> tokenCollectionAddressMap = chatWalletMapper.getContractAddress(protocol, tokenCollectionAddress_address);
                                    if (tokenCollectionAddressMap == null ||
                                            tokenCollectionAddressMap.get("contract_address") == null ||
                                            tokenCollectionAddressMap.get("coinkey") == null) {
                                        continue;
                                    }
                                    //通过合约地址获取币种名称
                                    coinKey = tokenCollectionAddressMap.get("coinkey").toString();
                                    String tokenCollectionAddress = tokenCollectionAddressMap.get("contract_address").toString();
                                    //比对合约地址
                                    if (tokenCollectionAddress.equals(tokenCollectionAddress_address)) {
                                        String data = values.get("data").toString();
                                        if (data == null || data.length() < 73) {
                                            continue;
                                        }
                                        //扫块是Hex地址,41->T,from地址
                                        from_address_Base58 = TronUtil.hexStringTobase58check(values.get("owner_address").toString());
                                        //接收地址41->T
                                        to_address_Base58 = TronUtil.hexStringTobase58check("41" + data.substring(32, 72));
                                        //数量
                                        amount = trxUtil.getAccountDivide(new BigDecimal(new BigInteger(data.substring(72), 16)));
                                    }
                                }
                                byte recordType = (byte) 0;
                                Map<String, Object> allTRCWalletMap = chatWalletMapper.getToAddress(protocol, to_address_Base58, from_address_Base58);
                                //先查询地址是否是平台的,不是跳过
                                if (allTRCWalletMap == null || allTRCWalletMap.get("address") == null) {
                                    continue;
                                }
                                // 过滤处理过的交易
                                int hashCount = chatWalletMapper.getHash(txID, protocol);
                                // 已入账
                                if (hashCount > 0) {
                                    continue;
                                }
                                if (allTRCWalletMap.get("address").toString().equals(from_address_Base58)) {
                                    recordType = RecordType.WITHDRAW.getVal();
                                } else if (allTRCWalletMap.get("address").toString().equals(to_address_Base58)) {
                                    recordType = RecordType.RECHARGE.getVal();
                                }

                                //插入充值记录
                                chatWalletMapper.insertWalletTransfer(coinKey, amount,
                                        RecordStatus.CONFIRMING.getVal(), to_address_Base58,
                                        recordType, txID, from_address_Base58, protocol);
                                logger.warn(coinKey + "【插入" + protocol + "充值记录成功】 txid: {}, from: {}, to: {},数量:{}",
                                        txID, from_address_Base58, to_address_Base58, amount);
                            }
                        }

                    }
                }

                pt_blockHeight = pt_blockHeight.add(BigInteger.ONE);
                chatWalletMapper.updateBlockScanner(Integer.parseInt(blockScannerMap.get("id").toString()), pt_blockHeight);
            }
            logger.warn("{}充值扫块结束,结束高度:{}", protocol, pt_blockHeight);
        } catch (Exception e) {
            logger.error("TRX充值扫块异常");
            e.printStackTrace();
        }

    }

    public void rechargeCallback(String protocol) {
        logger.warn("充值回调检查:{}", protocol);
        List<TxIdGroupByAddressVO> usdtWalletTransferVOS = chatWalletMapper.selectTxidGroupByAddress(protocol, RecordStatus.CONFIRMING.getVal());
        for (TxIdGroupByAddressVO vo : usdtWalletTransferVOS) {
            String txid = vo.getTxids();
            try {
                //TRC20系列
                if (protocol.equals(protocolType.TRC20.name())) {
                    byte recordStatus = RecordStatus.CONFIRMED.getVal();
                    //查询交易信息
                    JSONObject transaction = trxUtil.getTransactioninfoByid(txid);
                    logger.warn("类型:{},充值回调, txid: {},返回信息:{}", protocol, txid, transaction);
                    if (transaction != null) {

                        // 查询最新区块
                        Map<String, Object> blockHeightMap = trxUtil.getNowBlock();
                        BigInteger blockHeight = new BigInteger(blockHeightMap.get("blockHeight").toString());
                        //交易区块
                        BigDecimal transactionBlockHeig = new BigDecimal(transaction.get("blockNumber").toString());
                        int confirmations = blockHeight.intValue() - transactionBlockHeig.intValue();
                        if (confirmations >= 15) {
                            if (transaction.get("result") != null
                                    && transaction.get("result").toString().equals("FAILED")) {
                                recordStatus = RecordStatus.CONFIRM_FAIL.getVal();
                            }
                            //获取手续费
                            BigDecimal txFee = BigDecimal.ZERO;
                            if (transaction.get("fee") != null) {
                                txFee = trxUtil.getAccountDivide(new BigDecimal(transaction.get("fee").toString()));
                            }
                            //更新为已确认
                            chatWalletMapper.updateWalletTransfer(vo.getId(), recordStatus, confirmations, txFee,protocol);
                            logger.warn(protocol + "交易确认 txid: {},币种:{},数量:{},类型：{},id:{}", txid, vo.getCoinKey(), vo.getQty(), protocol, vo.getId());
                        }

                    }

                }
            } catch (Exception e) {
                logger.error(e.toString(), e);
            }
        }

    }

}