package com.wallet.job.service;

import com.wallet.job.entity.Bo.AddressBO;

import java.util.Map;

public interface WalletService {
    /**
     * @description: 添加地址
     * @return:
     * @author: huoche
     * @time: 2021/11/18 14:29
     */
    Map<String, Object> addAddress(AddressBO addressBO);

}
