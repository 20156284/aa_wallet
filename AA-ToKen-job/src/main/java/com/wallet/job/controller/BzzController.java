package com.wallet.job.controller;

import com.github.pagehelper.PageInfo;
import com.wallet.job.entity.Bo.BzzPeers;
import com.wallet.job.entity.Bo.BzzPrice;
import com.wallet.job.entity.WalletBzz;
import com.wallet.job.entity.WalletBzzNode;
import com.wallet.job.mapper.WalletBzzMapper;
import com.wallet.job.service.WalletBzzNodeService;
import com.wallet.job.service.WalletBzzService;
import com.wallet.job.util.PageResultResponse;
import com.wallet.job.util.ResultResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("bzz")
public class BzzController {
    @Autowired(required = false)
    private WalletBzzMapper walletBzzMapper;
    @Autowired
    private WalletBzzService walletBzzService;
    @Autowired
    private WalletBzzNodeService walletBzzNodeService;

    /**
     * @Author XieChengJian
     * **  WalletBzz  查询数据
     * @Date 2021/7/14 18:29
     */
    @RequestMapping("pageList")
    public PageResultResponse pageList(HttpServletRequest request,  WalletBzz walletBzz, @RequestParam(defaultValue = "1") Integer page,
                                       @RequestParam(defaultValue = "3500") Integer pageSize) {
        PageInfo<WalletBzz> pageInfo = walletBzzService.getPageList(walletBzz, page, pageSize);
        return new PageResultResponse(pageInfo);
    }

    /**
     * @Author XieChengJian
     * **n  全球节点矿机饼图
     * @Date 2021/7/15 14:26
     */
    @RequestMapping("beenodesAll")
    public ResultResponse beenodesAll(WalletBzzNode walletBzzNode) {
        return new ResultResponse(walletBzzService.selectList(walletBzzNode));
    }

    /**
     * @Author XieChengJian
     * **n  数据中心饼图
     * @Date 2021/7/15 14:26
     */
    @RequestMapping("dataCentre")
    public ResultResponse dataCentre(WalletBzz walletBzz) {
        return new ResultResponse(walletBzzService.dataCentre(walletBzz));
    }

    /**
     * @Author XieChengJian
     * **n  交易价格折线图
     * @Date 2021/7/15 14:26
     */
    @RequestMapping("bzzPrice")
    public ResultResponse bzzPrice(BzzPrice bzzPrice) {
        return new ResultResponse(walletBzzService.bzzPrice());
    }

    /**
     * @description: peers 格折线图
     * @return:
     * @author: huoche
     * @time: 2021/7/19 16:48
     */
    @RequestMapping("bzzPeers")
    public ResultResponse bzzPeers(BzzPeers bzzPeers) {
        return new ResultResponse(walletBzzService.bzzPeers());
    }
}