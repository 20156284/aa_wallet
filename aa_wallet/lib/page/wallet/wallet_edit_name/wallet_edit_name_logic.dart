import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WalletEditNameLogic extends GetxController {
  final TextEditingController nameEdit = TextEditingController();

  final wallet = WalletEntry(
          id: 0,
          name: '',
          password: '',
          mnemonic: '',
          privateKey: '',
          address: '',
          protocol: '',
          rpcUrl: '',
          is_main: false)
      .obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is WalletEntry) {
      wallet.value = arguments;
    }
  }

  void onUpdateWalletName() {
    if (nameEdit.text.trim().isEmpty) {
      CoreKitToast.showError(AppS().wallet_edit_name_input);
      return;
    }

    if (nameEdit.text.trim().length < 6 || nameEdit.text.trim().length > 16) {
      CoreKitToast.showIconText(text: AppS().wallet_edit_tips);
      return;
    }

    wallet.value = wallet.value.copyWith(name: nameEdit.text.trim());

    WalletService.to.onUpdateWalletName(wallet.value).then((value) {
      if (value) {
        Get.back(result: wallet.value);
      } else {
        CoreKitToast.showIconText(text: AppS().wallet_edit_tips);
        return;
      }
    });
  }
}
