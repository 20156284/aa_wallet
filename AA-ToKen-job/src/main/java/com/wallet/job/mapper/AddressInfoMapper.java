package com.wallet.job.mapper;

import com.wallet.job.entity.TxIdGroupByAddressVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@Mapper
public interface AddressInfoMapper {
    /**
     * @description: 添加地址信息
     * @return:
     * @author: huoche
     * @time: 2021/7/19 18:01
     */
    void addAddress(@Param("address") String address,
                    @Param("protocol") String protocol);


    /**
     * @description: 判断地址是否存在
     * @return:
     * @author: huoche
     * @time: 2021/11/19 10:30
     */
    Integer getAddressCount(@Param("address") String address,
                            @Param("protocol") String protocol);

    /**
     * @description: 修改地状态
     * @return:
     * @author: huoche
     * @time: 2021/11/19 10:32
     */
    void updateAddress(@Param("protocol") String protocol,
                       @Param("id") Integer id);

    /**
     * @description: 删除地址
     * @return:
     * @author: huoche
     * @time: 2021/11/19 10:30
     */
    void deleteAddress(@Param("address") String address,
                       @Param("protocol") String protocol);

    /**
     * @description: 转账记录
     * @return: type 10 转入；20：转出;
     * @author: huoche
     * @time: 2021/11/19 11:45
     */
    List<Map<Object, String>> transactionRecords(@Param("type") String type,
                                                 @Param("address") String address,
                                                 @Param("protocol") String protocol);

    /**
     * 功能描述: <br>
     * 查询平台同步高度
     */
    Map<String, Object> getBlockScanner(@Param("protocol") String protocol);

    /**
     * 功能描述: <br>
     * 获取平台的合约地址信息
     */
    Map<String, Object> getContractAddress(@Param("protocol") String protocol,
                                           @Param("contractAddress") String contractAddress);

    /**
     * 功能描述: <br>
     * 接收地址是否是平台地址
     */
    Map<String, Object> countAddress(@Param("protocol") String protocol,
                                     @Param("fromAddress") String fromAddress,
                                     @Param("toAddress") String toAddress);

    /**
     * 功能描述: <br>
     * 是否入账
     */
    Integer getHash(@Param("hash") String hash,
                    @Param("type") Integer type,
                    @Param("protocol") String protocol);

    /**
     * 插入充值记录
     */
    void insertWalletTransfer(@Param("transferType") Integer transferType,
                              @Param("coinKey") String coinKey,
                              @Param("fromAddress") String fromAddress,
                              @Param("toAddress") String toAddress,
                              @Param("qty") BigDecimal qty,
                              @Param("txId") String txId,
                              @Param("protocol") String protocol,
                              @Param("txFee") BigDecimal txFee,
                              @Param("status") byte status);

    /**
     * 功能描述: <br>
     * 修改平台同步高度
     */
    void updateBlockScanner(@Param("id") Integer id,
                            @Param("blockHeight") BigInteger blockHeight);

    /**
     * 功能描述: <br>
     * 增加平台同步高度
     */
    Integer addBlockScanner(@Param("protocol") String protocol,
                            @Param("blockHash") String blockHash,
                            @Param("blockHeight") BigInteger blockHeight);

    /**
     * @Description: 充值回调信息
     * @Author:huoche
     * @Date: 2021/4/15
     * @Param:
     * @Return:
     */
    List<TxIdGroupByAddressVO> selectTxidGroupByAddress(@Param("protocol") String protocol,
                                                        @Param("recordStatus") byte recordStatus);

    /**
     * @Description: 修改充值回调信息
     * @Author:huoche
     * @Date: 2021/4/15
     * @Param:
     * @Return:
     */
    void updateWalletTransfer(@Param("id") Integer id,
                              @Param("recordStatus") byte recordStatus,
                              @Param("confirmations") Integer confirmations,
                              @Param("protocol") String protocol);

}