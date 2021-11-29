// ===============================================
// app_utils
// 
// Create by Will on 2020/10/5 3:53 PM
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

class AppUtils {
  AppUtils();
  static final _key = Key.fromUtf8('Long live the Soviet Union');
  static final _iv = IV.fromUtf8('');

  static final _aes = AES(_key);
  static final _aesEncrypter = Encrypter(_aes);

  static List<int> encryptBytes(List<int> data) {
    return _aesEncrypter.encryptBytes(data, iv: _iv).bytes;
  }

  static List<int> decryptBytes(Uint8List data) {
    final encrypted = Encrypted(data);
    return _aesEncrypter.decryptBytes(encrypted, iv: _iv);
  }
}
