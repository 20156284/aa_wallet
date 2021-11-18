//
//package com.wallet.job.scheduled;
//
//import com.wallet.job.benum.protocolType;
//import com.wallet.job.service.Trc20Service;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
//
//@Component
//public class Scheduled {
//    @Autowired
//    Trc20Service trc20Service;
//
//     //每1分钟执行一次TRC20
//    @org.springframework.scheduling.annotation.Scheduled(cron = "0 */1 * * * ?")
//    public void timerRateTrc20() {
//        try {
//            trc20Service.blockChainSweepingTrc20(protocolType.TRC20.name());
//            Thread.sleep(1000);
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        }
//    }
//
//    // 每1分钟30秒执行一次TRC20充值回调
//    @org.springframework.scheduling.annotation.Scheduled(cron = "30 */1 * * * ?")
//    public void Trc20chargeCallback() {
//        try {
//            trc20Service.rechargeCallback(protocolType.TRC20.name());
//            Thread.sleep(1000);
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        }
//    }
//}
//
//
//
