import 'package:aa_wallet/const/env_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomTokenLogic extends GetxController {
  late TextEditingController addressEdit = TextEditingController();
  late TextEditingController symbolEdit = TextEditingController();
  late TextEditingController decimalEdit = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    if (Env.appEnv != EnvName.release || Env.appEnv != EnvName.charlesRelease) {
      //eth 默认USDT 地址
      addressEdit = TextEditingController(
          text: '0xdac17f958d2ee523a2206206994597c13d831ec7');
    }
  }
}
