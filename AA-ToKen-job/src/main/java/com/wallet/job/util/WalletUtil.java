package com.wallet.job.util;

import com.wallet.job.util.eth.AddrUtil;
import com.wallet.job.util.trx.TronUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.web3j.crypto.ECKeyPair;
import org.web3j.crypto.Keys;
import org.web3j.crypto.WalletFile;
import org.web3j.utils.Numeric;

import java.util.Map;

public class WalletUtil {
    private static Logger logger = LoggerFactory.getLogger(WalletUtil.class);
    public void Address() throws Exception {
        AddrUtil addr=new AddrUtil();
        TronUtil tronUtil = new TronUtil();
        String ETH_MNEMONIC = "m/44'/60'/0'/0/0";
        String ETH_MNEMONIC_TRX = "m/44'/195'/0'/0/0";
        String HEX_PREFIX = "0x";
        Map<String, Object> ethMap = addr.ethGenerateBip39Wallet(null,ETH_MNEMONIC_TRX, "123456");
        ECKeyPair eCKeyPair = (ECKeyPair) ethMap.get("eCKeyPair");
        WalletFile walletFile = (WalletFile) ethMap.get("walletFile");
        String address =walletFile.getAddress();
        String privateKey = eCKeyPair.getPrivateKey().toString(16);
        String publicKey = eCKeyPair.getPublicKey().toString(16);
        //String mnemonic = (ethMap.get("mnemonic").toString());
        String trx_address=tronUtil.hexStringTobase58check("41" + walletFile.getAddress());
        System.out.println("---------------------------------------------------------------");
        logger.error("address:{},trx_address:{}", address,trx_address);
        //logger.error("mnemonic:{}",mnemonic);
        logger.error("privateKey:{},publicKey:{}",  privateKey, publicKey);
       // String address1 = Keys.toChecksumAddress(Keys.getAddress(ECKeyPair.create(Numeric.toBigInt(privateKey))));
        /*Map<String, Object> map = new HashMap<>();
        ObjectMapper objectMapper = ObjectMapperFactory.getObjectMapper();
        ECKeyPair ecKeyPair = Keys.createEcKeyPair();
        WalletFile walletFile1 = Wallet.createStandard("123456", ecKeyPair);
        String keystore = objectMapper.writeValueAsString(walletFile);
        WalletFile walletFile2 = objectMapper.readValue(keystore, WalletFile.class);
        ECKeyPair ecKeyPair1 = Wallet.decrypt("123456", walletFile2);*/
//        map.put("address", tronUtil.hexStringTobase58check("41" + walletFile.getAddress()));
//        map.put("privateKey", ecKeyPair1.getPrivateKey().toString(16));
//        map.put("addressBase58", "41" + walletFile.getAddress());

//        address:27e44a05759fd905154837fce52f2b36e47769c5,trx_address:TDc8qM9ybr9BswUvzC8KyWRS7be7gBPsDh
//        mnemonic:assume shift capable range giant erosion punch federal decorate culture phrase echo
//        privateKey:4c2e4db0dcd460301642924b62fb0e530ca29dfac73c20af9cd24793ed46aa16
//        publicKey:c2cee4808c018925a884cbd329ce9075d284d3901d1c58118505e586e14a7a04fb564d1c2b8a6274b8730d01f1e9bfbd6f2da1d36f0b5e27c3d5b16d2f2f1d1a


    }

    public static void main(String[] args) throws Exception {
        WalletUtil w=new WalletUtil();
        w.Address();
    }
}
