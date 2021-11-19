package com.wallet.job.controller;

import com.wallet.job.entity.Bo.AddressBO;
import com.wallet.job.service.WalletService;
import com.wallet.job.util.ErrorCode;
import com.wallet.job.util.HttpUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
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


}
