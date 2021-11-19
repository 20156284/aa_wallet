package com.wallet.job.entity.Bo;


public class AddressBO {
    /**
     * 类型
     */
    private String protocol;
    /**
     * 地址
     */
    private String address;

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
