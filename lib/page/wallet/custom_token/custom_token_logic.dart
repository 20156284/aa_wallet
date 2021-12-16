import 'package:aa_wallet/api/token/token_api.dart';
import 'package:aa_wallet/const/env_config.dart';
import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomTokenLogic extends GetxController {
  late TextEditingController addressEdit = TextEditingController();
  late TextEditingController symbolEdit = TextEditingController();
  late TextEditingController decimalEdit = TextEditingController();

  final wallet = WalletEntry(id: 0).obs;

  @override
  void onInit() {
    super.onInit();

    if (Env.appEnv != EnvName.release || Env.appEnv != EnvName.charlesRelease) {
      //eth 默认USDT 地址
      addressEdit = TextEditingController(
          text: '0xdac17f958d2ee523a2206206994597c13d831ec7');
    }

    wallet.value = WalletService.to.wallet.value;
  }

  void onSave() {
    if (addressEdit.text.trim().isEmpty) {
      CoreKitToast.showError(AppS().custom_token_addr_input);
      return;
    }
    onInsert();
  }

  void onInsert() async {
    final cancelFunc = CoreKitToast.showLoading();
    //创建钱包成功的时候发给后台让后添加

    ToKenApi.acquire()
        .getContractAddressInfo(
      contractAddress: addressEdit.text.trim(),
    )
        .then((coinList) async {
      if (coinList.isNotEmpty) {
        await WalletService.to.appDate.insertToken(
          wallet_id: wallet.value.id,
          contractAddress: addressEdit.text.trim(),
          imageUrl: coinList.first.imageUrl,
          protocol: coinList.first.protocol,
          coinKey: coinList.first.coinKey,
          isMainCoin: false,
        );

        CoreKitToast.showSuccess(
          AppS().custom_token_add_success(3),
          onClose: () => Get.back(),
        );
      } else {
        CoreKitToast.showError(AppS().custom_token_no_support);
      }
    }).catchError((error) {
      CoreKitToast.showError(error);
    }).whenComplete(cancelFunc);
  }
}
