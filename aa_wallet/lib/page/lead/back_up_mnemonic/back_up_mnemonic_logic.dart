import 'package:aa_wallet/route/app_pages.dart';
import 'package:aa_wallet/utils/token_server.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BackUpMnemonicLogic extends GetxController {
  final mnemonicsList = <String>[].obs;
  final mnemonics = ''.obs;
  bool isComeFrom = false;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      mnemonics.value = Get.arguments.toString();
      mnemonicsList.value = mnemonics.value.split(' ');
      isComeFrom = true;
    } else {
      final String walletMnemonics = TokenService.generateMnemonic();
      mnemonics.value = walletMnemonics;
      mnemonicsList.value = walletMnemonics.split(' ');
    }
  }

  BorderRadius onMnemonic(int index) {
    BorderRadius radius = BorderRadius.circular(0.0);
    if (index == 0) {
      radius = const BorderRadius.only(topLeft: Radius.circular(5));
    }
    if (index == 2) {
      radius = const BorderRadius.only(topRight: Radius.circular(5));
    }
    if (index == 9) {
      radius = const BorderRadius.only(bottomLeft: Radius.circular(5));
    }
    if (index == 11) {
      radius = const BorderRadius.only(bottomRight: Radius.circular(5));
    }
    return radius;
  }

  void onGotoConfirm() {
    if (isComeFrom) {
      Get.back();
    } else {
      if (mnemonicsList.isNotEmpty)
        Get.toNamed(AppRoutes.confirmMnemonic, arguments: mnemonics.value);
    }
  }
}
