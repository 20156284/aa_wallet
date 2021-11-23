package com.wallet.job.service.imp;

import com.wallet.job.benum.RecordStatus;
import com.wallet.job.benum.protocolType;
import com.wallet.job.entity.TransactionVO;
import com.wallet.job.entity.TxIdGroupByAddressVO;
import com.wallet.job.mapper.AddressInfoMapper;
import com.wallet.job.service.Erc20Service;
import com.wallet.job.util.BeanUtil;
import com.wallet.job.util.eth.EthUtil;
import com.wallet.job.util.eth.NodeUtil;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.methods.response.EthBlock;
import org.web3j.protocol.core.methods.response.Transaction;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@Service
public class Erc20ServiceImpl implements Erc20Service {
    private static Logger logger = LoggerFactory.getLogger(Erc20ServiceImpl.class);
    @Autowired
    private AddressInfoMapper addressInfoMapper;

    public void blockChainSweepingErc20(String protocol) {
        Integer type = 0;
        Web3j web3j = NodeUtil.web3j;
        String coinKey = "ETH";
        if (protocol.toUpperCase().equals(protocolType.ARC20.name())) {
            web3j = NodeUtil.aaWeb3j;
            coinKey = "AAA";
        }

        try {
            logger.warn("开始:{}充值扫块,web3j:{}", protocol, web3j);
            //查询平台同步高度
            Map<String, Object> blockScannerMap = addressInfoMapper.getBlockScanner(protocol);
            BigInteger pt_blockHeight = BigInteger.ZERO;
            if (blockScannerMap != null && blockScannerMap.get("block_height") != null) {
                pt_blockHeight = new BigInteger(blockScannerMap.get("block_height").toString());
            }
            //获取最新高度
            BigInteger blockHeight = EthUtil.getBlockHeight(web3j).subtract(new BigInteger("3"));
            // 无该节点，初始化该节点
            if (blockScannerMap == null || blockScannerMap.get("block_height") == null) {
                EthBlock.Block block = EthUtil.getBlockByHeight(web3j, blockHeight);
                addressInfoMapper.addBlockScanner(protocol, block.getHash(), blockHeight);
                logger.warn("【扫描区块】 初始化" + protocol + "节点高度: {}", blockHeight);
                return;
            }
            while (pt_blockHeight.intValue() <= blockHeight.intValue()) {
                List<Transaction> historyTransactions =
                        EthUtil.getHistoryTransactions(web3j, pt_blockHeight);
                if (historyTransactions == null) {
                    continue;
                }
                for (Transaction transaction : historyTransactions) {
                    TransactionVO transactionVO = null;
                    //ETH扫块
                    if (transaction.getValue().compareTo(BigInteger.ZERO) == 1) {
                        Map<String, Object> tokenTransactionInfo = EthUtil.getEthTransactionInfo(transaction);
                        if (tokenTransactionInfo == null) continue;
                        transactionVO = BeanUtil.copyMapProperties(tokenTransactionInfo, TransactionVO.class);
                        coinKey = "ETH";
                        if (protocol.toUpperCase().equals(protocolType.ARC20.name())) {
                            coinKey = "AAA";
                        }
                    } else {
                        //ETH代币扫块
                        //获取平台的合约地址 合约地址是否存在
                        Map<String, Object> tokenCollectionAddressMap = addressInfoMapper.getContractAddress(protocol, transaction.getTo());
                        if (tokenCollectionAddressMap == null ||
                                tokenCollectionAddressMap.get("contract_address") == null ||
                                tokenCollectionAddressMap.get("coin_key") == null) {
                            continue;
                        }
                        //通过合约地址获取币种名称
                        coinKey = tokenCollectionAddressMap.get("coin_key").toString();
                        if (tokenCollectionAddressMap.get("contract_address").toString().toLowerCase().equals(transaction.getTo())) {
                            Map<String, Object> tokenTransactionInfo = EthUtil.getTokenTransactionInfo(transaction, web3j);
                            if (tokenTransactionInfo == null) continue;
                            transactionVO = BeanUtil.copyMapProperties(tokenTransactionInfo, TransactionVO.class);
                            if (StringUtils.isBlank(transactionVO.getTo().toLowerCase()) || StringUtils.isBlank(transactionVO.getTxid())) {
                                continue;
                            }
                        }
                        if (transactionVO != null && StringUtils.isNotBlank(transactionVO.getTo())
                                && !transactionVO.getTo().startsWith("0x")) {
                            transactionVO.setTo("0x" + transactionVO.getTo());
                        }
                    }
                    if (StringUtils.isBlank(transactionVO.getTo())) {
                        continue;
                    }
                    //先查询地址是否是平台的,不是跳过
                    Map<String, Object> allTRCWalletMap = addressInfoMapper.countAddress(protocol, transactionVO.getFrom().toLowerCase(), transactionVO.getTo().toLowerCase());
                    if (allTRCWalletMap == null || allTRCWalletMap.get("address") == null) {
                        continue;
                    }
                    String address = allTRCWalletMap.get("address").toString();
                    if (StringUtils.isNotBlank(transactionVO.getFrom().toLowerCase()) && transactionVO.getFrom().toLowerCase().equals(address)) {
                        type = 20;
                    }
                    if (StringUtils.isNotBlank(transactionVO.getTo().toLowerCase()) && transactionVO.getTo().toLowerCase().equals(address)) {
                        type = 10;
                    }
                    // 过滤处理过的交易
                    Integer hashCount = addressInfoMapper.getHash(transactionVO.getTxid(),
                            type, protocol);
                    if (hashCount != null && hashCount > 0) {
                        continue;
                    }
                    //插入充值记录
                    addressInfoMapper.insertWalletTransfer(type, coinKey, transactionVO.getFrom(),
                            transactionVO.getTo(),
                            transactionVO.getAmount(), transactionVO.getTxid(), protocol, transactionVO.getTxFee(), RecordStatus.CONFIRMING.getVal());
                    logger.warn("【插入{}充值记录成功】 txid: {}, from: {}, to: {}", coinKey,
                            transactionVO.getTxid(), transactionVO.getFrom(), transactionVO.getTo());
                }
                pt_blockHeight = pt_blockHeight.add(BigInteger.ONE);
                addressInfoMapper.updateBlockScanner(Integer.parseInt(blockScannerMap.get("id").toString()), pt_blockHeight);
            }
            logger.warn("{}充值扫块结束,结束高度:{}", protocol, pt_blockHeight);
        } catch (Exception e) {
            logger.error("{}充值扫块异常", protocol);
            e.printStackTrace();
        }
    }

