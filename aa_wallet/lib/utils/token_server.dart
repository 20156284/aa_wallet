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

  static String maskAddress(String address) {
    if (address.isNotEmpty) {
      return '${address.substring(0, 8)}...${address.substring(address.length - 12, address.length)}';
    } else {
      return address;
    }
  }

  String entropyToMnemonic(String entropyMnemonic) {
    return bip39.entropyToMnemonic(entropyMnemonic);
  }

  /// 获取指定钱包的余额，这里获取的是ETH的余额
  static Future<String> getBalance(String address) async {
    final client = Web3Client(Env.envConfig.rpcUrl, Client());
    final EtherAmount b =
        await client.getBalance(EthereumAddress.fromHex(address));
    final num balance = b.getValueInUnit(EtherUnit.ether);
    return balance.toStringAsFixed(4);
  }

  static String formattingAddress(String addr) {
    final front = addr.substring(0, 8);
    final behind = addr.substring(addr.length - 8, addr.length);
    return front + '****' + behind;
  }

  // /// 搜索指定token
  // static Future<String> getTokenName(String address) async {
  //   Map params = {'data': '0x95d89b41'};
  //   var response = await Http().post(params: params, to: address);
  //   String res = response['result'];
  //   String name = res.replaceFirst('0x', '');
  //   String nameString = '';
  //   List hexList = HEX.decode(name);
  //   for (var i = 0; i < hexList.length; i++) {
  //     if (hexList[i] != 32 &&
  //         hexList[i] != 4 &&
  //         hexList[i] != 3 &&
  //         hexList[i] != 2 &&
  //         hexList[i] != 0) {
  //       String str = String.fromCharCode(hexList[i]);
  //       nameString = nameString + str;
  //     }
  //   }
  //   return nameString;
  // }

  // /// https://yq.aliyun.com/articles/600706/
  // /// 这里获取的是指定token的余额
  // /// 这里还要考虑小数点的问题，正常情况下token都是18位小数，特殊情况下有12位小数存在
  // /// 计算balance，需根据当前token的小数点来除
  // /// 当前还是固定的18位
  // static Future<String> getTokenBalance(Map token) async {
  //   String myAddress = Global.getPrefs('currentWallet');
  //   Map params = {
  //     'data': Global.funcHashes['getTokenBalance()'] +
  //         myAddress.replaceFirst('0x', '').padLeft(64, '0')
  //   };
  //   var response = await Http().post(params: params, to: token['address']);
  //   double balance = BigInt.parse(response['result']) /
  //       BigInt.from(pow(10, token['decimals']));
  //   if (balance == 0.0) {
  //     return '0';
  //   } else {
  //     return balance.toStringAsFixed(3);
  //   }
  // }

  // /// 获取代币的小数位数
  // static Future<int> getDecimals(String address) async {
  //   Map params = {'data': Global.funcHashes['getDecimals()']};
  //   var response = await Http().post(params: params, to: address);
  //   return int.parse(response['result'].replaceFirst('0x', ''), radix: 16);
  // }

  // /* 获取授权代理额度 - R
  //  * owner: 授权人账户地址，就是用户钱包地址
  //  * spender: 代理人账户地址,就是proxy的合约地址
  //  * 拼接postData，每次都很长，如果更优雅的拼接postData呢
  //  * 返回值
  //  * uint256 value: 代理额度
  //  * */
  // static Future<String> allowance(context, String token) async {
  //   String myAddress =
  //       Provider.of<walletModel.Wallet>(context).currentWalletObject['address'];
  //   String postData = Global.funcHashes['allowance'] +
  //       myAddress.replaceFirst('0x', '').padLeft(64, '0') +
  //       Global.proxy.replaceFirst('0x', '').padLeft(64, '0');
  //   var response = await Http().post(params: {'data': postData}, to: token);
  //   return BigInt.parse(response['result']).toString();
  // }

  // /* 获取配置信息，交易页面右侧的token列表 - R
  // * key: 配置key
  // *
  // * 返回值:
  // * string value
  // * function configurations(string key);
  // */
  // static Future<List> configurations(String key) async {
  //   // String postData = Global.funcHashes['configurations(string key)'] + key;
  //   String offset =
  //       '20'.padLeft(64, '0'); // 偏移量固定是两个32位的字节，第一个32位是偏移量，第二个32位是长度，
  //   String len = key.length.toRadixString(16).padLeft(64, '0');
  //   String value = bytesToHex(utf8.encode(key)).padRight(64, '0');
  //   String postData =
  //       Global.funcHashes['configurations(string key)'] + offset + len + value;
  //   var response = await Http()
  //       .post(params: {'data': postData}, to: Global.youMatchConfig);
  //   // 0-64为是偏移量
  //   // 64-128是长度
  //   print(response['result']);
  //   String res = response['result'].replaceFirst('0x', '').substring(128);
  //   String str = '';
  //   List hexList = HEX.decode(res);
  //   for (var i = 0; i < hexList.length; i++) {
  //     if (hexList[i] != 0 && hexList[i] != 32 && hexList[i] != 171) {
  //       String s = String.fromCharCode(hexList[i]);
  //       str = str + s;
  //     }
  //   }
  //
  //   return str.split(':');
  // }
}
