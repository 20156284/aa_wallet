package com.wallet.job.entity.Bo;

public class ChatAddressBO {
    /**
     * 类型
     */
    private String protocol;

    /**
     * 助记词
     */
    private String mnemonic;

    /**
     * 类型 1:创建地址；2：助记词恢复地址
     */
    private int type;

    /**
     * 私钥
     *
     * @return
     */
    private String privateKey;

    /**
     * 币种
     */
    private String coinKey;

    /**
     * 数量
     */
    private String number;

    /**
     * from地址
     */
    private String fromAddress;

    /**
     * to地址
     */
    private String toAddress;
    /**
     * appId
     */
    private String appId;
    /**
     * 地址
     */
    private String address;

    /**
     * 交易类型
     */
    private String transferType;

    /**
     * 交易状态
     */
    private String transferStatus;

    public String getTransferType() {
        return transferType;
    }

    public void setTransferType(String transferType) {
        this.transferType = transferType;
    }

    public String getTransferStatus() {
        return transferStatus;
    }

    public void setTransferStatus(String transferStatus) {
        this.transferStatus = transferStatus;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getFromAddress() {
        return fromAddress;
    }

    public void setFromAddress(String fromAddress) {
        this.fromAddress = fromAddress;
    }

    public String getToAddress() {
        return toAddress;
    }

    public void setToAddress(String toAddress) {
        this.toAddress = toAddress;
    }

    public String getPrivateKey() {
        return privateKey;
    }

    public void setPrivateKey(String privateKey) {
        this.privateKey = privateKey;
    }

    public String getProtocol() {
        return protocol;
    }

    public void setProtocol(String protocol) {
        this.protocol = protocol;
    }

    public String getMnemonic() {
        return mnemonic;
    }

    public void setMnemonic(String mnemonic) {
        this.mnemonic = mnemonic;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
}
