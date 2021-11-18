package com.wallet.job.util;

import lombok.Data;

@Data
public class ResultResponse {
    private int code;
    private String msg;
    private Object data;

    public ResultResponse(int code, String msg, Object data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public ResultResponse(Object data) {

        if(data instanceof Boolean){
            if((Boolean) data){
                this.code=0;
                this.msg = "成功";
            }else{
                this.code=-1;
                this.msg = "失败";
            }
        }

        this.code = 0;
        this.msg = "成功";
        this.data = data;
    }
}
