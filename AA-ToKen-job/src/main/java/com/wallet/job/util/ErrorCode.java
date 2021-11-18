package com.wallet.job.util;

import java.util.HashMap;
import java.util.Map;

public final class ErrorCode {
    public static final int SYS_ERROR = 10000;
    public static final int PARAMETER_ERROR = 10001;
    public static final int APPID_NO_ERROR = 10002;
    public static final int COINKEY_NO_ERROR = 10003;
    public static final int AUTOGRAPH_NO_ERROR = 10004;
    public static final int WITHDRAWAL_NO_ERROR = 10005;
    public static final int ADDRESS_NO_ERROR = 10006;
    public static final int AMOUNT_GS_NO_ERROR = 10007;
    public static final int AMOUNT_NO_ERROR = 10008;
    public static final int AMOUNT_FEE_NO_ERROR = 10009;
    public static final int TRANSFERNO_ERROR = 10010;
    public static final int NEW_ADDRESS_ERROR = 10011;
    public static final int MNEMONIC_ADDRESS_ERROR = 10012;
    public static final int PRIVATEKEY_ADDRESS_ERROR = 10013;
    private static final Map<Integer, String> errorMap_zh = new HashMap<>();//中文

    static {
        errorMap_zh.put(SYS_ERROR, "系统繁忙");
        errorMap_zh.put(PARAMETER_ERROR, "参数错误");
        errorMap_zh.put(APPID_NO_ERROR, "不支持的appId");
        errorMap_zh.put(COINKEY_NO_ERROR, "不支持的的币种");
        errorMap_zh.put(AUTOGRAPH_NO_ERROR, "签名错误");
        errorMap_zh.put(WITHDRAWAL_NO_ERROR, "转账失败");
        errorMap_zh.put(ADDRESS_NO_ERROR, "地址是无效地址");
        errorMap_zh.put(AMOUNT_GS_NO_ERROR, "提币数量格式错误");
        errorMap_zh.put(AMOUNT_NO_ERROR, "余额不足");
        errorMap_zh.put(AMOUNT_FEE_NO_ERROR, "手续费不足");
        errorMap_zh.put(TRANSFERNO_ERROR, "订单已存在");
        errorMap_zh.put(NEW_ADDRESS_ERROR, "创建地址失败");
        errorMap_zh.put(MNEMONIC_ADDRESS_ERROR, "恢复地址失败");
        errorMap_zh.put(PRIVATEKEY_ADDRESS_ERROR, "私钥错误");
    }

    public static String getMsg(int code) {
        return errorMap_zh.get(code);
    }

    private static final Map<Integer, String> successMap_zh = new HashMap<>();//中文
}
