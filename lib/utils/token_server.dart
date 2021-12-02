// ===============================================
// token_server
//
// Create by will on 2021/11/11 16:22
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'dart:convert';
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
   * @param walletAddress 钱包地址
   * @param coinAddress 代币地址
   * @param decimals 代币的小数位数
   * @return 代币的余额
   */
  static Future<String> getTokenBalance(
      num decimals, String walletAddress, String coinAddress) async {
    final Map params = {
      'data': AppPolicies.funcHashes['getTokenBalance()']! +
          walletAddress.replaceFirst('0x', '').padLeft(64, '0'),
      'to': coinAddress
    };
    final response = await TokenNetwork.acquire().network(
      jsonRpc: '2.0',
      method: 'eth_call',
      id: DateTime.now().microsecondsSinceEpoch,
      params: [params, 'latest'],
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
    final Map params = {
      'data': AppPolicies.funcHashes['getDecimals()'],
      'to': address
    };

    final response = await TokenNetwork.acquire().network(
      jsonRpc: '2.0',
      method: 'eth_call',
      id: DateTime.now().microsecondsSinceEpoch,
      params: [params, 'latest'],
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
    final Map params = {'data': '0x95d89b41', 'to': address};
    final response = await TokenNetwork.acquire().network(
      jsonRpc: '2.0',
      method: 'eth_call',
      id: DateTime.now().microsecondsSinceEpoch,
      params: [params, 'latest'],
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

  // 自定义转账
  // data的组成，
  // 0x + 要调用的合约方法的function signature + 要传递的方法参数，每个参数都为64位
  // (对transfer来说，第一个是接收人的地址去掉0x，第二个是代币数量的16进制表示，去掉前面0x，然后补齐为64位)

  /**
   * 转账逻辑
   * @author Will
   * @date 2021/11/26 18:10
   * @param null
   * @return null
   */
  static Future<String?> transaction({
    String? privateKey,
    String? toAddress,
    BigInt? amount,
    String? postData,
    int? maxGas,
    String? contractAddress,
    String? rpcUrl,
  }) async {
    final client = Web3Client(rpcUrl ?? Env.envConfig.aaaRpcUrl, Client());
    final formAddr = EthPrivateKey.fromHex(privateKey!);
    final networkId = await client.getNetworkId();

    final from = await formAddr.extractAddress();
    final nonce = await client.getTransactionCount(from,
        atBlock: const BlockNum.pending());

    final gasPrice = await client.getGasPrice();

    Transaction transaction = Transaction();


    //主币转账
    if (postData == null) {
      transaction = Transaction(
        nonce: nonce,
        to: EthereumAddress.fromHex(toAddress!),
        gasPrice: gasPrice,
        maxGas: maxGas,
        value: EtherAmount.fromUnitAndValue(EtherUnit.ether, amount),
      );
    } else {
      //代币转账
      transaction = Transaction(
        nonce: nonce,
        to: EthereumAddress.fromHex(contractAddress!),
        gasPrice: gasPrice,
        maxGas: maxGas,
        data: hexToBytes(postData),
      );
    }

   return  client.sendTransaction(
      formAddr,
      transaction,
      chainId: networkId,
    );

    // try {
    //
    //
    //   final transactionId = await client.sendTransaction(
    //     formAddr,
    //     transaction,
    //     chainId: networkId,
    //   );
    //
    //   print('transact started $transactionId');
    //   return transactionId;
    // } catch (ex) {
    //   print('ex $ex');
    //   return null;
    // }
  }

  /*
    * 获取配置信息，交易页面右侧的token列表 - R
    *
    * @author Will
    * @date 2021/12/1 10:39
    * @param null
    * @return function configurations(string key);
    */
  static Future<List> configurations(String key, String contractAddress) async {
    final String offset =
        '20'.padLeft(64, '0'); // 偏移量固定是两个32位的字节，第一个32位是偏移量，第二个32位是长度，
    final String len = key.length.toRadixString(16).padLeft(64, '0');
    final String value = bytesToHex(utf8.encode(key)).padRight(64, '0');
    final String postData = '0x1214dd58' + offset + len + value;

    final Map params = {'data': postData, 'to': contractAddress};
    final response = await TokenNetwork.acquire().network(
      jsonRpc: '2.0',
      method: 'eth_call',
      id: DateTime.now().microsecondsSinceEpoch,
      params: [params, 'latest'],
    );

    print(response.result);
    final String res = response.result!.replaceFirst('0x', '').substring(128);

    String str = '';
    final List<int> hexList = HEX.decode(res);
    for (var i = 0; i < hexList.length; i++) {
      if (hexList[i] != 0 && hexList[i] != 32 && hexList[i] != 171) {
        String s = String.fromCharCode(hexList[i]);
        str = str + s;
      }
    }

    return str.split(':');
  }
}
