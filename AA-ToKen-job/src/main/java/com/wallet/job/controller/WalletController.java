package com.wallet.job.controller;

import com.wallet.job.benum.protocolType;
import com.wallet.job.entity.Bo.ChatAddressBO;
import com.wallet.job.service.ChatWalletService;
import com.wallet.job.service.Trc20Service;
import com.wallet.job.util.ErrorCode;
import com.wallet.job.util.HttpUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

@RestController
public class WalletController {
    @Autowired
    private ChatWalletService chatWalletService;
    @Autowired
    private Trc20Service trc20Service;

    /**
     * chat-trx
     *
     * @param
     * @return
     */
    @PostMapping("/chat/wallet/newAddress")
    public Map<String, Object> getChatNewAddress(@RequestBody ChatAddressBO chatAddressBO) {
        if (chatAddressBO == null) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        if (StringUtils.isBlank(chatAddressBO.getProtocol())) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        if (StringUtils.isBlank(chatAddressBO.getAppId())) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        if (chatAddressBO.getType() == 0 || chatAddressBO.getType() < 0 || (chatAddressBO.getType() != 1 && chatAddressBO.getType() != 2)) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }

        if (chatAddressBO.getType() == 2) {
            if (StringUtils.isBlank(chatAddressBO.getMnemonic())) {
                return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
            }
        }
        //验证appId是否存在;
        Integer appidCount = chatWalletService.getWalletAppid(chatAddressBO.getAppId());
        if (appidCount == null || appidCount <= 0) {
            return HttpUtil.returnData(null, ErrorCode.APPID_NO_ERROR);
        }

        Map map = new HashMap();
        if (chatAddressBO.getProtocol().toUpperCase().equals(protocolType.TRC20.name())) {
            map = trc20Service.newAddress(chatAddressBO);
        }
        return map;
    }

    /**
     * chat-privateKey-address
     *
     * @param
     * @return
     */
    @PostMapping("/chat/wallet/privateKey/address")
    public Map<String, Object> getpPrivateKeyAddress(@RequestBody ChatAddressBO chatAddressBO) {
        if (chatAddressBO == null) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        if (StringUtils.isBlank(chatAddressBO.getPrivateKey())) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        if (StringUtils.isBlank(chatAddressBO.getProtocol())) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        if (StringUtils.isBlank(chatAddressBO.getAppId())) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        //验证appId是否存在;
        Integer appidCount = chatWalletService.getWalletAppid(chatAddressBO.getAppId());
        if (appidCount == null || appidCount <= 0) {
            return HttpUtil.returnData(null, ErrorCode.APPID_NO_ERROR);
        }
        Map map = new HashMap();
        if (chatAddressBO.getProtocol().toUpperCase().equals(protocolType.TRC20.name())) {
            map = trc20Service.getAddress(chatAddressBO);
        }
        return map;
    }

    /**
     * chat-privateKey-transfer
     *
     * @param
     * @return
     */
    @PostMapping("/chat/wallet/transfer")
    public Map<String, Object> chatWalletTransfer(@RequestBody ChatAddressBO chatAddressBO) {
        if (chatAddressBO == null) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        if (StringUtils.isBlank(chatAddressBO.getPrivateKey())
                || StringUtils.isBlank(chatAddressBO.getProtocol())
                || StringUtils.isBlank(chatAddressBO.getFromAddress())
                || StringUtils.isBlank(chatAddressBO.getToAddress())
                || StringUtils.isBlank(chatAddressBO.getCoinKey())
                || StringUtils.isBlank(chatAddressBO.getNumber())
                || new BigDecimal(chatAddressBO.getNumber()).compareTo(BigDecimal.ZERO) <= 0
        ) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        if (StringUtils.isBlank(chatAddressBO.getAppId())) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        //验证appId是否存在;
        Integer appidCount = chatWalletService.getWalletAppid(chatAddressBO.getAppId());
        if (appidCount == null || appidCount <= 0) {
            return HttpUtil.returnData(null, ErrorCode.APPID_NO_ERROR);
        }
        Map map = new HashMap();
        if (chatAddressBO.getProtocol().toUpperCase().equals(protocolType.TRC20.name())) {
            map = trc20Service.chatWalletTransfer(chatAddressBO);
        }
        return map;
    }

    /**
     * chat-balance
     *
     * @param
     * @return
     */
    @PostMapping("/chat/wallet/balance")
    public Map<String, Object> chatWalletgetBalance(@RequestBody ChatAddressBO chatAddressBO) {
        if (chatAddressBO == null) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        if (StringUtils.isBlank(chatAddressBO.getProtocol())
                || StringUtils.isBlank(chatAddressBO.getFromAddress())
        ) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        if (StringUtils.isBlank(chatAddressBO.getAppId())) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        //验证appId是否存在;
        Integer appidCount = chatWalletService.getWalletAppid(chatAddressBO.getAppId());
        if (appidCount == null || appidCount <= 0) {
            return HttpUtil.returnData(null, ErrorCode.APPID_NO_ERROR);
        }
        Map map = new HashMap();
        if (chatAddressBO.getProtocol().toUpperCase().equals(protocolType.TRC20.name())) {
            map = trc20Service.chatWalletgetBalance(chatAddressBO);
        }
        return map;
    }

    /**
     * chat-deleteAddress
     *
     * @param
     * @return
     */
    @PostMapping("/chat/wallet/deleteAddress")
    public Map<String, Object> deleteAddress(@RequestBody ChatAddressBO chatAddressBO) {
        if (chatAddressBO == null) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        if (StringUtils.isBlank(chatAddressBO.getAppId())
                || StringUtils.isBlank(chatAddressBO.getProtocol()) ||
                StringUtils.isBlank(chatAddressBO.getAddress())) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        //验证appId是否存在;
        Integer appidCount = chatWalletService.getWalletAppid(chatAddressBO.getAppId());
        if (appidCount == null || appidCount <= 0) {
            return HttpUtil.returnData(null, ErrorCode.APPID_NO_ERROR);
        }

        Map map = new HashMap();
        if (chatAddressBO.getProtocol().toUpperCase().equals(protocolType.TRC20.name())) {
            map = trc20Service.deleteAddress(chatAddressBO);
        }
        return map;
    }


    /**
     * chat-交易记录
     *
     * @param
     * @return
     */
    @PostMapping("/chat/wallet/getTransfer")
    public Map<String, Object> getTransfer(@RequestBody ChatAddressBO chatAddressBO) {
        if (chatAddressBO == null) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        if (StringUtils.isBlank(chatAddressBO.getAppId())
                || StringUtils.isBlank(chatAddressBO.getProtocol()) ||
                StringUtils.isBlank(chatAddressBO.getAddress())) {
            return HttpUtil.returnData(null, ErrorCode.PARAMETER_ERROR);
        }
        //验证appId是否存在;
        Integer appidCount = chatWalletService.getWalletAppid(chatAddressBO.getAppId());
        if (appidCount == null || appidCount <= 0) {
            return HttpUtil.returnData(null, ErrorCode.APPID_NO_ERROR);
        }

        Map map = new HashMap();
        if (chatAddressBO.getProtocol().toUpperCase().equals(protocolType.TRC20.name())) {
            map = trc20Service.getTransfer(chatAddressBO);
        }
        return map;
    }
}
