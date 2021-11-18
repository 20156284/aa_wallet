package com.wallet.job.util;

import com.github.pagehelper.PageInfo;
import lombok.Data;

import java.util.List;

@Data
public class PageResultResponse {
    private int code;
    private String msg;
    private int count;
    private List<?> data;

    public PageResultResponse(PageInfo<?> data) {
        this.code=0;
        this.msg="成功";
        this.data = data.getList();
        this.count=Integer.parseInt(data.getTotal()+"");
    }
}