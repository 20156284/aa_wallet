package com.wallet.job.scheduled;

import com.wallet.job.service.WalletBzzService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class ExchangeBzzScheduled {

    @Autowired
    private WalletBzzService walletBzzService;
//    /**
//     * @description: 检查是否挖到票cheque
//     * @return:
//     * @author: huoche
//     * @time: 2021/7/20 15:11
//     */
//
//    @org.springframework.scheduling.annotation.Scheduled(cron = "0 0/5 * * * ? ")
//    public void selectCheque() {
//        try {
//            walletBzzService.selectCheque("AA");
//            Thread.sleep(1000);
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        }
//    }
//    /**
//     * 更新peers数据
//     */
//    @org.springframework.scheduling.annotation.Scheduled(cron = "0 0/2 * * * ? ")
//    public void updatePeers() {
//        try {
//            walletBzzService.updatePeers("AA");
//            Thread.sleep(1000);
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        }
//    }
//----------------------------------------------------------------//

    /**
     * 更新baa 价格
     */
    @org.springframework.scheduling.annotation.Scheduled(cron = "0 0/18 * * * ? ")
    public void updateBzzPrice() {
        try {
            walletBzzService.getBzzPrice();
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    /**
     * 更新Bzz数据
     */
    @org.springframework.scheduling.annotation.Scheduled(cron = "0 0/30 * * * ? ")
    public void updateBzzData() {
        try {
            walletBzzService.updateBzzData("AA");
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    /**
     * 更新状态数据
     */
    @org.springframework.scheduling.annotation.Scheduled(cron = "0 0/2 * * * ? ")
    public void updateBzzStats() {
        try {
            walletBzzService.updateBzzStats("AA");
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    /**
     * 更新Xdai余额地址信息
     */
    @org.springframework.scheduling.annotation.Scheduled(cron = "0 0/10 * * * ? ")
    public void updateInfo() {
        try {
            walletBzzService.updateBzzInfo("AA");
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    /**
     * 更新Xdai余额地址信息
     */
    @org.springframework.scheduling.annotation.Scheduled(cron = "0 0/5 * * * ? ")
    public void updateInfo_gy() {
        try {
            walletBzzService.updateBzzInfo("BB");
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    /**
     * @description: BZZ 注水
     * @return:
     * @author: huoche
     * @time: 2021/7/20 15:11
     */

    @org.springframework.scheduling.annotation.Scheduled(cron = "0 0/1 * * * ? ")
    public void water() {
        try {
            walletBzzService.water();
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @org.springframework.scheduling.annotation.Scheduled(cron = "10 0/2 * * * ? ")
    public void updateBzzStatsGy1() {
        try {
            walletBzzService.updateBzzInfoGy("BB", 0, 200);
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @org.springframework.scheduling.annotation.Scheduled(cron = "12 0/2 * * * ? ")
    public void updateBzzStatsGy2() {
        try {
            walletBzzService.updateBzzInfoGy("BB", 200,400 );
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @org.springframework.scheduling.annotation.Scheduled(cron = "14 0/2 * * * ? ")
    public void updateBzzStatsGy3() {
        try {
            walletBzzService.updateBzzInfoGy("BB", 400, 600);
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @org.springframework.scheduling.annotation.Scheduled(cron = "16 0/2 * * * ? ")
    public void updateBzzStatsGy4() {
        try {
            walletBzzService.updateBzzInfoGy("BB", 600, 800);
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @org.springframework.scheduling.annotation.Scheduled(cron = "18 0/2 * * * ? ")
    public void updateBzzStatsGy5() {
        try {
            walletBzzService.updateBzzInfoGy("BB", 800, 1000);
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @org.springframework.scheduling.annotation.Scheduled(cron = "20 0/2 * * * ? ")
    public void updateBzzStatsGy6() {
        try {
            walletBzzService.updateBzzInfoGy("BB", 1000, 1200);
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @org.springframework.scheduling.annotation.Scheduled(cron = "22 0/2 * * * ? ")
    public void updateBzzStatsGy7() {
        try {
            walletBzzService.updateBzzInfoGy("BB", 1200, 1400);
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @org.springframework.scheduling.annotation.Scheduled(cron = "24 0/2 * * * ? ")
    public void updateBzzStatsGy8() {
        try {
            walletBzzService.updateBzzInfoGy("BB", 1400,1600 );
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @org.springframework.scheduling.annotation.Scheduled(cron = "26 0/2 * * * ? ")
    public void updateBzzStatsGy9() {
        try {
            walletBzzService.updateBzzInfoGy("BB", 1600, 1800);
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @org.springframework.scheduling.annotation.Scheduled(cron = "28 0/2 * * * ? ")
    public void updateBzzStatsGy10() {
        try {
            walletBzzService.updateBzzInfoGy("BB", 1800, 2000);
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @org.springframework.scheduling.annotation.Scheduled(cron = "30 0/2 * * * ? ")
    public void updateBzzStatsGy11() {
        try {
            walletBzzService.updateBzzInfoGy("BB", 2000, 2200);
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @org.springframework.scheduling.annotation.Scheduled(cron = "32 0/2 * * * ? ")
    public void updateBzzStatsGy12() {
        try {
            walletBzzService.updateBzzInfoGy("BB", 2200, 2400);
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

}