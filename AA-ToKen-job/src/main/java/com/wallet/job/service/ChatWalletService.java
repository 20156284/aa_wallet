package com.wallet.job.service;


public interface ChatWalletService {
    /**
     * 验证appId是否存在
     */
     Integer getWalletAppid(String appId);
}
