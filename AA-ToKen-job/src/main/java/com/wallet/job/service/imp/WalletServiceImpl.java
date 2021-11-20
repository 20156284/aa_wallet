package com.wallet.job.service.imp;

import com.sun.org.apache.bcel.internal.generic.NEW;
import com.wallet.job.entity.AddressBO;
import com.wallet.job.mapper.AddressInfoMapper;
import com.wallet.job.mapper.WalletContractAddressMapper;
import com.wallet.job.service.WalletService;
import com.wallet.job.util.HttpUtil;
import com.wallet.job.util.SuccessCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class WalletServiceImpl implements WalletService {
    private static Logger logger = LoggerFactory.getLogger(WalletServiceImpl.class);
    @Autowired
    private AddressInfoMapper addressInfoMapper;
    @Autowired
    private WalletContractAddressMapper walletContractAddressMapper;

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

    @Override
    public Map<String, Object> getCoinKey(AddressBO addressBO) {
        return HttpUtil.returnData(walletContractAddressMapper.getCoinKeyList(addressBO.getType()), SuccessCode.SUCCESS);
    }

    @Override
    public Map<String, Object> deleteAddress(AddressBO addressBO) {
        addressInfoMapper.deleteAddress(addressBO.getAddress(), addressBO.getProtocol());
        return HttpUtil.returnData(null, SuccessCode.SUCCESS);
    }

    @Override
    public Map<String, Object> transactionRecords(AddressBO addressBO) {
        Map<Object,String> mapList=new HashMap();
        List<Map<Object,String>> list=addressInfoMapper.transactionRecords(addressBO.getType(), addressBO.getAddress(), addressBO.getProtocol());
        if(list!=null&&list.size()>0){
            for(Map<Object,String> map:list){
                if(map.get("number")!=null){
                    Object ob=map.get("number");
                    String sl=(new BigDecimal(String.valueOf(ob))).stripTrailingZeros().toPlainString();
                    map.put("number",sl);
                }
                if(map.get("status")!=null){
                    Object ob=map.get("status");
                    String zt=String.valueOf(ob);
                   if(zt.equals("30")){
                       map.put("status","广播中");
                   }
                    if(zt.equals("40")){
                        map.put("status","确认中");
                    }
                    if(zt.equals("50")){
                        map.put("status","成功");
                    }
                    if(zt.equals("60")){
                        map.put("status","失败");
                    }

                }

            }

        }
        return HttpUtil.returnData(list, SuccessCode.SUCCESS);
    }
}