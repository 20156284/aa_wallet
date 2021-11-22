package com.wallet.job.entity;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;

/**
 * 交易对象
 */
public class TransactionVO {
    private String to;

    private String from;

    private String txid;

    private String symbol;

    private BigDecimal amount;

    private BigDecimal txFee;

    private BigInteger height;

    private BigInteger gas;

    private BigInteger gasPrice;

    private Date comfirmTime;

    private Integer coinId;

    private Integer userId;

    private String orderNo;

    public TransactionVO() {
    }

    private TransactionVO(Builder builder) {
        setTo(builder.to);
        setFrom(builder.from);
        setTxid(builder.txid);
        setSymbol(builder.symbol);
        setAmount(builder.amount);
        setTxFee(builder.txFee);
        setHeight(builder.height);
        setGas(builder.gas);
        setGasPrice(builder.gasPrice);
        setComfirmTime(builder.comfirmTime);
        setCoinId(builder.coinId);
        setUserId(builder.userId);
        setOrderNo(builder.orderNo);
    }

    public static Builder newBuilder() {
        return new Builder();
    }


    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTxid() {
        return txid;
    }

    public void setTxid(String txid) {
        this.txid = txid;
    }

    public String getSymbol() {
        return symbol;
    }

    public void setSymbol(String symbol) {
        this.symbol = symbol;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public BigDecimal getTxFee() {
        return txFee;
    }

    public void setTxFee(BigDecimal txFee) {
        this.txFee = txFee;
    }

    public BigInteger getHeight() {
        return height;
    }

    public void setHeight(BigInteger height) {
        this.height = height;
    }

    public BigInteger getGas() {
        return gas;
    }

    public void setGas(BigInteger gas) {
        this.gas = gas;
    }

    public BigInteger getGasPrice() {
        return gasPrice;
    }

    public void setGasPrice(BigInteger gasPrice) {
        this.gasPrice = gasPrice;
    }

    public Date getComfirmTime() {
        return comfirmTime;
    }

    public void setComfirmTime(Date comfirmTime) {
        this.comfirmTime = comfirmTime;
    }

    public Integer getCoinId() {
        return coinId;
    }

    public void setCoinId(Integer coinId) {
        this.coinId = coinId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public static final class Builder {
        private String to;
        private String from;
        private String txid;
        private String symbol;
        private BigDecimal amount;
        private BigDecimal txFee;
        private BigInteger height;
        private BigInteger gas;
        private BigInteger gasPrice;
        private Date comfirmTime;
        private Integer coinId;
        private Integer userId;
        private String orderNo;

        private Builder() {
        }

        public Builder to(String val) {
            to = val;
            return this;
        }

        public Builder from(String val) {
            from = val;
            return this;
        }

        public Builder txid(String val) {
            txid = val;
            return this;
        }

        public Builder symbol(String val) {
            symbol = val;
            return this;
        }

        public Builder amount(BigDecimal val) {
            amount = val;
            return this;
        }

        public Builder txFee(BigDecimal val) {
            txFee = val;
            return this;
        }

        public Builder height(BigInteger val) {
            height = val;
            return this;
        }

        public Builder gas(BigInteger val) {
            gas = val;
            return this;
        }

        public Builder gasPrice(BigInteger val) {
            gasPrice = val;
            return this;
        }

        public Builder comfirmTime(Date val) {
            comfirmTime = val;
            return this;
        }

        public Builder coinId(Integer val) {
            coinId = val;
            return this;
        }

        public Builder userId(Integer val) {
            userId = val;
            return this;
        }

        public Builder orderNo(String val) {
            orderNo = val;
            return this;
        }

        public TransactionVO build() {
            return new TransactionVO(this);
        }
    }
}
