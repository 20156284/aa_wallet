package com.wallet.job.entity;

public class TxIdGroupByAddressVO {
    private Integer id;
    private String appId;
    private String userId;
    private String transferNo;
    private Byte transferType;
    private String coinKey;
    private String fromAddress;
    private String address;
    private String txids;
    private String qty;
    private String protocol;
    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getTransferNo() {
        return transferNo;
    }

    public void setTransferNo(String transferNo) {
        this.transferNo = transferNo;
    }

    public Byte getTransferType() {
        return transferType;
    }

    public void setTransferType(Byte transferType) {
        this.transferType = transferType;
    }

    public String getFromAddress() {
        return fromAddress;
    }

    public void setFromAddress(String fromAddress) {
        this.fromAddress = fromAddress;
    }

    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }

    private Byte status;


    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTxids() {
        return txids;
    }

    public void setTxids(String txids) {
        this.txids = txids;
    }

    public String getQty() {
        return qty;
    }

    public String getCoinKey() {
        return coinKey;
    }

    public void setCoinKey(String coinKey) {
        this.coinKey = coinKey;
    }

    public void setQty(String qty) {
        this.qty = qty;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getProtocol() {
        return protocol;
    }

    public void setProtocol(String protocol) {
        this.protocol = protocol;
    }
}
