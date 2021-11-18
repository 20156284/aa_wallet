package com.wallet.job.util;

import java.util.HashMap;
import java.util.Map;

public final class SuccessCode {

    public static final int SUCCESS = 0;


    private static final Map<Integer, String> successMap_zh = new HashMap<>();//中文

    static {
        successMap_zh.put(SUCCESS, "成功");
    }

    /**
     * @param
     * @return
     */
    public static String getMsg(int code) {
        return successMap_zh.get(code);
    }
}
