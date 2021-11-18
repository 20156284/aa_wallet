package com.wallet.job.util.trx;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.web3j.crypto.ECKeyPair;
import org.web3j.crypto.Keys;
import org.web3j.crypto.Wallet;
import org.web3j.crypto.WalletFile;
import org.web3j.protocol.ObjectMapperFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class TrxUtil {
    @Value("${trx.server.url}")
    private String url;
    private Logger log = LoggerFactory.getLogger(TrxUtil.class);
    private final static String usdt_trc20 = "TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t";
    HttpUtil h = new HttpUtil();

    /**
     * 功能描述: <br>
     * 〈创建TRX地址〉接口关闭
     *
     * @Author: tangjie
     * @Date: 2020年6月4日
     */
    public String getNewAddress() {
        Map<Object, Object> getNewAddressParam = new HashMap<Object, Object>();
        JSONObject json = sendHttpPost(url + "/wallet/generateaddress", JSON.toJSONString(getNewAddressParam));
        if (json.isEmpty()) {
            log.info("地址创建失败");
            return null;
        }
        log.info(json.toString());
        return json.toString();
    }


    /**
     * 功能描述: <br>
     * 〈创建一个转账的Transaction〉
     *
     * @param amount
     * @Param:toAddress 转账转出地址
     * @param:ownerAddress 转账转入地址
     * @Author: tangjie
     * @Date:2020年6月4日
     */

    public String createTransaction(String owner_address, String to_address, BigInteger amount, Long permission_id, Boolean visible) throws Exception {
        String transaction = "";
        Map<Object, Object> createTransactionParam = new HashMap<Object, Object>();
        createTransactionParam.put("owner_address", owner_address);
        createTransactionParam.put("to_address", to_address);
        createTransactionParam.put("amount", amount);
        createTransactionParam.put("permission_id", permission_id);
        createTransactionParam.put("visible", visible);
        JSONObject json = sendHttpPost(url + "/wallet/createtransaction", JSON.toJSONString(createTransactionParam));
        log.info("创建转账的Transaction返回信息:{}" + json.toString());
        if (json.getString("Error") != null) {
            log.info("创建转账的Transaction失败:{}" + json.getString("Error"));
            return transaction;
        }
        if (json != null) {
            transaction = json.toJSONString();
        }
        return transaction;
    }


    /**
     * 功能描述: <br>
     * 〈交易签名〉接口关闭
     *"http://3.225.171.164:8090"
     * @Param: transaction参数为创建交易原文
     * @param: privateKey 私钥
     * @Author: tangjie
     * @Date: 2020年6月4日
     */
    public JSONObject getTransactionSign(String transaction, String privateKey) {
        Map<Object, Object> getTransactionSignParam = new HashMap<Object, Object>();
        getTransactionSignParam.put("transaction", transaction);
        getTransactionSignParam.put("privateKey", privateKey);
        JSONObject json = sendHttpPost( url+"/wallet/gettransactionsign", JSON.toJSONString(getTransactionSignParam));
        log.info("交易签名返回信息:{}" + json.toString());
        if (json.getString("Error") != null) {
            return JSONObject.parseObject(json.getString("error"));
        }
        return json;
    }


    /**
     * 功能描述: <br>
     * 〈广播签名后的交易〉
     *
     * @param signature
     * @Param: txid
     * @param: rawData
     * @paramr awData
     * @Author: tangjie
     * @Date: 2020年6月5日
     */
    public String broadcastTransaction(String txid, JSONObject rawData, String rawDataHex, boolean visible, String[] signature) {
        String txId = "";
        Map<Object, Object> broadcastTransactionParam = new HashMap<Object, Object>();
        broadcastTransactionParam.put("txID", txid);
        broadcastTransactionParam.put("raw_data", rawData);
        broadcastTransactionParam.put("raw_data_hex", rawDataHex);
        broadcastTransactionParam.put("visible", visible);
        broadcastTransactionParam.put("signature", signature);
        JSONObject json = sendHttpPost(url + "/wallet/broadcasttransaction", JSON.toJSONString(broadcastTransactionParam));
        //log.info("广播交易返回信息:{}" + json.getString("Error"));
        if (json.getString("Error") != null) {
            return json.getString("error");
        }
        if (json != null && json.getString("txid") != null && json.getBoolean("result") != null) {
            if (json.getBoolean("result")) {
                txId = json.getString("txid");
            }
        }
        return txId;
    }

    /**
     * 功能描述: <br>
     * 〈快捷转账〉
     *
     * @Param: privateKey
     * @param: toAddress
     * @paramr amount
     * @Author: tangjie
     * @Date: 2020年6月5日
     */
    public String easyTransferByPrivate(String privateKey, String toAddress, BigInteger amount) throws Exception {
        Map<Object, Object> easyTransferByPrivateParam = new HashMap<Object, Object>();
        easyTransferByPrivateParam.put("privateKey", privateKey);
        easyTransferByPrivateParam.put("toAddress", toAddress);
        easyTransferByPrivateParam.put("amount", amount);
        JSONObject json = sendHttpPost(url + "/wallet/easytransferbyprivate", JSON.toJSONString(easyTransferByPrivateParam));
        if (json.getString("Error") != null) {
            log.info("广播交易失败" + json.getString("Error"));
            return json.getString("error");
        }
        log.info(json.toString() + "广播交易成功");
        return json.getString("txid").toString();
    }

    /**
     * 功能描述: <br>
     * 〈查询账号信息 余额 冻结 投票 时间等 地址为hex地址〉
     *
     * @Param: address
     * @param: visible
     * @Author: tangjie
     * @Date: 2020年6月5日
     */
    public BigDecimal getAccount(String address, boolean visible) {
        BigDecimal account = BigDecimal.ZERO;
        Map<Object, Object> getAccountParam = new HashMap<Object, Object>();
        getAccountParam.put("address", address);
        getAccountParam.put("visible", visible);
        JSONObject json = sendHttpPost(url + "/wallet/getaccount", JSON.toJSONString(getAccountParam));
        log.error("余额返回信息:{}", json);
        if (json.getString("Error") != null) {
            log.info("获取TRX余额失败:{}" + json.getString("Error"));
            return account;
        }
        if (json != null && json.get("balance") != null) {
            account = new BigDecimal(json.get("balance").toString());
        }
        return getAccountDivide(account);
    }

    /**
     * 功能描述: <br>
     * 〈格式化金额〉
     *
     * @Param: amount
     * @Author: tangjie
     * @Date:
     */
    public BigDecimal getAccountDivide(BigDecimal amount) {
        amount = amount.divide(new BigDecimal("1000000"));
        return amount;
    }

    public BigDecimal getAccountMultiply(BigDecimal amount) {
        amount = (amount.multiply(new BigDecimal("1000000"))).setScale(0, BigDecimal.ROUND_DOWN);
        return amount;
    }

    /**
     * 功能描述: <br>
     * 〈根据地址获取代币账户信息〉
     *
     * @Param: address
     * @Author: tangjie
     * @Date: 2020年6月5日
     */
    public BigDecimal getTokenAccountByAddress(String address, String contractAddress) {
        BigDecimal amount = BigDecimal.ZERO;
        JSONObject json = JSON.parseObject(h.get(url + "/v1/accounts/" + address));
        log.error("token余额返回信息:{}", json);
        if (json.getString("Error") != null) {
            return amount;
        }
        if (json != null) {
            Map<String, Object> mapReault = JsonUtil.GsonToMaps(json.toJSONString());
            List<Map<String, Object>> reault_data = (List<Map<String, Object>>) mapReault
                    .get("data");
            for (Map<String, Object> reault_data_trx : reault_data) {
                List<Map<String, Object>> reault_data_trx_erc20 = (List<Map<String, Object>>) reault_data_trx.get("trc20");
                if (reault_data_trx_erc20 != null) {
                    for (Map<String, Object> reault_data_trx_erc20_amount : reault_data_trx_erc20) {
                        if (reault_data_trx_erc20_amount.get(contractAddress) != null) {
                            return amount = getAccountDivide(new BigDecimal(reault_data_trx_erc20_amount.get(contractAddress).toString()));

                        }

                    }
                }

            }
        }
        return amount;
    }

    /**
     * 功能描述: <br>
     * 〈根据地址获取代币余额〉
     *
     * @Param: address
     * @Author: tangjie
     * @Date: 2020年6月5日
     */
    public BigDecimal getTokenAccountByAddress(JSONObject tokenAccountResult) throws Exception {
        BigDecimal amount = new BigDecimal("0");
        Map<String, Object> reault = JsonUtil.GsonToMaps(tokenAccountResult.toString());
        List<Map<String, Object>> reault_data = (List<Map<String, Object>>) reault
                .get("data");
        for (Map<String, Object> reault_data_trx : reault_data) {
            List<Map<String, Object>> reault_data_trx_erc20 = (List<Map<String, Object>>) reault_data_trx.get("trc20");
            if (reault_data_trx_erc20 != null) {
                for (Map<String, Object> reault_data_trx_erc20_amount : reault_data_trx_erc20) {
                    if (reault_data_trx_erc20_amount.get(usdt_trc20) != null) {
                        // amount = getAccount(new BigDecimal(reault_data_trx_erc20_amount.get(usdt_trc20).toString()));
                        log.info(amount.toString());
                    }

                }
            }

        }
        return amount;
    }

    /**
     * 功能描述: <br>
     * 〈查询账号的资源信息 带宽 能量等 地址为hex地址〉
     *
     * @Param: address
     * @param: visible
     * @Author: tangjie
     * @Date: 2020年6月5日
     */
    public BigDecimal getaAccountresource(String address, boolean visible) {
        BigDecimal accountresource = BigDecimal.ZERO;
        BigDecimal freeNetUsed = BigDecimal.ZERO;//已用宽带
        BigDecimal freeNetLimit = BigDecimal.ZERO;//总宽带
        Map<Object, Object> getaccountresourceParam = new HashMap<Object, Object>();
        getaccountresourceParam.put("address", address);
        getaccountresourceParam.put("visible", visible);
        JSONObject json = sendHttpPost(url + "/wallet/getaccountresource", JSON.toJSONString(getaccountresourceParam));
        log.error("宽带返回信息:{}", json);
        if (json.getString("Error") != null) {
            return accountresource;
        }
        if (json != null && json.get("freeNetLimit") != null && json.get("freeNetUsed") != null) {
            freeNetUsed = new BigDecimal(json.get("freeNetUsed").toString());
            freeNetLimit = new BigDecimal(json.get("freeNetLimit").toString());
            accountresource = freeNetLimit.subtract(freeNetUsed);
        }
        return accountresource;
    }

    /**
     * 功能描述: <br>
     * 〈trx_erc20代币转账〉
     *
     * @Param: 合约地址 合约方法 合约参数 trx手续费（sun） 本次调用转账的trx（sun） 调用方地址
     * @Author: tangjie
     * @Date: 2020年6月8日
     */
    public String triggersmartcontract(String contractAddress, String functionSelector, String parameter, Long feeLimit, Long callValue, String ownerAddress) throws Exception {
        String triggersmartcontract = "";
        Map<Object, Object> triggersmartcontractParam = new HashMap<Object, Object>();
        triggersmartcontractParam.put("contract_address", contractAddress);
        triggersmartcontractParam.put("function_selector", functionSelector);
        if (StringUtils.isNotBlank(parameter)) {
            triggersmartcontractParam.put("parameter", parameter);
        }
        triggersmartcontractParam.put("fee_limit", feeLimit);
        triggersmartcontractParam.put("call_value", callValue);
        triggersmartcontractParam.put("owner_address", ownerAddress);
        JSONObject json = sendHttpPost(url + "/wallet/triggersmartcontract", JSON.toJSONString(triggersmartcontractParam));
        log.info("构建trc20返回信息:{}" + json.toJSONString());
        if (json.getString("Error") != null) {
            return triggersmartcontract;
        }
        if (json != null) {
            triggersmartcontract = json.getString("transaction");
        }

        return triggersmartcontract;
    }

    /**
     * 功能描述: <br>
     * 〈获取最新高度〉
     *
     * @Author: tangjie
     * @Date: 2020年6月8日
     */
    public Map<String, Object> getNowBlock() {
        String blockHeight = "";
        Map<String, Object> block = new HashMap<String, Object>();
        Map<Object, Object> getNowBlock = new HashMap<Object, Object>();
        getNowBlock.put("visible", "true");
        JSONObject json = sendHttpPost(url + "/wallet/getnowblock", JSON.toJSONString(getNowBlock));
        if (json.getString("Error") != null) {
            log.info("获取最新高度" + json.getString("Error"));
            return block;
        }
        JSONObject block_header = null;
        if (json != null) {
            block_header = JSON.parseObject(json.get("block_header").toString());
        }
        JSONObject raw_data = null;
        if (block_header != null) {
            raw_data = JSON.parseObject(block_header.get("raw_data").toString());
            blockHeight = raw_data.get("number").toString();
        }
        block.put("BlockId", json.get("blockID").toString());
        block.put("blockHeight", blockHeight);
        return block;
    }
//    public String getnowblock() throws Exception {
//        String number = null;
//        Map<Object, Object> getNowBlock = new HashMap<Object, Object>();
//        getNowBlock.put("visible", "true");
//        JSONObject json = sendHttpPost(url + "/wallet/getnowblock", JSON.toJSONString(getNowBlock));
//        System.out.println(json);
//        if (json.getString("Error") != null) {
//            log.info("获取最新高度" + json.getString("Error"));
//            return json.getString("error").toString();
//        }
//        JSONObject block_header = null;
//        if (json != null) {
//            block_header = JSON.parseObject(json.get("block_header").toString());
//        }
//        JSONObject raw_data = null;
//        if (block_header != null) {
//            raw_data = JSON.parseObject(block_header.get("raw_data").toString());
//            number = raw_data.get("number").toString();
//        }
//        log.info(number);
//        return number;
//    }

    /**
     * 功能描述: <br>
     * 〈查询区块信息〉
     *
     * @Param startNum 起始块高度，包括此块,endNum 结束块高度，不包括该块
     * @Author: tangjie
     * @Date: 2020年6月8日
     */
    public JSONObject getBlockByLimitNext(BigInteger startNum, BigInteger endNum) throws Exception {
        Map<Object, Object> getBlockByLimitNext = new HashMap<Object, Object>();
        getBlockByLimitNext.put("startNum", startNum);
        getBlockByLimitNext.put("endNum", endNum);
        JSONObject json = sendHttpPost(url + "/wallet/getblockbylimitnext", JSON.toJSONString(getBlockByLimitNext));
        if (json.getString("Error") != null) {
            log.info("查询区块信息" + json.getString("Error"));
            return JSONObject.parseObject(json.getString("error"));
        }
        log.info(json.toString());
        return json;
    }

    /**
     * 功能描述: <br>
     * 〈查询区块信息〉
     *
     * @Param 通过高度查询块
     * @Author: tangjie
     * @Date: 2020年6月8日
     */
    public JSONObject getBlockByNum(BigInteger num) {
        Map<Object, Object> getBlockByNum = new HashMap<Object, Object>();
        getBlockByNum.put("num", num);
        JSONObject json = sendHttpPost(url + "/wallet/getblockbynum", JSON.toJSONString(getBlockByNum));
        if (json.getString("Error") != null) {
            log.info("查询区块信息:{}" + json.getString("Error"));
            return JSONObject.parseObject(json.getString("error"));
        }
        return json;
    }

    /**
     * 功能描述: <br>
     * 〈 根据交易txid查询交易的手续费 所在区块等信息〉
     *
     * @Param: value
     * @Author: tangjie
     * @Date: 2020年6月8日
     */

    public JSONObject getTransactionInfoById(String value) {
        Map<Object, Object> getTransactionInfoById = new HashMap<Object, Object>();
        getTransactionInfoById.put("value", value);
        JSONObject json = sendHttpPost(url + "/wallet/gettransactionbyid", JSON.toJSONString(getTransactionInfoById));
        if (json.getString("Error") != null) {
            log.info("通过哈希查询区块信息:{}" + json.getString("Error"));
            return JSONObject.parseObject(json.getString("error"));
        }
        log.info(json.toString());
        return json;
    }

    public JSONObject getTransactioninfoByid(String value) {
        Map<Object, Object> gettransactioninfobyid = new HashMap<Object, Object>();
        gettransactioninfobyid.put("value", value);
        JSONObject json = sendHttpPost(url + "/wallet/gettransactioninfobyid", JSON.toJSONString(gettransactioninfobyid));
        if (json.getString("Error") != null) {
            log.info("通过哈希查询区块信息:{}" + json.getString("Error"));
            return JSONObject.parseObject(json.getString("error"));
        }
        log.warn("查询区块信息返回:{}", json);
        return json;
    }

    /**
     * 功能描述: <br>
     * 〈根据txid 通过事件查询交易〉
     *
     * @Param: txid
     * @Author: tangjie
     * @Date: 2020年6月9日
     */
    public JSONObject getEventsTransactionById(String txid) {
        JSONObject json = JSON.parseObject(h.get(url + "/v1/transactions/" + txid + "/events"));
        if (json.getString("Error") != null) {
            log.info("获取代币交易信息失败" + json.getString("Error"));
            return JSONObject.parseObject(json.getString("error"));
        }
        log.info(json.toString());
        return json;

    }

    /**
     * 功能描述: <br>
     * 〈转换事件内地址〉
     *
     * @Author: tangjie
     * @Date: 2020年6月9日
     */
    public String convertEventsAddress(String hexAddress) {
        try {
            if (hexAddress.contains("0x")) {
                hexAddress = hexAddress.substring(2);
            }
            return TronUtil.hexStringTobase58check("41" + hexAddress);
        } catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    /**
     * 功能描述: <br>
     * 〈检查地址是否正确〉
     *
     * @Param: address
     * @Author: tangjie
     * @Date: 2020年6月9日
     */
    public Boolean validateAddress(String address) {
        Boolean validResult = false;
        Map<Object, Object> validateAddress = new HashMap<Object, Object>();
        validateAddress.put("address", address);
        try {
            validResult = sendHttpPost(url + "/wallet/validateaddress", JSON.toJSONString(validateAddress)).getBoolean("result");
        } catch (Exception e) {
            e.printStackTrace();
            return validResult;
        }
        return validResult;
    }

    /**
     * 功能描述: <br>
     * 〈HTTP请求,请求参数为json〉
     *
     * @param url  地址
     * @param body 参数
     * @Author: tangjie
     * @Date: 2020年6月4日
     */
    public JSONObject sendHttpPost(String url, String body) {
        String responseContent = null;
        try {
            CloseableHttpClient httpClient = HttpClients.createDefault();
            HttpPost httpPost = new HttpPost(url);
            httpPost.addHeader("Content-Type", "application/json");
            httpPost.setEntity(new StringEntity(body));
            CloseableHttpResponse response = httpClient.execute(httpPost);
            HttpEntity entity = response.getEntity();
            responseContent = EntityUtils.toString(entity, "UTF-8");
            response.close();
            httpClient.close();
        } catch (Exception e) {
            responseContent = e.getMessage();
        }
        return JSON.parseObject(responseContent);
    }


  /**
    * @Author XieChengJian
    *** get 请求
    * @Date  2021/7/14 14:43
   */
    public JSONObject sendHttpGet(String url) {
        String result = "";//访问返回结果
        BufferedReader read = null;//读取访问结果
        try {
            //创建url
            URL urlAddress = new URL(url);
            //打开连接
            HttpURLConnection connection = (HttpURLConnection) urlAddress.openConnection();
            // 设置通用的请求属性
            connection.setRequestProperty("accept", "*/*");
            connection.setRequestProperty("connection", "Keep-Alive");
            connection.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            //建立连接
            connection.connect();
            // 获取所有响应头字段
            Map<String, List<String>> map = connection.getHeaderFields();

            // 定义 BufferedReader输入流来读取URL的响应
            read = new BufferedReader(new InputStreamReader(
                    connection.getInputStream(), "UTF-8"));
            String line;//循环读取
            while ((line = read.readLine()) != null) {
                result += line;
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (read != null) {//关闭流
                try {
                    read.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return JSON.parseObject(result);
    }



    public String sendHttpGetBzzscan(String url) {
        String result = "";//访问返回结果
        BufferedReader read = null;//读取访问结果
        try {
            //创建url
            URL urlAddress = new URL(url);
            //打开连接
            HttpURLConnection connection = (HttpURLConnection) urlAddress.openConnection();
            // 设置通用的请求属性
            connection.setRequestProperty("accept", "*/*");
            connection.setRequestProperty("connection", "Keep-Alive");
            connection.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            connection.setConnectTimeout(20000);
            connection.setReadTimeout(20000);
            //建立连接
            connection.connect();
            // 获取所有响应头字段
            Map<String, List<String>> map = connection.getHeaderFields();

            // 定义 BufferedReader输入流来读取URL的响应
            read = new BufferedReader(new InputStreamReader(
                    connection.getInputStream(), "UTF-8"));
            String line;//循环读取
            while ((line = read.readLine()) != null) {
                result += line;
            }
        } catch (IOException e) {
            return null;
//            e.printStackTrace();
        } finally {
            if (read != null) {//关闭流
                try {
                    read.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return result;
    }


    /**
     * 功能描述: <br>
     * 〈离线生成地址〉
     *
     * @Param: [pwd]
     * @Author: tangjie
     * @Date: 2020/12/3 16:09
     */
    public Map<String, Object> newAddress(String pwd) {
        try {
            TronUtil tronUtil = new TronUtil();
            Map<String, Object> map = new HashMap<>();
            ObjectMapper objectMapper = ObjectMapperFactory.getObjectMapper();
            ECKeyPair ecKeyPair = Keys.createEcKeyPair();
            WalletFile walletFile = Wallet.createStandard(pwd, ecKeyPair);
            String keystore = objectMapper.writeValueAsString(walletFile);
            WalletFile walletFile2 = objectMapper.readValue(keystore, WalletFile.class);
            ECKeyPair ecKeyPair1 = Wallet.decrypt(pwd, walletFile2);
            map.put("address", tronUtil.hexStringTobase58check("41" + walletFile.getAddress()));
            map.put("privateKey", ecKeyPair1.getPrivateKey().toString(16));
            map.put("addressBase58", "41" + walletFile.getAddress());
            return map;
        } catch (Exception e) {
            e.printStackTrace();
            log.warn("TRX创建地址失败，错误代码：{}", new Object[]{e.getMessage()});
            return null;
        }
    }


    /**
     * 通过私钥获取41地址
     *
     * @param
     * @return
     */
//    public String getPrivateKeyToAddress(String privateKey) {
//        String address = Keys.toChecksumAddress(Keys.getAddress(ECKeyPair.create(Numeric.toBigInt(privateKey))));
//        return address.replace("0x", "41");
//    }
    public static void main(String[] args) throws Exception {
        //  TRX手续费收取规则：
        //  1. 若用户转账到TRX新地址（未转过账的地址），波场将收取最高0.1TRX的手续费；
        //  2. 若用户转账到TRX旧地址，波场将收取0.01TRX的手续费；
        //  3. TRX旧地址转账每天可享受几笔免费转账的优惠；

        TrxUtil m = new TrxUtil();
//        String privateKey = "e96c2705f18cd42235761bce4a5ca9f3b8a9db03c18a76f8a99421b1f900cef7";//私钥
//        String address = "TJ2o3CPYMgyjUzDSqqVzHxuw4q1VvAHv2C";//支付地址
//        String key="123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
//        System.out.println(new EncryptUtil().DESencode(privateKey,key));
//        System.out.println(new EncryptUtil().DESdecode("E98E8E7DC32F3C04EC57F2B791F4D308179621E592A559D63C52645AE22B20ED44AE66C63400ADC08F6DA8B4090E969EAC153418A5256226E31C0BB77959334D108C32B812DEC32D",key));
//          创建地址
//          String result = m.getNewAddress();

//  --------------------------------------TRX-转账-----------------------------------

//          创建一个转账的Transaction
//            JSONObject result =m.createTransaction("TJ2o3CPYMgyjUzDSqqVzHxuw4q1VvAHv2C","TQTaR5ToeCuiyH81JvssC9ZKYXwVSbKbXq",new BigInteger("100"),null,true);
        //交易签名
//            JSONObject resultBroadcastTransaction=m.getTransactionSign(result,privateKey);
        //广播签名后的交易
//            m.broadcastTransaction(resultBroadcastTransaction.getString("txID"),JSON.parseObject(resultBroadcastTransaction.getString("raw_data")),resultBroadcastTransaction.getString("raw_data_hex"), resultBroadcastTransaction.getBoolean("visible"),resultBroadcastTransaction.getJSONArray("signature").toArray(new String[]{}));
//            m.easyTransferByPrivate(privateKey,"TQTaR5ToeCuiyH81JvssC9ZKYXwVSbKbXq",new BigInteger("200"));
        //查询账号信息 余额 冻结 投票 时间等 地址为hex地址TRX
//            JSONObject accountResult=m.getAccount("TJ2o3CPYMgyjUzDSqqVzHxuw4q1VvAHv2C",true);
        //获取可用金额TRX
//            m.getAccount(new BigDecimal(accountResult.getString("balance")));
        //检查地址
//               log.info(m.validateAddress(address).toString());

//  --------------------------------------trx-usdt20-转账-----------------------------------
        //获取代币账户信息
        // JSONObject tokenAccountResult = m.getTokenAccountByAddress(address);
//            //获取trx_erc20余额
//            m.getTokenAccountByAddress(tokenAccountResult);

//            String toAddress = "TQTaR5ToeCuiyH81JvssC9ZKYXwVSbKbXq";//接收地址
//            BigDecimal sendAmount = new BigDecimal("0.01");//金额
//            //转换为hex地址
//            String hexAddress=TronUtil.base58ToHexString(address);
//            String hexToAddress = TronUtil.base58ToHexString(toAddress);
//            String addZeroHexAddress = TronUtil.zeroAdd(hexToAddress, 64);
//            String usdt_trx20_hex=TronUtil.base58ToHexString(usdt_trc20);
//            //转换为hex金额
//        String sendAmountStr = sendAmount.movePointRight(6).toString();
//        String addZeroHexSendAmount = TronUtil.zeroAdd(Long.toHexString(new Long(sendAmountStr)), 64);
//        //合约地址 合约方法 合约参数 trx手续费（sun） 本次调用转账的trx（sun） 调用方地址
//        String parameter = addZeroHexAddress + addZeroHexSendAmount;
//        JSONObject smartContractRequestResult = m.triggersmartcontract(usdt_trx20_hex, "transfer(address,uint256)", parameter, 1000000L, 0L, hexAddress);
//        //交易签名
//        JSONObject resultBroadcastTransaction = m.getTransactionSign(JSON.parseObject(smartContractRequestResult.getString("transaction")), privateKey);
//        //广播签名后的交易
//        m.broadcastTransaction(resultBroadcastTransaction.getString("txID"), JSON.parseObject(resultBroadcastTransaction.getString("raw_data")), resultBroadcastTransaction.getString("raw_data_hex"), resultBroadcastTransaction.getBoolean("visible"), resultBroadcastTransaction.getJSONArray("signature").toArray(new String[]{}));

//  --------------------------------------资产同步-----------------------------------
        //按交易哈希查询交易 5fbe9bbd67521412aec9a762121bac2396ad0ea76ac073f2d4296de5e16ebf90
//            m.getTransactionInfoById("a0830eaf7985ef26ccdb6cda9de408950e5bea497059465cd6288d2ada062b9b");
        //获取最新高度
//            BigInteger endNum=new BigInteger(m.getnowblock());
//             System.out.println(endNum);
//        String address_hex = TronUtil.base58ToHexString("TQTaR5ToeCuiyH81JvssC9ZKYXwVSbKbXq");
//        String usdt_trx20_hex = TronUtil.base58ToHexString(usdt_trc20);
//        BigInteger endNum = new BigInteger("20358990");
//        BigInteger startNum = new BigInteger("20358989");
//            BigInteger endNum=new BigInteger("20334485");
//            BigInteger startNum=new BigInteger("20334484");
//              //同步数据
//        JSONObject jsonObject = m.getBlockByLimitNext(startNum, endNum);
//        Map<String, Object> result = JsonUtil.GsonToMaps(jsonObject.toString());
//        List<Map<Object, Object>> block = (List<Map<Object, Object>>) result.get("block");
//        if (block != null) {
//            for (Map<Object, Object> transactions : block) {
//                List<Map<Object, Object>> raw_data = (List<Map<Object, Object>>) transactions.get("transactions");
//                if (raw_data != null) {
//                    for (Map<Object, Object> r : raw_data) {
////                            log.info(r.get("txID").toString());
//                        Map<Object, Object> result_raw_data = (Map<Object, Object>) r.get("raw_data");
//                        List<Map<Object, Object>> contract = (List<Map<Object, Object>>) result_raw_data.get("contract");
//                        if (contract != null) {
//                            for (Map<Object, Object> parameter : contract) {
//                                Map<Object, Object> value = (Map<Object, Object>) parameter.get("parameter");
//                                String type = parameter.get("type").toString();
//                                Map<Object, Object> values = (Map<Object, Object>) value.get("value");
//                                if (values.get("to_address") != null) {//trx
//                                    String to_address = values.get("to_address").toString();
//                                    if (to_address.equals(address_hex) && values.get("amount") != null && values.get("data") == null) {
//                                        BigDecimal amount = new BigDecimal(values.get("amount").toString()).setScale(0, BigDecimal.ROUND_HALF_UP);
//                                        m.getAccount(amount);
//                                    }
//                                }
//                                if (values.get("contract_address") != null && values.get("data") != null) {//TRC20
//                                    String to_address = "";
//                                    String contract_address = values.get("contract_address").toString();
//                                    if (contract_address.equals(usdt_trx20_hex)) {
//                                        JSONObject jsonObjectData = m.getEventsTransactionById(r.get("txID").toString());
//                                        Map<String, Object> resultData = JsonUtil.GsonToMaps(jsonObjectData.toString());
//                                        List<Map<Object, Object>> data = (List<Map<Object, Object>>) resultData.get("data");
//                                        if (data != null && resultData.get("success") != null && resultData.get("success").toString().equals("true")) {
//                                            for (Map<Object, Object> dataResult : data) {
//                                                Map<Object, Object> to = (Map<Object, Object>) dataResult.get("result");
//                                                if (to.get("to") != null) {
//                                                    to_address = m.convertEventsAddress(to.get("to").toString());
//                                                    if (!StringUtils.isBlank(to_address) && to_address.equals("TQTaR5ToeCuiyH81JvssC9ZKYXwVSbKbXq")) {
//                                                        BigDecimal amount = new BigDecimal(to.get("value").toString()).setScale(0, BigDecimal.ROUND_HALF_UP);
//                                                        m.getAccount(amount);
//                                                    }
//                                                }
//                                            }
//                                        }
//
//                                    }
//                                }
//
//                            }
//                        }
//                    }
//                }
//            }
//        }

    }


}
