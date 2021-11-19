package com.wallet.job.mapper;


import com.wallet.job.entity.WalletContractAddress;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface WalletContractAddressMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(WalletContractAddress record);

    int insertSelective(WalletContractAddress record);

    WalletContractAddress selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(WalletContractAddress record);

    int updateByPrimaryKey(WalletContractAddress record);

    /**
     * @description: 支持币种
     * @return: type 1 主链币；2：代币
     * @author: huoche
     * @time: 2021/11/19 11:45
     */
    List<Map<Object,String>> getCoinKeyList(@Param("type") String type);
}