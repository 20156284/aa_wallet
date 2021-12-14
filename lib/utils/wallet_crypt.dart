import 'dart:convert';

import 'package:aes_ecb_pkcs5_flutter/aes_ecb_pkcs5_flutter.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

// 钱包加密和解密
class WalletCrypt {
  // const WalletCrypt(this.pwd, this.data);
  //
  // final String pwd;
  // final String data;

  const WalletCrypt();

  //加密
  Future<String> encrypt(String pwd, String data) async {
    final content = const Utf8Encoder().convert(pwd);
    final digest = md5.convert(content);
    final passwordMd5 = hex.encode(digest.bytes);
    try {
      // final key = Key.fromUtf8(passwordMd5);
      // final iv = IV.fromLength(16);
      // final encrypter = Encrypter(AES(key, mode: AESMode.ecb));
      final String res =
          await FlutterAesEcbPkcs5.encryptString(data, passwordMd5);

      return res;
    } catch (e) {
      return e.toString();
    }
  }

  // 解密
  Future<String> decrypt(String pwd, String data) async {
    final content = const Utf8Encoder().convert(pwd);
    final digest = md5.convert(content);
    final passwordMd5 = hex.encode(digest.bytes);
    try {
      final String res =
          await FlutterAesEcbPkcs5.decryptString(data, passwordMd5);
      return res;
    } catch (e) {
      return e.toString();
    }
  }

  // 钱包密码加密
  Future<String> walletPwdEncrypt(String pwd) async {
    final content = const Utf8Encoder().convert(pwd);
    final digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  // 钱包密码解密
  Future<bool> contrastPwd(String pwd, String encryptPwd) async {
    final content = const Utf8Encoder().convert(pwd);
    final digest = md5.convert(content);
    final passwordMd5 = hex.encode(digest.bytes);
    if (passwordMd5 == encryptPwd) return true;
    return false;
  }
}
