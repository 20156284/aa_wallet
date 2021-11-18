package com.wallet.job.benum;

/**
 * 记录类型枚举
 */
public enum RecordType {

    RECHARGE((byte) 10), // 充值

    WITHDRAW((byte) 20);// 提币

    private byte val;

    RecordType(byte val) {
        this.val = val;
    }

    public byte getVal() {
        return val;
    }

    public void setVal(byte val) {
        this.val = val;
    }
}