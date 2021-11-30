import 'dart:math';

import 'package:aa_wallet/const/app_theme.dart';
import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/core/widget/custom_dialog/show_alert_dialog.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:aa_wallet/utils/token_server.dart';
import 'package:aa_wallet/utils/wallet_crypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TokenTransferLogic extends GetxController {
  //0x201ac284b61461ca7c13aaca3999434b840c6476
  // final TextEditingController addrEdit = TextEditingController();
  final TextEditingController addrEdit =
      TextEditingController(text: '0x201ac284b61461ca7c13aaca3999434b840c6476');
  final TextEditingController moneyEdit = TextEditingController();

  // final TextEditingController pwdEdit = TextEditingController();
  final TextEditingController pwdEdit =
      TextEditingController(text: ')#*will520');
  final pwdVisible = true.obs;

  final chooseTag = 3.obs;
  final wallet = WalletEntry(id: 0).obs;

  @override
  void onInit() async {
    super.onInit();

    final list = await WalletService.to.appDate.getAllWallets();

    for (final walletEntry in list) {
      if (walletEntry.is_main != null && walletEntry.is_main!) {
        wallet.value = walletEntry;
      }
    }
  }

  /**
   * 检查合法性才可以转账
   * @author Will
   * @date 2021/11/26 17:46
   */
  void onCheck() {
    if (addrEdit.text.trim().isEmpty) {
      CoreKitToast.showError(AppS().token_transfer_addr_input);
      return;
    }
    if (moneyEdit.text.trim().isEmpty) {
      CoreKitToast.showError(AppS().token_transfer_money_input);
      return;
    }
    CustomDialog.showCustomDialog(
      Get.context!,
      dialogWidget(),
      isShowCloseBtn: false,
      borderRadius: BorderRadius.circular(20),
    );
  }

  /**
   * 导出输入密码确认窗
   * @author Will
   * @date 2021/11/19 15:06
   * @param exportType 导出类型
   */
  Widget dialogWidget() {
    final width = Get.width * 339 / 375;
    return SizedBox(
      width: width,
      child: Column(
        children: [
          const SizedBox(
            height: 23,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Text(
              AppS().wallet_password,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 28.5,
          ),
          Obx(
            () => SizedBox(
              width: width - 20 * 2,
              child: TextField(
                controller: pwdEdit,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                obscureText: pwdVisible.value,
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  labelText: AppS().creat_wallet_pwd_input,

                  ///设置输入框可编辑时的边框样式
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    borderSide: BorderSide(
                      color: AppTheme.of(Get.context!).inputBgColor,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    borderSide: BorderSide(
                      color: CupertinoTheme.of(Get.context!)
                          .primaryContrastingColor,
                      width: 1,
                    ),
                  ),
                  fillColor: AppTheme.of(Get.context!).inputBgColor,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      //根据passwordVisible状态显示不同的图标
                      pwdVisible.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: pwdVisible.value
                          ? const Color(0xff999999)
                          : CupertinoTheme.of(Get.context!).primaryColor,
                    ),
                    onPressed: () => obscurePwd(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 28.5,
          ),
          Row(
            children: [
              CoreKitStyle.cupertinoButton(
                Get.context!,
                backgroundColor: const Color(0xFFE9E9E9),
                title: AppS().app_cancel,
                titleStyle: const TextStyle(color: Color(0xFF666666)),
                borderRadius: const BorderRadius.all(Radius.circular(0)),
                onPressed: () => Get.back(),
                width: width / 2,
                height: 57,
              ),
              CoreKitStyle.cupertinoButton(
                Get.context!,
                title: AppS().app_confirm,
                onPressed: () => dialogConfirm(),
                borderRadius: const BorderRadius.all(Radius.circular(0)),
                width: width / 2,
                height: 57,
              ),
            ],
          )
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
   * 确认按钮
   * @author Will
   * @date 2021/11/19 15:05
   * @param exportType 导出类型
   */
  void dialogConfirm() async {
    if (pwdEdit.text.trim().isEmpty) {
      CoreKitToast.showError(AppS().creat_wallet_pwd_input);
      return;
    }

    if (!await const WalletCrypt()
        .contrastPwd(pwdEdit.text.trim(), wallet.value.password!)) {
      CoreKitToast.showError(AppS().wallet_password_err);
      return;
    }

    //关闭弹窗
    Get.back();
    //关闭显示密码功能
    pwdVisible.value = true;

    String pwd = pwdEdit.text;
    //加密后的密码
    pwd = await const WalletCrypt().walletPwdEncrypt(pwd);
    final privateKey =
        await const WalletCrypt().decrypt(pwd, wallet.value.privateKey!);

    // //主币种转账
    // final rsp = await TokenService.sendToken(
    //   privateKey: privateKey,
    //   toAddress: addrEdit.text.trim(),
    //   amount: BigInt.parse(moneyEdit.text.trim()),
    //   maxGas: 100000,
    // );

    final hexNum =
        (BigInt.parse('1') * BigInt.from(pow(10, 18))).toRadixString(16);
    final String postData =
        '0xa9059cbb${addrEdit.text.trim().replaceFirst("0x", "").padLeft(64, '0')}${hexNum.padLeft(64, '0')}';

    //代币转账
    final rsp = await TokenService.sendToken(
      privateKey: privateKey,
      toAddress: addrEdit.text.trim(),
      amount: BigInt.parse(moneyEdit.text.trim()),
      postData: postData,
      maxGas: 100000,
      contractAddress: '0x724Cbb5c969890Adc6580d610f9086Ecc003A53A',
    );

    print('transaction => $rsp');
  }
}
