package com.wallet.job.util.trx;

import java.util.Stack;

public class TronUtil {
    public static Long HexToLongDecimal(String s) {
        return Long.parseLong(s, 16);
    }

    public static String convertDecimalToBinary(int value) {
        Stack<Integer> s = new Stack<Integer>();
        int n = value;
        String e = "";
        while (n != 0) {
            s.push(n % 16);
            n = n / 8;
        }
        while (s.size() != 0) {
            int c = s.pop();
            if (c >= 10)
                e += (char) ((int) ('A') + (c - 10));
            else
                e += c;
        }
        return e;
    }

    /**
     * 16进制转换成为string类型字符串
     *
     * @param s
     * @return
     */
    public static String hexStringToString(String s) {
        if (s == null || s.equals("")) {
            return null;
        }
        s = s.replace(" ", "");
        byte[] baKeyword = new byte[s.length() / 2];
        for (int i = 0; i < baKeyword.length; i++) {
            try {
                baKeyword[i] = (byte) (0xff & Integer.parseInt(s.substring(i * 2, i * 2 + 2), 16));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        try {
            s = new String(baKeyword, "UTF-8");
            new String();
        } catch (Exception e1) {
            e1.printStackTrace();
        }
        return s;
    }

    /**
     * 字符串转换为16进制字符串
     *
     * @param s
     * @return
     */
    public static String stringToHexString(String s) {
        String str = "";
        for (int i = 0; i < s.length(); i++) {
            int ch = s.charAt(i);
            String s4 = Integer.toHexString(ch);
            str = str + s4;
        }
        return str;
    }

    /**
     * 功能描述: <br>
     * 〈 base58地址转换hex地址〉T->41
     *
     * @Param:
     * @Author: tangjie
     * @Date:
     */
    public static String base58ToHexString(String base58Address) {
        return bytes2HexStr(Base58.decode(base58Address)).substring(0, 42).toLowerCase();
    }

    /**
     * 功能描述: <br>
     * 〈hex地址转换base58地址〉41->T
     *
     * @Param:
     * @Author: tangjie
     * @Date:
     */
    public static String hexStringTobase58check(String hexAddress) {
        return encode58Check(ByteArray.fromHexString(hexAddress));
    }

    public static String encode58Check(byte[] input) {
        byte[] hash0 = Sha256Hash.hash(true, input);
        byte[] hash1 = Sha256Hash.hash(true, hash0);
        byte[] inputCheck = new byte[input.length + 4];
        System.arraycopy(input, 0, inputCheck, 0, input.length);
        System.arraycopy(hash1, 0, inputCheck, input.length, 4);
        return Base58.encode(inputCheck);
    }

    public static String bytes2HexStr(byte[] byteArr) {
        String hexString = "0123456789ABCDEF";
        StringBuilder sb = new StringBuilder(byteArr.length * 2);
        for (int i = 0; i < byteArr.length; i++) {
            sb.append(hexString.charAt((byteArr[i] & 0xf0) >> 4));
            sb.append(hexString.charAt((byteArr[i] & 0x0f) >> 0));
        }
        return sb.toString();

    }

    public static String zeroAdd(String string, int data) {
        String newString = "";
        String zero = "";
        int strlength = string.length();
        if (strlength >= data) {
            newString = string.substring(0, data);
        } else {
            int i = data - strlength;
            for (int j = 0; j < i; j++) {
                zero = zero + "0";
            }
            newString = zero + string;
        }
        return newString;
    }


}
