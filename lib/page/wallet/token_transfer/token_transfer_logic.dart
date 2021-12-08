import 'dart:math';

import 'package:aa_wallet/const/app_policies.dart';
import 'package:aa_wallet/const/app_theme.dart';
import 'package:aa_wallet/const/env_config.dart';
import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/core/widget/custom_dialog/show_alert_dialog.dart';
import 'package:aa_wallet/core/widget/qr_scan.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:aa_wallet/utils/token_server.dart';
import 'package:aa_wallet/utils/wallet_crypt.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web3dart/web3dart.dart';

class TokenTransferLogic extends GetxController {
  // final TextEditingController addrEdit = TextEditingController();
  // final TextEditingController pwdEdit = TextEditingController();
  final TextEditingController moneyEdit = TextEditingController();

  final TextEditingController addrEdit =
      TextEditingController(text: '0x201ac284b61461ca7c13aaca3999434b840c6476');
  final TextEditingController pwdEdit = TextEditingController(text: 'Aa123456');

  final tokenEntry = TokenEntry(id: 0, wallet_id: 0).obs;

  final pwdVisible = true.obs;

  //自定义转账
  final chooseTag = 3.obs;

  //钱包ID
  final wallet = WalletEntry(id: 0).obs;

  //当前代币价格
  final aaaAmount = num.parse('0').obs;

  //当前代币价格
  final fee = num.parse('0').obs;

  @override
  void onInit() async {
    super.onInit();

    wallet.value = WalletService.to.wallet.value;

    final arguments = Get.arguments;

    if (arguments != null && arguments is TokenEntry) {
      tokenEntry.value = arguments;
    }

    aaaAmount.value = WalletService.to.aaaAmount.value;

    final client = Web3Client(Env.envConfig.aaaRpcUrl, Client());
    final gasPrice = await client.getGasPrice();
    final maxGasGasPrice =
        NumUtil.multiply(AppPolicies.maxGas, gasPrice.getInWei.toInt());

    fee.value = NumUtil.divide(maxGasGasPrice, pow(10, 18));
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

    if (aaaAmount.value < fee.value) {
      CoreKitToast.showError(AppS().token_transfer_fee_err);
      return;
    }

    //关闭弹窗
    Get.back();
    //关闭显示密码功能
    pwdVisible.value = true;

    String pwd = pwdEdit.text;
    debugPrint('pwd =>$pwd');

    final cancelFunc = CoreKitToast.showLoading();
    //加密后的密码
    pwd = await const WalletCrypt().walletPwdEncrypt(pwd);
    debugPrint('pwd =>$pwd');
    final privateKey =
        await const WalletCrypt().decrypt(pwd, wallet.value.privateKey!);
    debugPrint('privateKey =>$privateKey');

    //默认是主币转账
    if (tokenEntry.value.contractAddress == null) {
      // //主币种转账
      // final rsp = await TokenService.transaction(
      //   privateKey: privateKey,
      //   toAddress: addrEdit.text.trim(),
      //   amount: BigInt.parse(moneyEdit.text.trim()),
      //   maxGas: 100000,
      // );
      // print('transaction => $rsp');

      TokenService.transaction(
        privateKey: privateKey,
        toAddress: addrEdit.text.trim(),
        amount: BigInt.parse(moneyEdit.text.trim()),
        maxGas: AppPolicies.maxGas,
      ).then((value) {
        addrEdit.text = '';
        pwdEdit.text = '';
        moneyEdit.text = '';
        print('transaction => $value');
      }).catchError((error) {
        debugPrint(error.toString());
        CoreKitToast.showError(error);
      }).whenComplete(cancelFunc);
    } else {
      final hexNum =
          (BigInt.parse(moneyEdit.text.trim()) * BigInt.from(pow(10, 18)))
              .toRadixString(16);
      final String postData =
          '0xa9059cbb${addrEdit.text.trim().replaceFirst("0x", "").padLeft(64, '0')}${hexNum.padLeft(64, '0')}';

      // //代币转账
      // final rsp = await TokenService.transaction(
      //   privateKey: privateKey,
      //   toAddress: addrEdit.text.trim(),
      //   postData: postData,
      //   maxGas: 100000,
      //   contractAddress: tokenEntry.value.contractAddress!,
      // );
      //
      // print('transaction => $rsp');

      TokenService.transaction(
        privateKey: privateKey,
        toAddress: addrEdit.text.trim(),
        postData: postData,
        maxGas: AppPolicies.maxGas,
        contractAddress: tokenEntry.value.contractAddress!,
      ).then((value) {
        addrEdit.text = '';
        pwdEdit.text = '';
        moneyEdit.text = '';
        print('transaction => $value');
      }).catchError((error) {
        debugPrint(error.toString());
        CoreKitToast.showError(error);
      }).whenComplete(cancelFunc);
    }
  }

  /**
   * 使用照片之前先获取手机手机权限问题
   * @author Will
   * @date 2021/11/17 17:08
   * @param permission 调用那个权限
   */
  void getPermission(Permission permission, BuildContext context) async {
    await permission.request().then((value) async {
      String content = '';
      if (value.index == 1) {
        if (permission == Permission.photos) {}
        if (permission == Permission.camera) {
          final String? str = await CoreQRScan.pushScan(
            context: context,
            borderColor: CupertinoTheme.of(context).primaryColor,
          );
          addrEdit.text = str ?? '';
        }
      } else {
        if (permission == Permission.photos) {
          content = AppS().app_permission_photos_close;
        }
        if (permission == Permission.camera) {
          content = AppS().app_permission_camera_close;
        }

        _showCupertinoAlertDialog(content);
      }
    });
  }

  /**
   * 如果没有权限的时候 弹出权限问题的弹窗
   * @author Will
   * @date 2021/11/17 17:08
   * @param content 显示被屏蔽的内容
   */
  void _showCupertinoAlertDialog(String content) {
    Get.dialog(
      CupertinoAlertDialog(
        title: Text(AppS().app_permission_title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            child: Text(AppS().app_permission_open),
            onPressed: () async {
              await openAppSettings(); //打开设置页面
              Get.back();
            },
          ),
          CupertinoDialogAction(
            child: Text(AppS().app_cancel),
            isDestructiveAction: true,
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
