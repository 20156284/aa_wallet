package com.wallet.job.service;

import com.github.pagehelper.PageInfo;
import com.wallet.job.entity.Bo.BzzDataCenter;
import com.wallet.job.entity.Bo.BzzPeers;
import com.wallet.job.entity.Bo.BzzPrice;
import com.wallet.job.entity.WalletBzz;
import com.wallet.job.entity.WalletBzzNode;

import java.util.List;

public interface WalletBzzService {
    /**
     * @description: 查询BZZ节点列表
     * @return:
     * @author: huoche
     * @time: 2021/7/19 11:59
     */
    PageInfo<WalletBzz> getPageList(WalletBzz walletBzz, int pageNo, int pageSize);

    /**
     * @description: 节点分布-饼图统计
     * @return:
     * @author: huoche
     * @time: 2021/7/19 14:58
     */
    List<WalletBzzNode> selectList(WalletBzzNode walletBzzNode);

    /**
     * @description: 数据中心-饼图统计
     * @return:
     * @author: huoche
     * @time: 2021/7/19 15:23
     */
    List<BzzDataCenter> dataCentre(WalletBzz walletBzz);

    /**
     * @description: 价格折线图
     * @return:
     * @author: huoche
     * @time: 2021/7/19 16:01
     */

    List<BzzPrice> bzzPrice();

    /**
     * @description: Peers折线图
     * @return:
     * @author: huoche
     * @time: 2021/7/19 16:01
     */

    List<BzzPeers> bzzPeers();

    /**
     * @description: 更新bzz价格
     * @return:
     * @author: huoche
     * @time: 2021/7/19 17:26
     */
    void getBzzPrice();

    /**
     * @description: 更新节点数
     * @return:
     * @author: huoche
     * @time: 2021/7/19 17:51
     */
    void updateBzzData(String appId);

    /**
     * @description: 定时更新peers
     * @return:
     * @author: huoche
     * @time: 2021/7/19 18:30
     */
    void updatePeers(String appId);

    /**
     * @description:修改BZZ 状态
     * @return:
     * @author: huoche
     * @time: 2021/7/20 11:57
     */
    void updateBzzStats(String appId);
    /**
     * @description: 更新Xdai余额地址信息
     * @return: 
     * @author: huoche
     * @time: 2021/7/20 14:38
     */
    void updateBzzInfo(String appId);
    void updateBzzInfoGy(String appId,int start,int stop);
    /**
     * @description:检查是否挖到票cheque
     * @return:
     * @author: huoche
     * @time: 2021/7/21 16:45
     */
    void selectCheque(String appId);

    /**
     * @description:
     * @return: BZZ注水
     * @author: huoche
     * @time: 2021/8/4 11:04
     */
    void water();

}
