package com.wallet.job.util.eth;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.web3j.abi.FunctionEncoder;
import org.web3j.abi.FunctionReturnDecoder;
import org.web3j.abi.TypeReference;
import org.web3j.abi.datatypes.Function;
import org.web3j.abi.datatypes.Type;
import org.web3j.abi.datatypes.generated.Uint256;
import org.web3j.abi.datatypes.generated.Uint8;
import org.web3j.crypto.Credentials;
import org.web3j.crypto.RawTransaction;
import org.web3j.crypto.TransactionEncoder;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.DefaultBlockParameterName;
import org.web3j.protocol.core.methods.request.Transaction;
import org.web3j.protocol.core.methods.response.EthCall;
import org.web3j.protocol.core.methods.response.EthGetBalance;
import org.web3j.utils.Convert;
import org.web3j.utils.Numeric;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.ExecutionException;

public class XdaiUtil {
    private static Logger logger = LoggerFactory.getLogger(XdaiUtil.class);

    /**
     * 取eth余额
     *
     * @param address 传入查询的地址
     * @return String 余额
     */
    public  String getBalance(Web3j web3j, String address) {
        EthGetBalance ethGetBlance = null;
        try {
            ethGetBlance = web3j.ethGetBalance(address, DefaultBlockParameterName.LATEST).send();
        } catch (Exception e) {
            logger.error("【获取ETH余额失败】 错误信息: {}", e);
        }
        // 格式转换 WEI(币种单位) --> ETHER
        String balance = Convert.fromWei(new BigDecimal(ethGetBlance.getBalance()), Convert.Unit.ETHER).toPlainString();
        return balance;
    }
    /**
     * 获取账户代币余额
     *
     * @param account     账户地址
     * @param coinAddress 代币地址
     * @return 代币余额 （单位：代币最小单位）
     */
    public static String getBalanceOfCoin(Web3j web3j, String account, String coinAddress) {
        int decimal = getTokenDecimal(web3j, coinAddress);
        Function balanceOf = new Function("balanceOf",
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Address(account)),
                Arrays.<TypeReference<?>>asList(new TypeReference<Uint256>() {
                }));

        if (coinAddress == null) {
            return null;
        }
        String value = null;
        try {
            value = web3j.ethCall(Transaction.createEthCallTransaction(account, coinAddress, FunctionEncoder.encode(balanceOf)), DefaultBlockParameterName.PENDING).send().getValue();
        } catch (IOException e) {
            logger.error("【获取合约代币余额失败】 错误信息: {}", e);
            return null;
        }
        if (value.equalsIgnoreCase("0x")) {
            return BigDecimal.ZERO.toPlainString();
        }
        BigDecimal balance = new BigDecimal(new BigInteger(value.substring(2), 16).toString(10)).divide(BigDecimal.valueOf(Math.pow(10, decimal)));
        return balance.toPlainString();
    }

    public static final int getTokenDecimal(Web3j web3j, String contractAddr) {
        String methodName = "decimals";
        List<Type> inputParameters = new ArrayList<>();
        List<TypeReference<?>> outputParameters = new ArrayList<>();

        TypeReference<Uint8> typeReference = new TypeReference<Uint8>() {
        };
        outputParameters.add(typeReference);

        Function function = new Function(methodName, inputParameters, outputParameters);

        String data = FunctionEncoder.encode(function);
        Transaction transaction = Transaction.createEthCallTransaction("0x0000000000000000000000000000000000000000", contractAddr, data);

        EthCall ethCall = null;
        try {
            ethCall = web3j.ethCall(transaction, DefaultBlockParameterName.LATEST).sendAsync().get();
        } catch (InterruptedException e) {
            logger.error("【获取精度失败】 请求中断，错误信息： {}", e);
            return 0;
        } catch (ExecutionException e) {
            logger.error("【获取精度失败】 执行合约方法失败，错误信息: {}", e);
            return 0;
        }
        List<Type> results = FunctionReturnDecoder.decode(ethCall.getValue(), function.getOutputParameters());
        if (null == results || 0 == results.size()) {
            return 0;
        }
        //logger.warn("【获取精度信息】results：{}", JSON.toJSONString(results));
        return Integer.parseInt(results.get(0).getValue().toString());
    }

    /**
     * 发送eth离线交易
     *
     * @param from        eth持有地址
     * @param to          发送目标地址
     * @param amount      金额（单位：eth）
     * @param credentials 秘钥对象
     * @return 交易hash
     */
    public static String sendEthRawTransaction(Web3j web3j, String from, String to, BigInteger gasLimit,
                                               BigInteger gasPrice, BigDecimal amount, Credentials credentials) {

        try {
            BigInteger nonce = web3j.ethGetTransactionCount(from, DefaultBlockParameterName.PENDING).send().getTransactionCount();

            BigInteger amountWei = Convert.toWei(amount, Convert.Unit.ETHER).toBigInteger();

            RawTransaction rawTransaction = RawTransaction.createTransaction(nonce, gasPrice, gasLimit, to, amountWei, "");

            byte[] signMessage = TransactionEncoder.signMessage(rawTransaction, (byte) 100, credentials);

            return web3j.ethSendRawTransaction(Numeric.toHexString(signMessage)).send().getTransactionHash();
        } catch (Exception e) {
            logger.error("【ETH离线转账失败】 错误信息: {}", e.getMessage());
            return null;
        }
    }

    /**
     * 估算gasPrice
     */
    public static BigInteger getEthTransactionGasPrice(Web3j web3j) {
        try {
            return web3j.ethGasPrice().send().getGasPrice();
        } catch (Exception e) {
            logger.error("【估算gasPrice失败】 错误信息: {}", e);
        }
        return new BigInteger("12000");
    }

    public static BigInteger getEthTransactionGasLimit(Web3j web3j, String from, String to, BigDecimal amount) {
        try {
            return web3j.ethEstimateGas(new Transaction(from, null, null, null, to, Convert.toWei(amount, Convert.Unit.WEI).toBigInteger(), null)).send().getAmountUsed();
        } catch (Exception e) {
            logger.error("【估算交易gas值势必】 错误信息： {}", e);
        }
        return new BigInteger("10000");
    }

}