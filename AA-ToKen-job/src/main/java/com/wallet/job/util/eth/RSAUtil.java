package com.wallet.job.util.eth;

import javax.crypto.Cipher;
import java.io.ByteArrayOutputStream;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

public class RSAUtil {
    public static final String CHARSET = "UTF-8";
    public static final String RSA_ALGORITHM = "RSA";

    public static final String publicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAthSrIisR/wD+4YmLjRmO80viItOAa4CGHdaD4wNVYq/+fq+tmiS8xM2ukysI5TEhWv5WZa3Rk7+kjwB/EJX3OK9UKbswGtYMWHToGCgPtaATrbRBC8/bTkW2npKDghhdPMzc26JSyLyudYoeUGv8KIszyZvcNUgXPDFJZJbUzisnjhN4UD4JIYSN4j5jaUcJJ4I9pzuvEVYfqdc0TCNC04CRVa4U77hFYP6XKYC9lE+TRYntXuV0aBpdZ1oSBpDv3a4hyQ0r7MhzvmFXrVFyl9bn6Cb/M88q9BrIKfu3ZhOHGEKJFVVqsRt0L6MTel2GXX6JzETNzhGITu9cpnBGMwIDAQAB";
    public static final String privateKey = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC2FKsiKxH/AP7hiYuNGY7zS+Ii04BrgIYd1oPjA1Vir/5+r62aJLzEza6TKwjlMSFa/lZlrdGTv6SPAH8Qlfc4r1QpuzAa1gxYdOgYKA+1oBOttEELz9tORbaekoOCGF08zNzbolLIvK51ih5Qa/woizPJm9w1SBc8MUlkltTOKyeOE3hQPgkhhI3iPmNpRwkngj2nO68RVh+p1zRMI0LTgJFVrhTvuEVg/pcpgL2UT5NFie1e5XRoGl1nWhIGkO/driHJDSvsyHO+YVetUXKX1ufoJv8zzyr0Gsgp+7dmE4cYQokVVWqxG3QvoxN6XYZdfonMRM3OEYhO71ymcEYzAgMBAAECggEAWBdZ0HccBs6Zgc6E6KgT5BuzdXv0Jo6Q1IDDYCJtvgg9zVb7W5coiOKl8megrxn89EQW0qyst5nBaLopv4F+kTsqMeJxXJpwcJ9m5sEDELE4tBKAYdGXXaAWwVNLMrbM7SyEMfKvsJSwpwdCsU/9ODRYwtKYUGLncuS5iGP84x1l+1sY0EOI7z9+WwnTq8Hjfaasa6cXEtZyiVAnynS0fPbZfIOCYSwhxEpuT+UUE6aheagHpjxcvDE7u/1NwA20wzWa0RkyuH4pxBj0zeu2N+TtvnsCsPFBG1pid++eAVppylz6fJIVb4Mpe2i+mvYUJWlxaPu6yiHz5ctNjpHmKQKBgQDtF9DgE9HhcGajPqjGDtpcbYP+vx86Q9oeOsSDHWJzPHiWGsKeEeRa7VbAmXo6vWcuybmrC5T0f5lVOhvih/p6OiAL7xEIB2ja0V0qNNU32cNykseK1q+qmYdLD2H986Zmuxnud2EXG8rFLm6ZKQqi6qgWM1yMhQ+P8CG/j8eoFQKBgQDEmcr4UieZBO3Icx+NTjyHI1clrEueR23Eq+NpDaVkbWpZt2VCp64Ow8/dIdROwbtzt4IPhavjfuGUnvKdnKSt391CERTOugRy3w8JsCBpYXNjOGnmnDaRdSKoMR4zratb7VQZdDc1+rwp7PY6SzbhEBSrsQXfPI08s7cNX6a/JwKBgQDbmB9iK3lNMGof8L0pFECzMsv6etJViNrQ/OVd+y1gRjX58TcoaLH0dbbQFFbdaOfUsgpBniyMeFJwWa3SFtertYJRC0/e+93mLdv4Z47Ed/FKgSBIO6fgfuqMXucH60/H/qt57yAB4z/fea3+NcEgO+8LAO9LR0Kusl7Pqj/mMQKBgEHImCLZEojgHlRpORCGMjihuaJQcYkHq5IYVeKr/0CIYAKfHBHem54zJRWAIVMs/fUtXSameqqHpSGewd29MVlAw/88SfMWSTDKtHRwa5f3VK3JjZ3tfVDUmgEfVlTCcskys2ZE/chhGp8IvCcrTbSnNdNxS160GypJlCG0dM4XAoGAeu8WNJcv4t/jLw0y/Doos1HRMH2iUj05IEj3S/OlpQq6h0BmmB87ILZgCYLZzv4MX8toLL3lnQXIREaMoGY/CAjMlm0AQF5JTiVc/idmN8FR5IJU4ahOhgdgHd3QXCj1drFFM5h0OxgKr/cBX4tT67ptjZgvif+pdprFJHtzU74=";

