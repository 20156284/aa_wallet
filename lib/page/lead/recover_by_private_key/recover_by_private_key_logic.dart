import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/service/app_service.dart';
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

  // //  第一测试 密要 匹配  song convince art planet domain property load satoshi rocket west vital cycle 私钥
  // final TextEditingController privateEdit = TextEditingController(
  //     text: '17caf803d03ae2cb64c9aebe79563477a9b40215212e360b718724c1c124e600');

  //// 第一测试 密要 匹配  forest palm main jelly embody cigar select physical clown tape dutch profit 私钥
  // final TextEditingController privateEdit = TextEditingController(
  //     text: '479cd64cc4dc834aaf90f23b795f0c4084745726cf6a514d4cd8158c74625b63');

  // final TextEditingController nameEdit = TextEditingController(text: 'Will’sWallet');
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

    AppService.to.insertWallet(
      name: walletName,
      password: pwd,
      address: publicAddress.hexEip55,
      privateKey: privateKey,
      cancelFunc: cancelFunc,
      protocol: WalletService.to.protocol.value,
    );
  }
}