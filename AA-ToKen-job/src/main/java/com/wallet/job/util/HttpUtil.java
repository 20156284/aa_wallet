package com.wallet.job.util;

import com.google.gson.Gson;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;

public class HttpUtil {

    /**
     * 需要独立返回json数据时
     *
     * @param request
     * @param response
     * @param code
     */
    public static void writeError(HttpServletRequest request, HttpServletResponse response, int code) {
        PrintWriter write = null;
        try {
            response.setHeader("Content-type", "text/html;charset=UTF-8");
            write = response.getWriter();
            String data = new Gson().toJson(returnData(null, code));
            write.write(data);
        } catch (RuntimeException e) {

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (write != null) {
                write.close();
            }
        }
    }

    /**
     * 自定义错误消息
     *
     * @param request
     * @param response
     * @param msg
     */
    public static void writeError(HttpServletRequest request, HttpServletResponse response, String msg) {
        PrintWriter write = null;
        try {
            response.setHeader("Content-type", "text/html;charset=UTF-8");
            write = response.getWriter();
            String data = new Gson().toJson(commError(msg));
            write.write(data);
        } catch (RuntimeException e) {

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (write != null) {
                write.close();
            }
        }
    }

    /**
     * 输出数据
     *
     * @param request
     * @param response
     * @param resultData
     */
    public static void writeData(HttpServletRequest request, HttpServletResponse response,
                                 Map<String, Object> resultData) {
        PrintWriter write = null;
        try {
            response.setHeader("Content-type", "text/html;charset=UTF-8");
            write = response.getWriter();
            String data = new Gson().toJson(resultData);
            write.write(data);
        } catch (RuntimeException e) {

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (write != null) {
                write.close();
            }
        }
    }

    /**
     * 通用返回数据
     *
     * @param data
     * @param code
     * @return
     */
    public static Map<String, Object> returnData(Map<String, Object> data, int code) {
        Map<String, Object> returnData = new HashMap<>();
        returnData.put("data", data == null ? new HashMap<>() : data);
        returnData.put("retcode", code >= 10000 ? code : 0);
        returnData.put("msg", code >= 10000 ? ErrorCode.getMsg(code) : SuccessCode.getMsg(code));
        return returnData;
    }

    public static Map<String, Object> returnData(Object data, int code) {
        Map<String, Object> returnData = new HashMap<>();
        returnData.put("data", data == null ? new HashMap<>() : data);
        returnData.put("retcode", code >= 10000 ? code : 0);
        returnData.put("msg", code >= 10000 ? ErrorCode.getMsg(code) : SuccessCode.getMsg(code));
        return returnData;
    }

    /**
     * 通用返回数据
     *
     * @param data
     * @param code
     * @return
     */
    public static Map<String, Object> returnData(Map<String, Object> data, int code, String extInfo) {
        Map<String, Object> returnData = new HashMap<>();
        returnData.put("data", data == null ? new HashMap<>() : data);
        returnData.put("retcode", code >= 10000 ? code : 0);
        returnData.put("msg", code >= 10000 ? ErrorCode.getMsg(code) + ": " + extInfo : SuccessCode.getMsg(code));
        return returnData;
    }

    /**
     * 通用返回数据
     *
     * @return
     */
    public static Map<String, Object> commError(String msg) {
        Map<String, Object> returnData = new HashMap<>();
        returnData.put("data", new HashMap<>());
        //returnData.put("retcode", ErrorCode.SYS_COMM_ERROR);
        returnData.put("msg", msg);
        return returnData;
    }

    private static final SecureRandom random = new SecureRandom();

    public static String newVerifyCode() {
        char[] value = new char[4];
        for (int i = 0; i < 4; i++) {
            value[i] = ((char) (random.nextInt(10) + 48));
        }
        final String displayValue = new String(value);
        return displayValue;
    }
}
