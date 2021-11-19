package com.wallet.job.service.imp;

import com.wallet.job.entity.Bo.AddressBO;
import com.wallet.job.mapper.AddressInfoMapper;
import com.wallet.job.service.WalletService;
import com.wallet.job.util.HttpUtil;
import com.wallet.job.util.SuccessCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class WalletServiceImpl implements WalletService {
    private static Logger logger = LoggerFactory.getLogger(WalletServiceImpl.class);
    @Autowired
    private AddressInfoMapper addressInfoMapper;

    @Override
    public Map<String, Object> addAddress(AddressBO addressBO) {
        Integer id = addressInfoMapper.getAddressCount(addressBO.getAddress(), addressBO.getProtocol());
        if (id != null && id > 0) {
            addressInfoMapper.updateAddress(addressBO.getProtocol(), id);
        } else {
            addressInfoMapper.addAddress(addressBO.getAddress(), addressBO.getProtocol());
        }
        return HttpUtil.returnData(null, SuccessCode.SUCCESS);
    }
}