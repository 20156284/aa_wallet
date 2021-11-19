package com.wallet.job.service;

import com.wallet.job.entity.AddressBO;

import java.util.Map;

public interface WalletService {
    /**
     * @description: 添加地址
     * @return:
     * @author: huoche
     * @time: 2021/11/18 14:29
     */
    Map<String, Object> addAddress(AddressBO addressBO);
    /**
     * @description: 支持币种
     * @return: type 1 主链币；2：代币
     * @author: huoche
     * @time: 2021/11/19 11:45
     */
    Map<String, Object> getCoinKey(AddressBO addressBO);
}
