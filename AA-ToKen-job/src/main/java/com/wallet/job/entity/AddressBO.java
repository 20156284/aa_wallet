package com.wallet.job.entity;


public class AddressBO {
    /**
     * 类型
     */
    private String protocol;
    /**
     * 地址
     */
    private String address;
    /**
     * type 1 主链币；2：代币
     */
    private String type;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getProtocol() {
        return protocol;
    }

    public void setProtocol(String protocol) {
        this.protocol = protocol;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
