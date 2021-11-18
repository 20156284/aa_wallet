package com.wallet.job.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Data
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
public class WalletBzzNode implements Serializable {
    private static final long serialVersionUID = 1L;
    private Integer id;
    private Integer beenodesAll;
    private Integer beenodesLive;
    private Integer beenodesAa;
    private Date createTime;
    private Date updateTime;
    private String appId;
}