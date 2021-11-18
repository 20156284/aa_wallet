package com.wallet.job.mapper;

import com.wallet.job.entity.TxIdGroupByAddressVO;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public interface ChatWalletMapper {
    /**
     * 验证appId是否存在
     */
    Integer getAppId(@Param("appId") String appId);

    /**
     * 查询地址是否存在
     */
    Integer getCountAddress(@Param("appId") String appId,
                            @Param("address") String address,
                            @Param("protocol") String protocol);

    /**
     * 添加地址信息
     */
    Integer addAddress(
            @Param("address") String address,
            @Param("publicKey") String publicKey,
            @Param("privateKey") String privateKey,
            @Param("mnemonic") String mnemonic,
            @Param("protocol") String protocol,
            @Param("walletFileId") String walletFileId
    );

    /**
     * @Description: 查询合约地址
     * @Author:huoche
     * @Date: 2021/4/16
     * @Param:
     * @Return:
     */
    String getContractAddressOne(@Param("protocol") String protocol,
                                 @Param("coinKey") String coinKey);

    /**
     * @Description: 查询合约地址
     * @Author:huoche
     * @Date: 2021/4/16
     * @Param:
     * @Return:
     */
    List<Map<String, Object>> getContractAddressList(@Param("protocol") String protocol);

    /**
     * 功能描述: <br>
     * 查询平台同步高度
     */
    Map<String, Object> getBlockScanner(@Param("protocol") String protocol);

    /**
     * 功能描述: <br>
     * 增加平台同步高度
     */
    Integer addBlockScanner(@Param("protocol") String protocol,
                            @Param("blockHash") String blockHash,
                            @Param("blockHeight") BigInteger blockHeight);

    /**
     * 功能描述: <br>
     * 获取平台的合约地址信息
     */
    Map<String, Object> getContractAddress(@Param("protocol") String protocol,
                                           @Param("contractAddress") String contractAddress);

    /**
     * 功能描述: <br>
     * 修改平台同步高度
     */
    void updateBlockScanner(@Param("id") Integer id,
                            @Param("blockHeight") BigInteger blockHeight);

    /**
     * 插入充值记录
     */
    void insertWalletTransfer(@Param("coinKey") String coinKey,
                              @Param("amount") BigDecimal amount,
                              @Param("status") byte status,
                              @Param("toAddress") String toAddress,
                              @Param("transferType") byte transferType,
                              @Param("txId") String txId,
                              @Param("fromAddress") String fromAddress,
                              @Param("protocol") String protocol);

    /**
     * 功能描述: <br>
     * 是否入账
     */
    int getHash(@Param("hash") String hash,
                @Param("protocol") String protocol);

    /**
     * 功能描述: <br>
     * 接收地址是否是平台地址
     */
    Map<String, Object> getToAddress(@Param("protocol") String protocol,
                                     @Param("toAddress") String toAddress,
                                     @Param("fromAddress") String fromAddress);

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
                              @Param("txFee") BigDecimal txFee,
                              @Param("protocol") String protocol);

    /**
     * @return
     * @Author huoche
     * @Description //TODO 刪除地址和记录
     * @Date 15:46 2021/7/12
     * @Param
     **/
    void deleteAddress(@Param("protocol") String protocol,
                       @Param("address") String address);

    void deleteAddressTransfer(@Param("protocol") String protocol,
                               @Param("address") String address);

    /**
     * @return
     * @Author huoche
     * @Description //获取交易记录
     * @Date 16:28 2021/7/12
     * @Param
     **/
    List<Map<String, Object>> getTransfer(@Param("protocol") String protocol,
                                          @Param("address") String address,
                                          @Param("coinKey") String coinKey,
                                          @Param("transferType") String transferType,
                                          @Param("transferStatus") String transferStatus);
}