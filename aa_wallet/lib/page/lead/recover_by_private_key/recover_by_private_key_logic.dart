import 'package:aa_wallet/api/token/token_api.dart';
import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:aa_wallet/utils/token_server.dart';
import 'package:aa_wallet/utils/wallet_crypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web3dart/credentials.dart';

class RecoverByPrivateKeyLogic extends GetxController {
  final TextEditingController privateEdit = TextEditingController();
  final TextEditingController nameEdit = TextEditingController();
  final TextEditingController pwdEdit = TextEditingController();
  final TextEditingController repeatPwdEdit = TextEditingController();

  // final TextEditingController privateEdit = TextEditingController(
  //     text: '900123e145c71acb1086a68da724d471c79cafd34e7e77e0fb07db0fc4f4f5f1');
  // final TextEditingController nameEdit = TextEditingController(text: 'Will');
  // final TextEditingController pwdEdit =
  //     TextEditingController(text: ')#*will520');
  // final TextEditingController repeatPwdEdit =
  //     TextEditingController(text: ')#*will520');

  final pwdVisible = true.obs;
  final repeatVisible = true.obs;

  /**
   * 检查输入是否合法再执行
   * @author Will
   * @date 2021/11/17 09:50
   */
  void onCheck() {
    if (privateEdit.text.trim().isEmpty) {
      CoreKitToast.showError(AppS().recover_import_private_key);
      return;
    }
    if (nameEdit.text.trim().isEmpty) {
      CoreKitToast.showError(AppS().creat_wallet_name_input);
      return;
    }
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

    //導入操作
    onRecover(privateEdit.text);
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

  /**
   * 创建钱包
   * @author Will
   * @date 2021/11/17 10:37
   * @param mnemonics 助记词
   */
  void onRecover(String privateKey) async {
    final cancelFunc = CoreKitToast.showLoading();
    //通过 私钥 产生 地址.
    final EthereumAddress publicAddress =
        TokenService.getPublicAddress(privateKey);
    //把 用户的 地址 和钱包密码 钱包名称 存储起来 创建一个新的 就采用他为默认的 钱包
    final String walletName = nameEdit.text;
    String pwd = pwdEdit.text;
    //加密后的密码
    pwd = await const WalletCrypt().walletPwdEncrypt(pwd);
    //加密后的私钥
    privateKey = await const WalletCrypt().encrypt(pwd, privateKey);

    WalletService.to.appDate
        .insertWallet(
      name: walletName,
      password: pwd,
      privateKey: privateKey,
      address: publicAddress.hexEip55,
      isMain: true,
    )
        .then((value) {
      final wService = WalletService.to;

      final WalletEntry wallet = WalletEntry(
        id: value,
        name: walletName,
        password: pwd,
        address: publicAddress.hexEip55,
        mnemonic: '',
        privateKey: privateKey,
        protocol: wService.protocol.value,
        is_main: true,
        rpcUrl: '',
      );
      wService.wallet.value = wallet;
      //先采用默认的 发送
      ToKenApi.acquire().walletAddAddress(
          protocol: wService.protocol.value, address: publicAddress.toString());

      //创建好 地址 保存钱包 密码 钱包名称 跳转到首页
      Get.offAllNamed(AppRoutes.appMain);
    }).catchError((error) {
      CoreKitToast.showError(error);
    }).whenComplete(cancelFunc);
  }
}
