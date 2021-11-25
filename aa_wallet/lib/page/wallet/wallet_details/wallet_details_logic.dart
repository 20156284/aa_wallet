import 'package:aa_wallet/const/app_theme.dart';
import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/core/utils/core_utils.dart';
import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/core/widget/custom_dialog/show_alert_dialog.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:aa_wallet/utils/wallet_crypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum ExportType {
  Mnemonic,
  Pwd,
}

class WalletDetailsLogic extends GetxController {
  final TextEditingController pwdEdit = TextEditingController();
  final pwdVisible = true.obs;
  final showAddress = ''.obs;

  final wallet = WalletEntry(id: 0).obs;

  late Worker worker;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is WalletEntry) {
      wallet.value = arguments;

      final address = arguments.address!;
      final front = address.substring(0, 8);
      final behind = address.substring(address.length - 8, address.length);
      showAddress.value = front + '****' + behind;
    }
    //监听钱包的变化
    worker = ever(WalletService.to.wallet, handleWalletChanged);
  }

  /**
   * 监听钱包变换的事件
   * @author Will
   * @date 2021/11/18 15:05
   * @param _wallet 钱包实体类
   */
  void handleWalletChanged(_wallet) async {
    wallet.value = WalletService.to.wallet.value;
    wallet.refresh();
  }

  @override
  void onClose() {
    //释放当前页面的监听事件
    worker.dispose();
    super.onClose();
  }

  /**
   * 刪除錢包
   * @author Will
   * @date 2021/11/17 17:27
   */
  void onDelWallet() {
    WalletService.to.onDelWallet(wallet.value);
  }

  /**
   * 更新钱包
   * @author Will
   * @date 2021/11/19 14:56
   */
  void onUpdateWall() async {
    final data =
        await Get.toNamed(AppRoutes.walletEditName, arguments: wallet.value);
    if (data != null && data is WalletEntry) {
      wallet.value = data;
      wallet.refresh();
    }
  }

  /**
   * 导出主体函数
   * @author Will
   * @date 2021/11/19 14:56
   * @param exportType 导出类型
   */
  void onExport(ExportType exportType) {
    CustomDialog.showCustomDialog(
      Get.context!,
      dialogWidget(exportType),
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
  Widget dialogWidget(ExportType exportType) {
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
                onPressed: () => dialogConfirm(exportType),
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
  void dialogConfirm(ExportType exportType) async {
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

    switch (exportType) {
      case ExportType.Mnemonic:
        if (CoreUtil.isNotEmptyString(wallet.value.mnemonic)) {
          String pwd = pwdEdit.text;
          //加密后的密码
          pwd = await const WalletCrypt().walletPwdEncrypt(pwd);
          final mnemonic =
              await const WalletCrypt().decrypt(pwd, wallet.value.mnemonic!);
          //清空输入框内容
          pwdEdit.text = '';
          Get.toNamed(AppRoutes.backUp, arguments: mnemonic);
        } else {
          CoreKitToast.showError(AppS().wallet_password_err);
          return;
        }

        break;
      case ExportType.Pwd:
        String pwd = pwdEdit.text;
        //加密后的密码
        pwd = await const WalletCrypt().walletPwdEncrypt(pwd);
        final privateKey =
            await const WalletCrypt().decrypt(pwd, wallet.value.privateKey!);
        //清空输入框内容
        pwdEdit.text = '';
        Get.toNamed(AppRoutes.exportPrivateKey, arguments: privateKey);
        break;
    }
  }

  /**
   * 複製私鑰
   * @author Will
   * @date 2021/11/19 17:07
   */
  void onCopy() {
    Clipboard.setData(ClipboardData(text: wallet.value.address));
    CustomDialog.showCustomDialog(
      Get.context!,
      onCopyDialogWidget(),
      isShowCloseBtn: false,
      isAutoClose: true,
      closeDuration: const Duration(seconds: 1),
      borderRadius: BorderRadius.circular(12),
    );
  }

  /**
   * 导出输入密码确认窗
   * @author Will
   * @date 2021/11/19 15:06
   * @param exportType 导出类型
   */
  Widget onCopyDialogWidget() {
    return SizedBox(
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
}
