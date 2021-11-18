package com.wallet.job.service;

import com.wallet.job.entity.Bo.ChatAddressBO;

import java.util.Map;

public interface Trc20Service {
    /**
     * 创建地址
     *
     * @return
     */
    Map<String, Object> newAddress(ChatAddressBO chatAddressBO);

    /**
     * @Description: 私钥恢复地址
     * @Author:huoche
     * @Date: 2021/7/7
     * @Param:
     * @Return:
     */
    Map<String, Object> getAddress(ChatAddressBO chatAddressBO);

    /**
     * @Description: 转账
     * @Author:huoche
     * @Date: 2021/7/7
     * @Param:
     * @Return:
     */
    Map<String, Object> chatWalletTransfer(ChatAddressBO chatAddressBO);

    /**
     * @Description: 获取余额
     * @Author:huoche
     * @Date: 2021/7/7
     * @Param:
     * @Return:
     */

    Map<String, Object> chatWalletgetBalance(ChatAddressBO chatAddressBO);

    /** @Author huoche
     * @Description 删除地址
     * @Date 15:28 2021/7/12
     * @Param
     * @return
     **/
    Map<String, Object> deleteAddress(ChatAddressBO chatAddressBO);

    /** @Author huoche
     * @Description //查询交易记录
     * @Date 16:23 2021/7/12
     * @Param
     * @return
     **/
    Map<String, Object> getTransfer(ChatAddressBO chatAddressBO);

    /**
     * 扫块
     *
     * @return
     */
    void blockChainSweepingTrc20(String protocol);

    /**
     * 充币回查
     */
    void rechargeCallback(String protocol);



}
