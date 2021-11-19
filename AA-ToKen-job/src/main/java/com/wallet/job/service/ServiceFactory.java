package com.wallet.job.service;

import com.wallet.job.util.eth.NodeUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.http.HttpService;

@Component
public class ServiceFactory implements ApplicationContextAware {
    private static Logger logger = LoggerFactory.getLogger(NodeUtil.class);
    @Value("${aa.server.url}")
    private String aaUrl;
    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        NodeUtil.aaNode = aaUrl;
        //web3j初始化
        NodeUtil.aaWeb3j = Web3j.build(new HttpService(NodeUtil.aaNode));
        logger.warn("【初始化AA节点成功】 节点：{}", NodeUtil.aaNode);
    }
}