    public static Map<String, String> createKeys(int keySize) throws Exception {

        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance(RSA_ALGORITHM);
        keyPairGenerator.initialize(keySize);
        KeyPair keyPair = keyPairGenerator.generateKeyPair();
        String publicKey = Base64.getEncoder().encodeToString(keyPair.getPublic().getEncoded());
        String privateKey = Base64.getEncoder().encodeToString(keyPair.getPrivate().getEncoded());
        Map<String, String> keyPairMap = new HashMap<String, String>();
        keyPairMap.put("publicKey", publicKey);
        keyPairMap.put("privateKey", privateKey);
        System.out.println("publicKey:" + publicKey);
        System.out.println("privateKey:" + privateKey);
        return keyPairMap;
    }

    // 得到公钥
    public static RSAPublicKey getPublicKey(String publicKey) throws Exception {
        KeyFactory keyFactory = KeyFactory.getInstance(RSA_ALGORITHM);
        X509EncodedKeySpec x509EncodedKeySpec = new X509EncodedKeySpec(Base64.getDecoder().decode(publicKey));
        return (RSAPublicKey) keyFactory.generatePublic(x509EncodedKeySpec);
    }

    // 得到私钥
    public static RSAPrivateKey getPrivateKey(String privateKey) {
        try {
            KeyFactory keyFactory = KeyFactory.getInstance(RSA_ALGORITHM);
            PKCS8EncodedKeySpec pKCS8EncodedKeySpec = new PKCS8EncodedKeySpec(Base64.getDecoder().decode(privateKey));
            return (RSAPrivateKey) keyFactory.generatePrivate(pKCS8EncodedKeySpec);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 公钥加密
    public static String publicEncrypt(String publicEncrypt) {
        RSAPublicKey rSAPublicKey = null;
        Cipher cipher = null;
        String string = null;
        try {
            rSAPublicKey = getPublicKey(RSAUtil.publicKey);
            cipher = Cipher.getInstance(RSA_ALGORITHM);
            cipher.init(Cipher.ENCRYPT_MODE, rSAPublicKey);
            string = Base64.getEncoder().encodeToString(rsaSplitCodec(cipher, Cipher.ENCRYPT_MODE, publicEncrypt.getBytes(CHARSET), rSAPublicKey.getModulus().bitLength()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return string;
    }

    // 私钥解密
    public static String privateDecrypt(String privateDecrypt) {
        RSAPrivateKey rSAPrivateKey = null;
        Cipher cipher = null;
        String string = null;
        try {
            rSAPrivateKey = getPrivateKey(RSAUtil.privateKey);
            cipher = Cipher.getInstance(RSA_ALGORITHM);
            cipher.init(Cipher.DECRYPT_MODE, rSAPrivateKey);
            string = new String(rsaSplitCodec(cipher, Cipher.DECRYPT_MODE, Base64.getDecoder().decode(privateDecrypt), rSAPrivateKey.getModulus().bitLength()), CHARSET);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return string;
    }

    private static byte[] rsaSplitCodec(Cipher cipher, int opmode, byte[] datas, int keySize) throws Exception {
        int maxBlock = 0;
        if (opmode == Cipher.DECRYPT_MODE) {
            maxBlock = keySize / 8;
        } else {
            maxBlock = keySize / 8 - 11;
        }
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        int offSet = 0;
        byte[] buff;
        int i = 0;
        while (datas.length > offSet) {
            if (datas.length - offSet > maxBlock) {
                buff = cipher.doFinal(datas, offSet, maxBlock);
            } else {
                buff = cipher.doFinal(datas, offSet, datas.length - offSet);
            }
            out.write(buff, 0, buff.length);
            i++;
            offSet = i * maxBlock;
        }
        byte[] resultDatas = out.toByteArray();
        try {
            out.close();
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return resultDatas;
    }

    public static void main(String[] args) throws Exception {
//        System.out.println(RSAUtil.publicEncrypt("aaaaaaa"));//公钥每次加密结果都不同
        System.out.println(RSAUtil.privateDecrypt("UdFoXVQ4siGIAnxQIylMM119aYJFbCq8iIRJvICMKVz9071bHjqTAbz3slhn9t6JlPAzyVvIGFR6QskRTYamzB8+IaqruEZVClYzafID6RS2cO1KH4xSqzOX2e5QyT9IrNvp/nZSQyQ5AH6WKIX1EGFpWMYUUxrCp02fpn8tATgApY0IRu8hhhPxVAzTKDxjoOvdKZCJx58XZL1sB9UGHztwshb5gNDd2XJYq9YC+49hTcYxigF8sVH+8YgP1R9wjiLFRUfYuHCn5DKe1BAiVgLuHclZ9Nw1hVzFt7c48bxNUeqCuAeVWNGUZSjb/V8ojQf29R1U69nkgDDzsyWK7g=="));
    }
}