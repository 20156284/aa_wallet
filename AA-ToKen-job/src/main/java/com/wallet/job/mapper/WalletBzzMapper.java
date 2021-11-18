package com.wallet.job.mapper;

import com.wallet.job.entity.Bo.BzzPeers;
import com.wallet.job.entity.Bo.BzzPrice;
import com.wallet.job.entity.WalletBzz;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Mapper
public interface WalletBzzMapper {
    int insert(WalletBzz walletBzz);

    int delete(WalletBzz walletBzz);

    int update(WalletBzz walletBzz);

    WalletBzz selectById(Integer id);

    WalletBzz select(WalletBzz walletBzz);

    Map<String, Object> selectMap(WalletBzz walletBzz);

    List<WalletBzz> selectList(WalletBzz walletBzz);

    List<WalletBzz> selectListByMap(Map<String, Object> params);

    List<Map<String, Object>> selectMapListByMap(Map<String, Object> params);

    /**
     * @description: 数据中心
     * @return:
     * @author: huoche
     * @time: 2021/7/19 15:31
     */
    List<Map<String, Object>> dataCentreMap(WalletBzz walletBzz);

    /**
     * @description: 价格折线图
     * @return:
     * @author: huoche
     * @time: 2021/7/19 16:14
     */
    List<Map<String, Object>> bzzPrice();

    /**
     * @description: peers折线图
     * @return:
     * @author: huoche
     * @time: 2021/7/19 16:14
     */
    List<BzzPeers> bzzPeers();

    /**
     * @description: 增加BZZ 价格
     * @return:
     * @author: huoche
     * @time: 2021/7/19 17:34
     */
    void addBzzPrice(@Param("price") String price);
    Integer getCountPrice(@Param("price") String price);

    /**
     * @description: 统计节点数量
     * @return:
     * @author: huoche
     * @time: 2021/7/19 18:00
     */
    Integer getByid(@Param("appId") String appId);

    /**
     * @description: 增加节点数据
     * @return:
     * @author: huoche
     * @time: 2021/7/19 18:01
     */
    void addNode(@Param("appId") String appId,
                 @Param("beenodesAll") int beenodesAll,
                 @Param("beenodesLive") int beenodesLive,
                 @Param("beenodesAa") int beenodesAa);

    /**
     * @description:修改节点数据
     * @return:
     * @author: huoche
     * @time: 2021/7/19 18:05
     */
    void updateNode(@Param("id") int id,
                    @Param("beenodesAll") int beenodesAll,
                    @Param("beenodesLive") int beenodesLive,
                    @Param("beenodesAa") int beenodesAa);

    /**
     * @description: 统计AA节点数据
     * @return:
     * @author: huoche
     * @time: 2021/7/19 18:15
     */
    Integer getCountBeenodesAa(@Param("appId") String appId);

    /**
     * @description: 统计未兑换支票是否重复添加
     * @return: 
     * @author: huoche
     * @time: 2021/7/29 18:43
     */
    Integer getPeer(@Param("peer") String peer);

    /**
     * @description: 添加支票信息
     * @return:
     * @author: huoche
     * @time: 2021/7/29 18:43
     */
    Integer addPeerInfo(@Param("peer") String peer,@Param("wallet_bzz_id") int wallet_bzz_id);
    
    /**
     * @description: 注水
     * @return: 
     * @author: huoche
     * @time: 2021/8/4 11:05
     */
    List<Map<String, Object>> waterList();
    void updateWater(@Param("hx")String hx,@Param("id") int id);

    /**
     * @description: 贵阳节点
     * @return:
     * @author: huoche
     * @time: 2021/8/5 19:32
     */

    List<WalletBzz> selectListGy(@Param("appId") String appId,
                                 @Param("start") Integer start,
                                 @Param("stop") Integer stop);
}