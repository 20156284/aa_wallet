package com.wallet.job.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wallet.job.entity.WalletBzzNode;
import com.wallet.job.mapper.WalletBzzNodeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class WalletBzzNodeService {

    @Autowired
    private WalletBzzNodeMapper walletBzzNodeMapper;

    public boolean save(WalletBzzNode walletBzzNode) {return walletBzzNodeMapper.insert(walletBzzNode)>0;}

    public boolean delete(WalletBzzNode walletBzzNode) {return walletBzzNodeMapper.delete(walletBzzNode)>0;}

    public boolean update(WalletBzzNode walletBzzNode) {return walletBzzNodeMapper.update(walletBzzNode)>0;}

    public WalletBzzNode getById(Integer id) {return walletBzzNodeMapper.selectById(id);}

    public WalletBzzNode get(WalletBzzNode walletBzzNode){return walletBzzNodeMapper.select(walletBzzNode);}

    public Map<String,Object> getMap(WalletBzzNode walletBzzNode){return walletBzzNodeMapper.selectMap(walletBzzNode);}

    public List<WalletBzzNode> getList(WalletBzzNode walletBzzNode){return walletBzzNodeMapper.selectList(walletBzzNode);}

    public List<WalletBzzNode> getListByMap(Map<String,Object> params){return walletBzzNodeMapper.selectListByMap(params);}

    public List<Map<String,Object>> getMapListByMap(Map<String,Object> params){return walletBzzNodeMapper.selectMapListByMap(params);}

    public PageInfo<WalletBzzNode> getPageList(WalletBzzNode walletBzzNode, int pageNo, int pageSize){
        PageHelper.startPage(pageNo,pageSize);
        return new PageInfo<WalletBzzNode>(walletBzzNodeMapper.selectList(walletBzzNode));
    }




}
