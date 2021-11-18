package com.wallet.job.util.eth;

import com.google.common.collect.Maps;
import org.bitcoinj.core.ECKey;
import org.bitcoinj.crypto.ChildNumber;
import org.bitcoinj.crypto.DeterministicKey;
import org.bitcoinj.crypto.HDKeyDerivation;
import org.bitcoinj.params.MainNetParams;
import org.bitcoinj.params.TestNet3Params;
import org.bitcoinj.wallet.DeterministicKeyChain;
import org.bitcoinj.wallet.DeterministicSeed;
import org.bitcoinj.wallet.UnreadableWalletException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.web3j.crypto.*;
import org.web3j.utils.Numeric;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.*;
import java.util.stream.Collectors;

public final class AddrUtil {

    public static Logger logger = LoggerFactory.getLogger(AddrUtil.class);

    //通过指定路径和助记词导入，并生成钱包
    public static Map<String, Object> ethGenerateBip39Wallet(String mnemonic, String mnemonicPath, String passWord) throws Exception {

        try {
            DeterministicSeed deterministicSeed = null;
            List<String> mnemonicArray = null;

            if (null == mnemonic || 0 == mnemonic.length()) {
                //这里随机生成助记词 new SecureRandom()
                deterministicSeed = new DeterministicSeed(new SecureRandom(), 128, "", System.currentTimeMillis() / 1000);
                mnemonicArray = deterministicSeed.getMnemonicCode();// 助记词
            } else {
                deterministicSeed = new DeterministicSeed(mnemonic, null, "", System.currentTimeMillis() / 1000);
            }

            byte[] seedBytes = deterministicSeed.getSeedBytes();// 种子
            if (null == seedBytes) {
                throw new Exception();
            }

            //种子对象
            DeterministicKey deterministicKey = HDKeyDerivation.createMasterPrivateKey(seedBytes);

            String[] pathArray = mnemonicPath.split("/");// 助记词路径
            for (int i = 1; i < pathArray.length; i++) {
                ChildNumber childNumber;
                if (pathArray[i].endsWith("'")) {
                    int number = Integer.parseInt(pathArray[i].substring(0, pathArray[i].length() - 1));
                    childNumber = new ChildNumber(number, true);
                } else {
                    int number = Integer.parseInt(pathArray[i]);
                    childNumber = new ChildNumber(number, false);
                }
                deterministicKey = HDKeyDerivation.deriveChildKey(deterministicKey, childNumber);
            }

            ECKeyPair eCKeyPair = ECKeyPair.create(deterministicKey.getPrivKeyBytes());
            WalletFile walletFile = Wallet.createStandard(passWord, eCKeyPair);
            if (null == mnemonic || 0 == mnemonic.length()) {
                StringBuilder mnemonicCode = new StringBuilder();
                for (int i = 0; i < mnemonicArray.size(); i++) {
                    mnemonicCode.append(mnemonicArray.get(i)).append(" ");
                }
                return new HashMap<String, Object>() {
                    private static final long serialVersionUID = -4960785990664709623L;

                    {
                        put("walletFile", walletFile);
                        put("eCKeyPair", eCKeyPair);
                        put("mnemonic", mnemonicCode.substring(0, mnemonicCode.length() - 1));
                    }
                };
            } else {
                return new HashMap<String, Object>() {
                    private static final long serialVersionUID = -947886783923530545L;

                    {
                        put("walletFile", walletFile);
                        put("eCKeyPair", eCKeyPair);
                    }
                };
            }
        } catch (CipherException e) {
            throw new Exception(e.getMessage());
        } catch (UnreadableWalletException e) {
            throw new Exception(e.getMessage());
        }
    }

