package com.wallet.job;

import com.wallet.job.config.RootContextConfiguration;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.event.ContextRefreshedEvent;

@SpringBootApplication
@MapperScan(basePackages = "com.wallet.job.mapper")
public class Application implements ApplicationListener<ContextRefreshedEvent> {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
        AnnotationConfigApplicationContext rootContext = new AnnotationConfigApplicationContext();
        rootContext.register(RootContextConfiguration.class);
        rootContext.refresh();
    }

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        System.out.println("启动执行");
    }

}