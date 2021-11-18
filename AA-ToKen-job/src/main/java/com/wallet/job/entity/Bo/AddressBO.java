package com.wallet.job.entity.Bo;


import java.math.BigDecimal;

public class AddressBO {
    /**
     * 应用id
     */
    private String appId;
    /**
     * 用户ID
     */
    private String userId;
    /**
     * 类型
     */
    private String protocol;
    /**
     * 币种
     */
    private String coinKey;
    /**
     * 加密后的秘钥串
     */
    private String sign;
    /**
     * 签名时间
     */
    private String time;

    /**
     * 数量
     */
    private String number;

    /**
     * 提币地址
     */
    private String toAddress;
    /**
     * 订单号
     */
    private String transferNo;

    public String getTransferNo() {
        return transferNo;
    }

    public void setTransferNo(String transferNo) {
        this.transferNo = transferNo;
    }

    public String getToAddress() {
        return toAddress;
    }

    public void setToAddress(String toAddress) {
        this.toAddress = toAddress;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public String getCoinKey() {
        return coinKey;
    }

    public void setCoinKey(String coinKey) {
        this.coinKey = coinKey;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getProtocol() {
        return protocol;
    }

    public void setProtocol(String protocol) {
        this.protocol = protocol;
    }
}
