package com.wallet.job.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.concurrent.atomic.AtomicInteger;

public class SerialNumberUtil {
    private static final AtomicInteger SERIAL = new AtomicInteger(Integer.MAX_VALUE);
    private static final int SHIFTS_FOR_TIMESTAMP = 17;
    private static final int SHIFTS_FOR_USER_COIN_RECORD_ID = 32;
    private static final int SHIFTS_FOR_STATUS = 2;
    private static final int SHIFTS_FOR_SERIAL = 12;
    private static final int MASK_FOR_SERIAL = (1 << SHIFTS_FOR_SERIAL) - 1;
    private static final long MASK_FOR_TIMESTAMP = (1 << SHIFTS_FOR_TIMESTAMP) - 1;
    private static final long MASK_FOR_STATUS = (1 << SHIFTS_FOR_STATUS) - 1;

    public static String next(long recordId, long status) {
        long second = TimeUtil.toSeconds() - TimeUtil.toSeconds(TimeUtil.floor(new Date()));
        long serial = SERIAL.incrementAndGet();
        long recordShift = recordId << (64 - 1 - SHIFTS_FOR_USER_COIN_RECORD_ID);
        long secondShift = second << (64 - 1 - SHIFTS_FOR_USER_COIN_RECORD_ID - SHIFTS_FOR_TIMESTAMP);
        long statusShift = status << (64 - 1 - SHIFTS_FOR_USER_COIN_RECORD_ID - SHIFTS_FOR_TIMESTAMP - SHIFTS_FOR_STATUS);
//        long secondShift = second << (64 - 1 - SHIFTS_FOR_TIMESTAMP);
//        long unionShift = recordId << (64 - 1 - SHIFTS_FOR_TIMESTAMP - SHIFTS_FOR_USER_COIN_RECORD_ID);
//        long statusShift = status << (64 - 1 - SHIFTS_FOR_TIMESTAMP - SHIFTS_FOR_USER_COIN_RECORD_ID - SHIFTS_FOR_STATUS);
        long number = recordShift | secondShift | statusShift | (serial & MASK_FOR_SERIAL);
        return String.valueOf(TimeUtil.toInt(new Date())) + String.valueOf(number);
    }

    public static long getRecordId(long id) {
        return (id >> (SHIFTS_FOR_STATUS + SHIFTS_FOR_SERIAL + SHIFTS_FOR_TIMESTAMP));
    }

    public static long getSecond(long id) {
        return (id >> (SHIFTS_FOR_STATUS + SHIFTS_FOR_SERIAL)) & MASK_FOR_TIMESTAMP;
    }

    public static long getStatus(long id) {
        return (id >> (SHIFTS_FOR_SERIAL)) & MASK_FOR_STATUS;
    }

    public static String otcMessageIbByString() {
        //输入 年份和月份
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmssSSS");

        String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        String uuid = new String();
        for (int i = 0; i < 4; i++) {
            char ch = str.charAt(new Random().nextInt(str.length()));
            uuid += ch;
        }
        return sdf.format(new Date()) + uuid;
    }

}
