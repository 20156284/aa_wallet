package com.wallet.job.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

@Data
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
public class WalletBzz implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer id;

    private String are;

    private String nodeName;

    private String nodeAddress;

    private String version;

    private Integer status;

    private Integer peers;

    private Integer noTicket;

    private BigDecimal noAgainstBzz;

    private BigDecimal xdaiBalance;

    private String walletAddress;

    private String contractAddress;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date lastActiveTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;

    private String appId;
    private Integer debugApiAddr;

}