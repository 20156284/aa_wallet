package com.wallet.job.service.imp;

import com.wallet.job.service.IRedisService;
import com.wallet.job.service.RedisService;
import org.springframework.stereotype.Service;

@Service
public class RedisServiceImpl extends IRedisService<String> implements RedisService {
    private static final String REDIS_KEY = "WALLET-JOB";

    @Override
    protected String getRedisKey() {
        return REDIS_KEY;
    }

    @Override
    public void put(String key, String val) {
        put(key, val, -1);
    }



}
