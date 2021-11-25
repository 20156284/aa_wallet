// ===============================================
// token_server
//
// Create by will on 2021/11/11 16:22
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'dart:math';

import 'package:aa_wallet/api/token/token_network.dart';
import 'package:aa_wallet/const/app_policies.dart';
import 'package:aa_wallet/const/env_config.dart';
import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:hex/hex.dart';
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

  /**
   * https://yq.aliyun.com/articles/600706/
   * 这里获取的是指定token的余额 获取代币余额
   * 这里还要考虑小数点的问题，正常情况下token都是18位小数，特殊情况下有12位小数存在
   * 计算balance，需根据当前token的小数点来除
   * 当前还是固定的18位
   * @author Will
   * @date 2021/11/24 16:43
   * @param coinAddress 代币地址
   * @param decimals 代币的小数位数
   * @return 代币的余额
   */
  static Future<String> getTokenBalance(
      num decimals, String coinAddress) async {
    final Map params = {
      'data': AppPolicies.funcHashes['getTokenBalance()']! +
          coinAddress.replaceFirst('0x', '').padLeft(64, '0')
    };
    final response = await TokenNetwork.acquire().network(
      jsonrpc: '2.0',
      method: 'eth_call',
      id: DateTime.now().microsecondsSinceEpoch,
      params: [
        params,
        {'to': coinAddress},
        'latest'
      ],
    );
    final double balance =
        BigInt.parse(response.result!) / BigInt.from(pow(10, decimals));
    if (balance == 0.0) {
      return '0';
    } else {
      return balance.toStringAsFixed(3);
    }
  }

  /**
   * 获取代币的小数位
   * @author Will
   * @date 2021/11/24 16:51
   * @param 代币地址
   * @return 返回几位
   */
  static Future<int> getDecimals(String address) async {
    final Map params = {'data': AppPolicies.funcHashes['getDecimals()']};

    final response = await TokenNetwork.acquire().network(
      jsonrpc: '2.0',
      method: 'eth_call',
      id: DateTime.now().microsecondsSinceEpoch,
      params: [
        params,
        {'to': address},
        'latest'
      ],
    );

    return int.parse(response.result!.replaceFirst('0x', ''), radix: 16);
  }

  /**
   * 搜索指定token
   * @author Will
   * @date 2021/11/24 17:00
   * @param 代币地址
   * @return token 名称
   */
  static Future<String> getTokenName(String address) async {
    final Map params = {'data': '0x95d89b41'};
    final response = await TokenNetwork.acquire().network(
      jsonrpc: '2.0',
      method: 'eth_call',
      id: DateTime.now().microsecondsSinceEpoch,
      params: [
        params,
        {'to': address},
        'latest'
      ],
    );

    final String name = response.result!.replaceFirst('0x', '');
    String nameString = '';
    final List hexList = HEX.decode(name);
    for (var i = 0; i < hexList.length; i++) {
      if (hexList[i] != 32 &&
          hexList[i] != 4 &&
          hexList[i] != 3 &&
          hexList[i] != 2 &&
          hexList[i] != 0) {
        final String str = String.fromCharCode(hexList[i] as int);
        nameString = nameString + str;
      }
    }
    return nameString;
  }
}
