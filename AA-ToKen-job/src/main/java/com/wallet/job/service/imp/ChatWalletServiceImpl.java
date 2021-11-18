package com.wallet.job.service.imp;

import com.wallet.job.mapper.ChatWalletMapper;
import com.wallet.job.service.ChatWalletService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChatWalletServiceImpl implements ChatWalletService {
    private static Logger logger = LoggerFactory.getLogger(ChatWalletServiceImpl.class);

    @Autowired
     ChatWalletMapper chatWalletMapper;

    @Override
    public Integer getWalletAppid(String appId) {
        return chatWalletMapper.getAppId(appId);
    }
}