    public static final Map<String, String> btcGenerateBip39Wallet(String mnemonic,
                                                                   String mnemonicPath,
                                                                   boolean isEnvironment) {
        if (null == mnemonic || "".equals(mnemonic)) {
            byte[] initialEntropy = new byte[16];
            SecureRandom secureRandom = new SecureRandom();
            secureRandom.nextBytes(initialEntropy);
            mnemonic = generateMnemonic(initialEntropy);
        }

        String[] pathArray = mnemonicPath.split("/");
        List<ChildNumber> pathList = new ArrayList<ChildNumber>();
        for (int i = 1; i < pathArray.length; i++) {
            int number;
            if (pathArray[i].endsWith("'")) {
                number = Integer.parseInt(pathArray[i].substring(0, pathArray[i].length() - 1));
            } else {
                number = Integer.parseInt(pathArray[i]);
            }
            pathList.add(new ChildNumber(number, pathArray[i].endsWith("'")));
        }

        DeterministicSeed deterministicSeed = null;
        try {
            deterministicSeed = new DeterministicSeed(mnemonic, null, "", 0);
        } catch (UnreadableWalletException e) {
            throw new RuntimeException(e.getMessage());
        }
        DeterministicKeyChain deterministicKeyChain = DeterministicKeyChain.builder().seed(deterministicSeed).build();
        BigInteger privKey = deterministicKeyChain.getKeyByPath(pathList, true).getPrivKey();
        ECKey ecKey = ECKey.fromPrivate(privKey);
        String publickey = Numeric.toHexStringNoPrefixZeroPadded(new BigInteger(ecKey.getPubKey()), 66);

        // 根据配置动态切换环境地址
        String mainNetPrivateKey = ecKey.getPrivateKeyEncoded(isEnvironment == false ? TestNet3Params.get() : MainNetParams.get()).toString();
        Map<String, String> map = Maps.newHashMap();
        map.put("mnemonic", mnemonic);
        map.put("mainNetPrivateKey", mainNetPrivateKey);
        map.put("publickey", publickey);
        map.put("address", ecKey.toAddress(isEnvironment == false ? TestNet3Params.get() : MainNetParams.get()).toString());
        return map;
    }

    public static String generateMnemonic(byte[] initialEntropy) {
        validateInitialEntropy(initialEntropy);
        int ent = initialEntropy.length * 8;
        int checksumLength = ent / 32;
        byte checksum = calculateChecksum(initialEntropy);
        boolean[] bits = convertToBits(initialEntropy, checksum);
        int iterations = (ent + checksumLength) / 11;
        StringBuilder mnemonicBuilder = new StringBuilder();

        for (int i = 0; i < iterations; ++i) {
            int index = toInt(nextElevenBits(bits, i));
            mnemonicBuilder.append(populateWordList().get(index));
            boolean notLastIteration = i < iterations - 1;
            if (notLastIteration) {
                mnemonicBuilder.append(" ");
            }
        }

        return mnemonicBuilder.toString();
    }

    private static void validateInitialEntropy(byte[] initialEntropy) {
        if (initialEntropy == null) {
            throw new IllegalArgumentException("Initial entropy is required");
        } else {
            int ent = initialEntropy.length * 8;
            if (ent < 128 || ent > 256 || ent % 32 != 0) {
                throw new IllegalArgumentException("The allowed size of ENT is 128-256 bits of multiples of 32");
            }
        }
    }

    private static byte calculateChecksum(byte[] initialEntropy) {
        int ent = initialEntropy.length * 8;
        byte mask = (byte) (255 << 8 - ent / 32);
        byte[] bytes = Hash.sha256(initialEntropy);
        return (byte) (bytes[0] & mask);
    }

    private static boolean[] convertToBits(byte[] initialEntropy, byte checksum) {
        int ent = initialEntropy.length * 8;
        int checksumLength = ent / 32;
        int totalLength = ent + checksumLength;
        boolean[] bits = new boolean[totalLength];

        int i;
        for (i = 0; i < initialEntropy.length; ++i) {
            for (int j = 0; j < 8; ++j) {
                byte b = initialEntropy[i];
                bits[8 * i + j] = toBit(b, j);
            }
        }

        for (i = 0; i < checksumLength; ++i) {
            bits[ent + i] = toBit(checksum, i);
        }

        return bits;
    }

    private static boolean toBit(byte value, int index) {
        return (value >>> 7 - index & 1) > 0;
    }

    private static int toInt(boolean[] bits) {
        int value = 0;

        for (int i = 0; i < bits.length; ++i) {
            boolean isSet = bits[i];
            if (isSet) {
                value += 1 << bits.length - i - 1;
            }
        }

        return value;
    }

    private static boolean[] nextElevenBits(boolean[] bits, int i) {
        int from = i * 11;
        int to = from + 11;
        return Arrays.copyOfRange(bits, from, to);
    }

    private static List<String> populateWordList() {
        InputStreamReader read = null;
        try {
            ClassPathResource resource = new ClassPathResource("en-mnemonic-word-list.txt");
            InputStream inputStream = resource.getInputStream();
            read = new InputStreamReader(inputStream, "utf-8");
            BufferedReader bufferedReader = new BufferedReader(read);
            return bufferedReader.lines().collect(Collectors.toList());
        } catch (Exception var2) {
            return Collections.emptyList();
        } finally {
            if (read != null) {
                try {
                    read.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
