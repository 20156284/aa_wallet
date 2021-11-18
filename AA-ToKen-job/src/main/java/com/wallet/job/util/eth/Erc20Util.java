package com.wallet.job.util.eth;


import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;

public class Erc20Util {

    public static boolean isTransferFunc(String input) {
        return input.length() >= 10 && input.substring(2, 10).equals("a9059cbb");
    }

    public static String getToAddress(String input) {
        // input 合约地址 字段的编码规则为：0x + 函数名(8个字节） + 转出地址（64个字节）+ 转出值（64个字节）
        if (input.length() >= 74) {
            return input.substring(34, 74);
        }
        return null;
    }

    public static BigDecimal getTransferValue(String input, int decimal) throws Exception {
        try {
            if (input.length() >= 138) {
                String strHexValue = input.substring(74, 138);
                String transferValue = new BigInteger(strHexValue, 16).toString(10);
                return new BigDecimal(transferValue).setScale(4, RoundingMode.DOWN).divide(BigDecimal.valueOf(Math.pow(10, decimal)), RoundingMode.DOWN);
            }
            return null;
        } catch (NumberFormatException e) {
            throw new Exception(e.getMessage());
        }
    }
}
