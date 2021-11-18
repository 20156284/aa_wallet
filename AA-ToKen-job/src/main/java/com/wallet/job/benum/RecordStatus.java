package com.wallet.job.benum;

public enum RecordStatus {

    WAIT_PACKING((byte) 30), // 待打包
    CONFIRMING((byte) 40), // 确认中
    CONFIRMED((byte) 50), // 已确认
    CONFIRM_FAIL((byte) 60);// 确认失败，

    private byte val;

    RecordStatus(byte val) {
        this.val = val;
    }

    public byte getVal() {
        return val;
    }

    public void setVal(byte val) {
        this.val = val;
    }
}
