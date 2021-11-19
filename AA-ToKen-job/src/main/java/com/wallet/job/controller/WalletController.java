package com.wallet.job.controller;

import com.wallet.job.entity.AddressBO;
import com.wallet.job.service.WalletService;
import com.wallet.job.util.ErrorCode;
import com.wallet.job.util.HttpUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class WalletController {
    @Autowired
    private WalletService walletService;

    /**
     * 添加地址
     *
     * @param
     * @return
     */
    @PostMapping("/token/wallet/addAddress")
    public Map<String, Object> addAddress(@RequestBody AddressBO addressBO) {
        if (addressBO == null) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        if (StringUtils.isBlank(addressBO.getProtocol())) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }

        if (StringUtils.isBlank(addressBO.getAddress())) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        return walletService.addAddress(addressBO);
    }


    /**
     * @description: 支持币种
     * @return: type 1 主链币；2：代币
     * @author: huoche
     * @time: 2021/11/19 11:45
     */

    @PostMapping("/token/wallet/getCoinKey")
    public Map<String, Object> getCoinKey(@RequestBody AddressBO addressBO) {
        if (addressBO == null || StringUtils.isBlank(addressBO.getType())) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        return walletService.getCoinKey(addressBO);
    }

    /**
     * 删除地址
     *
     * @param
     * @return
     */
    @PostMapping("/token/wallet/deleteAddress")
    public Map<String, Object> deleteAddress(@RequestBody AddressBO addressBO) {
        if (addressBO == null) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        if (StringUtils.isBlank(addressBO.getProtocol())) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }

        if (StringUtils.isBlank(addressBO.getAddress())) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        return walletService.deleteAddress(addressBO);
    }
}

