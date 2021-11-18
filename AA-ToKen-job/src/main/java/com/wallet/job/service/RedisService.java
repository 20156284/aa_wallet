package com.wallet.job.service;

public interface RedisService {
    public void put(String key, String val);

    public void remove(String key);

    public boolean isKeyExists(String key);
}