    @Override
    public void rechargeCallback(String protocol) {
        logger.warn("回调检查:{}", protocol);
        List<TxIdGroupByAddressVO> usdtWalletTransferVOS = addressInfoMapper.selectTxidGroupByAddress(protocol, RecordStatus.CONFIRMING.getVal());
        if (usdtWalletTransferVOS != null && usdtWalletTransferVOS.size() > 0) {
            for (TxIdGroupByAddressVO vo : usdtWalletTransferVOS) {
                String txid = vo.getTxids();
                try {
                    //erc20系列
                    if (protocol.equals(protocolType.ERC20.name()) || protocol.equals(protocolType.ARC20.name())) {
                        Web3j web3j = NodeUtil.web3j;
                        if (protocol.toUpperCase().equals(protocolType.ARC20.name())) {
                            web3j = NodeUtil.aaWeb3j;
                        }
                        TransactionVO transaction = null;
                        Transaction transactionInfo = EthUtil.getTransactionInfo(web3j, txid);
                        if (transactionInfo == null || StringUtils.isBlank(transactionInfo.getBlockHash()) || transactionInfo.getBlockHash()
                                .equals("0x0000000000000000000000000000000000000000000000000000000000000000")) {
                            continue;
                        }
                        //ETH
                        if (vo.getCoinKey().equals("ETH") || vo.getCoinKey().equals("AAA")) {
                            //解析ETH交易
                            Map<String, Object> ethTransactionInfo = EthUtil.getEthTransactionInfo(transactionInfo);
                            transaction = BeanUtil.copyMapProperties(ethTransactionInfo, TransactionVO.class);
                        } else {
                            Map<String, Object> tokenTransactionInfo = EthUtil.getTokenTransactionInfo(transactionInfo, web3j);
                            transaction = BeanUtil.copyMapProperties(tokenTransactionInfo, TransactionVO.class);
                            if (StringUtils.isNotBlank(vo.getAddress()) && !vo.getAddress().startsWith("0x")) {
                                vo.setAddress("0x" + vo.getAddress());
                            }
                            if (transaction != null
                                    && StringUtils.isNotBlank(transaction.getTo())
                                    && !transaction.getTo().startsWith("0x")) {
                                transaction.setTo("0x" + transaction.getTo());
                            }
                        }
                        //获取当前高度
                        BigInteger blockHeight = EthUtil.getBlockHeight(web3j);
                        //计算确认数
                        int confirmNum = blockHeight.intValue() - transaction.getHeight().intValue();
                        if (confirmNum >= 3) {
                            //更新为已确认
                            addressInfoMapper.updateWalletTransfer(vo.getId(), RecordStatus.CONFIRMED.getVal(), confirmNum, protocol);
                            logger.warn(protocol + "交易确认 txid: {},币种:{},数量:{},类型：{},id:{}", txid, vo.getCoinKey(), vo.getQty(), protocol, vo.getId());
                        }
                    }
                } catch (Exception e) {
                    logger.error(e.toString(), e);
                }
            }
        }
    }


}
