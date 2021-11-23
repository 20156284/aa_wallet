package com.wallet.job.service;

public interface Erc20Service {
    /**
     * 扫块
     *
     * @return
     */
    void blockChainSweepingErc20(String protocol);

    /**
     * 充币回查
     */
    void rechargeCallback(String protocol);

}
