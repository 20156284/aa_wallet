package com.wallet.job.util.trx;

import com.google.common.primitives.Ints;
import com.google.common.primitives.Longs;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.bouncycastle.util.encoders.Hex;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.math.BigInteger;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;


public class ByteArray {
    private static final Logger logger = LoggerFactory.getLogger("utils");
    public static final byte[] EMPTY_BYTE_ARRAY = new byte[0];

    public ByteArray() {
    }

    public static String toHexString(byte[] data) {
        return data == null ? "" : Hex.toHexString(data);
    }

    public static byte[] fromHexString(String data) {
        if (data == null) {
            return EMPTY_BYTE_ARRAY;
        } else {
            if (data.startsWith("0x")) {
                data = data.substring(2);
            }

            if (data.length() % 2 != 0) {
                data = "0" + data;
            }

            return Hex.decode(data);
        }
    }

    public static long toLong(byte[] b) {
        return ArrayUtils.isEmpty(b) ? 0L : (new BigInteger(1, b)).longValue();
    }

    public static int toInt(byte[] b) {
        return ArrayUtils.isEmpty(b) ? 0 : (new BigInteger(1, b)).intValue();
    }

    public static byte[] fromString(String s) {
        return StringUtils.isBlank(s) ? null : s.getBytes();
    }

    public static String toStr(byte[] b) {
        return ArrayUtils.isEmpty(b) ? null : new String(b);
    }

    public static byte[] fromLong(long val) {
        return Longs.toByteArray(val);
    }

    public static byte[] fromInt(int val) {
        return Ints.toByteArray(val);
    }

    public static byte[] fromObject(Object obj) {
        byte[] bytes = null;

        try {
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            Throwable var3 = null;

            try {
                ObjectOutputStream objectOutputStream = new ObjectOutputStream(byteArrayOutputStream);
                Throwable var5 = null;

                try {
                    objectOutputStream.writeObject(obj);
                    objectOutputStream.flush();
                    bytes = byteArrayOutputStream.toByteArray();
                } catch (Throwable var30) {
                    var5 = var30;
                    throw var30;
                } finally {
                    if (objectOutputStream != null) {
                        if (var5 != null) {
                            try {
                                objectOutputStream.close();
                            } catch (Throwable var29) {
                                var5.addSuppressed(var29);
                            }
                        } else {
                            objectOutputStream.close();
                        }
                    }

                }
            } catch (Throwable var32) {
                var3 = var32;
                throw var32;
            } finally {
                if (byteArrayOutputStream != null) {
                    if (var3 != null) {
                        try {
                            byteArrayOutputStream.close();
                        } catch (Throwable var28) {
                            var3.addSuppressed(var28);
                        }
                    } else {
                        byteArrayOutputStream.close();
                    }
                }

            }
        } catch (IOException var34) {
            logger.error("objectToByteArray failed: " + var34.getMessage(), var34);
        }

        return bytes;
    }

    public static byte[] subArray(byte[] input, int start, int end) {
        byte[] result = new byte[end - start];
        System.arraycopy(input, start, result, 0, end - start);
        return result;
    }

    public static boolean isEmpty(byte[] input) {
        return input == null || input.length == 0;
    }

    public static boolean matrixContains(List<byte[]> source, byte[] obj) {
        Iterator var2 = source.iterator();

        byte[] sobj;
        do {
            if (!var2.hasNext()) {
                return false;
            }

            sobj = (byte[]) var2.next();
        } while (!Arrays.equals(sobj, obj));

        return true;
    }
}
