package com.wallet.job.mapper;


import com.wallet.job.entity.WalletBzzNode;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface WalletBzzNodeMapper {





    int insert(WalletBzzNode walletBzzNode);

    int insertBzz(WalletBzzNode walletBzzNode);

    int delete(WalletBzzNode walletBzzNode);

    int update(WalletBzzNode walletBzzNode);

    WalletBzzNode selectById(Integer id);

    WalletBzzNode select(WalletBzzNode walletBzzNode);

    Map<String,Object> selectMap(WalletBzzNode walletBzzNode);

    List<WalletBzzNode> selectList(WalletBzzNode walletBzzNode);

    List<WalletBzzNode> selectListByMap(Map<String,Object> params);

    List<Map<String,Object>> selectMapListByMap(Map<String,Object> params);




}