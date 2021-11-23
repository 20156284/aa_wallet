// ===============================================
// token_server
//
// Create by will on 2021/11/11 16:22
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'package:aa_wallet/const/env_config.dart';
import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:http/http.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class TokenService {
  TokenService();
  /**
   * 生成助记词
   * @author Will
   * @date 2021/11/18 09:52
   * @return 助记词
   */
  static String generateMnemonic() {
    final mnemonic = bip39.generateMnemonic();
    print('mnemonic: $mnemonic');
    return mnemonic;
  }

  /**
   * 采用静态方法获取 私钥
   * @author Will
   * @date 2021/11/18 09:51
   * @param mnemonic 助记词
   * @return 私钥
   */
  static String getPrivateKey(String mnemonic) {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final root = bip32.BIP32.fromSeed(seed);
    final child1 = root.derivePath("m/44'/60'/0'/0/0");
    final privateKey = bytesToHex(child1.privateKey!.toList());
    print('private: $privateKey');
    return privateKey;
  }

  /**
   * 通过私钥 获取钱包地址
   * @author Will
   * @date 2021/11/18 09:53
   * @param privateKey 私钥
   * @return 以太坊地址
   */
  static EthereumAddress getPublicAddress(String privateKey) {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = private.address;
    print('address: $address');
    return address;
  }

  /**
   * 查询代币的余额
   * @author Will
   * @date 2021/11/23 16:09
   * @param address 被查询的钱包地址
   * @param rpcUrl rpc地址 默认不传的话采用aaa
   */
  static Future<String> getBalance(String address, {String? rpcUrl}) async {
    final client = Web3Client(rpcUrl ?? Env.envConfig.aaaRpcUrl, Client());
    final EtherAmount b =
        await client.getBalance(EthereumAddress.fromHex(address));
    final num balance = b.getValueInUnit(EtherUnit.ether);
    return balance.toStringAsFixed(4);
  }

  /**
   * 格式化地址
   * @author Will
   * @date 2021/11/23 14:35
   * @param 需要格式化的地址
   * @return 返回格式化后的地址
   */
  static String formattingAddress(String addr) {
    final front = addr.substring(0, 8);
    final behind = addr.substring(addr.length - 8, addr.length);
    return front + '****' + behind;
  }
}
