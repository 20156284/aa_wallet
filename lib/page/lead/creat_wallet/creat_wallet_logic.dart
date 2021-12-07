import 'package:aa_wallet/api/token/token_api.dart';
import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/entity/token/coin_key_entity.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatWalletLogic extends GetxController {
  final nameEdit = TextEditingController();
  final pwdEdit = TextEditingController();
  final repeatPwdEdit = TextEditingController();

  // final TextEditingController nameEdit =
  //     TextEditingController(text: 'Will\'s Wallet');
  // final TextEditingController pwdEdit =
  //     TextEditingController(text: ')#*will520');
  // final TextEditingController repeatPwdEdit =
  //     TextEditingController(text: ')#*will520');

  final coinKeyList = <CoinKeyEntity>[].obs;

  final pwdVisible = true.obs;
  final repeatVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    nameEdit.text = WalletService.to.walletName.value;
  }

  /**
   * 检查输入是否合法再执行
   * @author Will
   * @date 2021/11/17 09:50
   */
  void onCheck() {
    // if (nameEdit.text.trim().isEmpty) {
    //   CoreKitToast.showError(AppS().creat_wallet_name_input);
    //   return;
    // }
    if (pwdEdit.text.trim().isEmpty) {
      CoreKitToast.showError(AppS().creat_wallet_pwd_input);
      return;
    }
    if (repeatPwdEdit.text.trim().isEmpty) {
      CoreKitToast.showError(AppS().creat_wallet_repeat_pwd_input);
      return;
    }

    if (pwdEdit.text.trim() != repeatPwdEdit.text.trim()) {
      CoreKitToast.showError(AppS().creat_wallet_pwd_repeat);
      return;
    }

    //正则表达 8 位 包含字母数字 符号
    final RegExp regexPwd = RegExp(r'^(?:(?=.*[a-z])(?=.*[0-9])).{8,16}$');
    if (!regexPwd.hasMatch(repeatPwdEdit.text.trim())) {
      CoreKitToast.showIconText(text: AppS().creat_wallet_pwd_tips);
      return;
    }

    WalletService.to.password.value = pwdEdit.text;
    //这里先使用默认的创建的
    // WalletService.to.protocol.value = 'ARC20';

    // getCoinType();
    Get.toNamed(AppRoutes.backUp);
  }

  /**
   * 获取支持币种
   * @author Will
   * @date 2021/11/20 09:46
   */
  void getCoinType() {
    final cancelFunc = CoreKitToast.showLoading(text: AppS().creat_wallet_ing);
    ToKenApi.acquire().walletGetCoinKey(type: '1').then((value) {
      if (value != null) {
        coinKeyList.value = value;
        // Get.toNamed(AppRoutes.backUp);
        Get.toNamed(AppRoutes.coinType, arguments: value);
      }
    }).catchError((error) {
      CoreKitToast.showError(error);
    }).whenComplete(cancelFunc);
  }

  /**
   * 导出输入密码确认窗
   * @author Will
   * @date 2021/11/19 15:06
   * @param exportType 导出类型
   */
  Widget dialogWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      width: 145,
      height: 145,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(CupertinoIcons.check_mark_circled, size: 80),
          const SizedBox(
            height: 20,
          ),
          Text(AppS().wallet_import_key_copy_success),
        ],
      ),
    );
  }

  /**
   * 切换密码显示状态
   * @author Will
   * @date 2021/11/17 09:59
   * @param null
   * @return null
   */
  void obscurePwd() {
    pwdVisible.value = !pwdVisible.value;
  }

  /**
   * 切换确认密码显示状态
   * @author Will
   * @date 2021/11/17 09:59
   * @param null
   * @return null
   */
  void obscureRepeat() {
    repeatVisible.value = !repeatVisible.value;
  }
}
