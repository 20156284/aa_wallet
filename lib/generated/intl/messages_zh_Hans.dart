// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_Hans locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_Hans';

  static String m0(num) => "正在上传第${num}张...";

  static String m1(version) => "发现新版本${version}";

  static String m2(version) => "AAToken ${version}新版本";

  static String m3(money) => "≈${money} ASDT";

  static String m4(money) => "0/${money}AAA<1分钟";

  static String m5(money) => "0/${money}AAA<5分钟";

  static String m6(money) => "0/${money}AAA<30分钟";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_coin_type_subtitle":
            MessageLookupByLibrary.simpleMessage("请添加身份钱包下的币种(多选)"),
        "add_coin_type_title": MessageLookupByLibrary.simpleMessage("添加币种"),
        "add_token_input":
            MessageLookupByLibrary.simpleMessage("输入Token名称或合约地址"),
        "add_wallet_aac": MessageLookupByLibrary.simpleMessage("AAC"),
        "add_wallet_aac_subtitle":
            MessageLookupByLibrary.simpleMessage("AAcoin"),
        "add_wallet_btc": MessageLookupByLibrary.simpleMessage("BTC"),
        "add_wallet_btc_subtitle":
            MessageLookupByLibrary.simpleMessage("Bitcoin"),
        "add_wallet_choose_coin_type":
            MessageLookupByLibrary.simpleMessage("选择币种"),
        "add_wallet_eth": MessageLookupByLibrary.simpleMessage("ETH"),
        "add_wallet_eth_subtitle":
            MessageLookupByLibrary.simpleMessage("Ethereum"),
        "app_album": MessageLookupByLibrary.simpleMessage("从相册中选择"),
        "app_build_now": MessageLookupByLibrary.simpleMessage("敬请期待"),
        "app_camera": MessageLookupByLibrary.simpleMessage("拍照"),
        "app_cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "app_confirm": MessageLookupByLibrary.simpleMessage("确定"),
        "app_copy_success": MessageLookupByLibrary.simpleMessage("复制成功"),
        "app_i_know": MessageLookupByLibrary.simpleMessage("我知道了"),
        "app_img_upload": m0,
        "app_name": MessageLookupByLibrary.simpleMessage("AAToken"),
        "app_no_date": MessageLookupByLibrary.simpleMessage("暂无记录"),
        "app_permission_camera_close":
            MessageLookupByLibrary.simpleMessage("相机权限被您关闭"),
        "app_permission_location_close":
            MessageLookupByLibrary.simpleMessage("定位权限被您关闭"),
        "app_permission_microphone_close":
            MessageLookupByLibrary.simpleMessage("定位权限被您关闭"),
        "app_permission_open": MessageLookupByLibrary.simpleMessage("开启权限"),
        "app_permission_photos_close":
            MessageLookupByLibrary.simpleMessage("照片权限被您关闭"),
        "app_permission_storage_close":
            MessageLookupByLibrary.simpleMessage("本地存储权限被您关闭"),
        "app_permission_title": MessageLookupByLibrary.simpleMessage("权限提醒"),
        "app_permission_video_close":
            MessageLookupByLibrary.simpleMessage("音视频权限被您关闭"),
        "app_save_photos": MessageLookupByLibrary.simpleMessage("保存照片"),
        "app_save_photos_failure": MessageLookupByLibrary.simpleMessage("保存失败"),
        "app_save_photos_success": MessageLookupByLibrary.simpleMessage("保存成功"),
        "app_tips": MessageLookupByLibrary.simpleMessage(" 温馨提示 "),
        "app_update_version": m1,
        "app_version": m2,
        "back_up_do_not_screen_capture1":
            MessageLookupByLibrary.simpleMessage("请勿截屏"),
        "back_up_do_not_screen_capture2": MessageLookupByLibrary.simpleMessage(
            "请勿截屏分享和储存，这将可能被第三方恶意软件收集，造成资产损失"),
        "back_up_mnemonic":
            MessageLookupByLibrary.simpleMessage("请按顺序抄写助记词，确保备份正确"),
        "back_up_mnemonic_confirm":
            MessageLookupByLibrary.simpleMessage("已确认备份"),
        "back_up_mnemonic_tips": MessageLookupByLibrary.simpleMessage(
            "\n1.妥善保管助记词至隔离网络的安全地方.\n2.请勿将助记词在联网环境下分享和存储，比如邮件、相册、社交应用等."),
        "back_up_mnemonic_title": MessageLookupByLibrary.simpleMessage("备份助记词"),
        "back_up_tips": MessageLookupByLibrary.simpleMessage("备份提示"),
        "back_up_tips_content1":
            MessageLookupByLibrary.simpleMessage("获得助记词等于拥有钱包资产所有权"),
        "back_up_tips_content2":
            MessageLookupByLibrary.simpleMessage("助记词由英文单词组成，请抄写并妥善保管"),
        "back_up_tips_content3":
            MessageLookupByLibrary.simpleMessage("助记词丢失，无法找回，请务必备份助记词"),
        "choose_caret_wallet_title":
            MessageLookupByLibrary.simpleMessage("选择不同身份"),
        "confirm_mnemonic": MessageLookupByLibrary.simpleMessage("确认助记词"),
        "confirm_mnemonic_sequence":
            MessageLookupByLibrary.simpleMessage("请按顺序点击助记词，以确认您正确备份"),
        "confirm_mnemonic_sequence_err":
            MessageLookupByLibrary.simpleMessage("助记词有误请重新点击"),
        "creat_wallet": MessageLookupByLibrary.simpleMessage("创建"),
        "creat_wallet_content": MessageLookupByLibrary.simpleMessage("第一次使用钱包"),
        "creat_wallet_details":
            MessageLookupByLibrary.simpleMessage("您将会拥有身份下的多链钱包,比如ETH、AAC"),
        "creat_wallet_fist":
            MessageLookupByLibrary.simpleMessage("创建您的第一个数字钱包"),
        "creat_wallet_ing": MessageLookupByLibrary.simpleMessage("创建钱包中..."),
        "creat_wallet_name": MessageLookupByLibrary.simpleMessage("钱包名称"),
        "creat_wallet_name_input":
            MessageLookupByLibrary.simpleMessage("请输入钱包名称"),
        "creat_wallet_pwd": MessageLookupByLibrary.simpleMessage("密码"),
        "creat_wallet_pwd_input":
            MessageLookupByLibrary.simpleMessage("请输入钱包密码"),
        "creat_wallet_pwd_repeat":
            MessageLookupByLibrary.simpleMessage("两次密码不一致"),
        "creat_wallet_pwd_tips":
            MessageLookupByLibrary.simpleMessage("不少于8位字符，建议混合字母、数字、符号"),
        "creat_wallet_repeat_pwd_input":
            MessageLookupByLibrary.simpleMessage("请再次确认钱包密码"),
        "creat_wallet_tips_content": MessageLookupByLibrary.simpleMessage(
            "\n1.该密码将作为钱包的交易密码.\n2.钱包不会储存密码，也无法帮您找回，请务必妥善保管密码."),
        "creat_wallet_title": MessageLookupByLibrary.simpleMessage("创建钱包"),
        "language_choose": MessageLookupByLibrary.simpleMessage("选择语言"),
        "profile": MessageLookupByLibrary.simpleMessage("我的"),
        "profile_update_record": MessageLookupByLibrary.simpleMessage("更新记录"),
        "profile_wallet_management":
            MessageLookupByLibrary.simpleMessage("钱包管理"),
        "recover_import_mnemonic":
            MessageLookupByLibrary.simpleMessage("请输入助记单词，并且使用空格分隔"),
        "recover_import_private_key":
            MessageLookupByLibrary.simpleMessage("请输入明文私钥"),
        "recover_wallet_content": MessageLookupByLibrary.simpleMessage("已拥有钱包"),
        "recover_wallet_import_mnemonic":
            MessageLookupByLibrary.simpleMessage("导入助记词"),
        "recover_wallet_import_private_key":
            MessageLookupByLibrary.simpleMessage("明文私钥字符串"),
        "recover_wallet_mnemonic": MessageLookupByLibrary.simpleMessage("助记词"),
        "recover_wallet_private_key":
            MessageLookupByLibrary.simpleMessage("私钥"),
        "recover_wallet_title": MessageLookupByLibrary.simpleMessage("恢复钱包"),
        "token_add": MessageLookupByLibrary.simpleMessage("添加代币"),
        "token_customize": MessageLookupByLibrary.simpleMessage("自定义代币"),
        "token_details_collection": MessageLookupByLibrary.simpleMessage("收款"),
        "token_details_roughly_money": m3,
        "token_details_state_all": MessageLookupByLibrary.simpleMessage("全部"),
        "token_details_state_transfer_in":
            MessageLookupByLibrary.simpleMessage("转入"),
        "token_details_state_transfer_out":
            MessageLookupByLibrary.simpleMessage("转出"),
        "token_details_transfer": MessageLookupByLibrary.simpleMessage("转账"),
        "token_main_assets": MessageLookupByLibrary.simpleMessage("首页资产管理"),
        "token_transfer_addr": MessageLookupByLibrary.simpleMessage("收款地址"),
        "token_transfer_addr_input":
            MessageLookupByLibrary.simpleMessage("请输入ETH地址"),
        "token_transfer_customize": MessageLookupByLibrary.simpleMessage("自定义"),
        "token_transfer_fee": MessageLookupByLibrary.simpleMessage("矿工费"),
        "token_transfer_money": MessageLookupByLibrary.simpleMessage("金额"),
        "token_transfer_money_input":
            MessageLookupByLibrary.simpleMessage("请输入转账金额"),
        "token_transfer_quick": MessageLookupByLibrary.simpleMessage("快"),
        "token_transfer_quick_info": m4,
        "token_transfer_recommend": MessageLookupByLibrary.simpleMessage("推荐"),
        "token_transfer_recommend_info": m5,
        "token_transfer_slow": MessageLookupByLibrary.simpleMessage("慢"),
        "token_transfer_slow_info": m6,
        "token_user_all_assets": MessageLookupByLibrary.simpleMessage("我的所有资产"),
        "wallet": MessageLookupByLibrary.simpleMessage("钱包"),
        "wallet_add_copy_success":
            MessageLookupByLibrary.simpleMessage("地址已复制"),
        "wallet_assets": MessageLookupByLibrary.simpleMessage("资产"),
        "wallet_choose": MessageLookupByLibrary.simpleMessage("选择钱包"),
        "wallet_create_import": MessageLookupByLibrary.simpleMessage("创建/导入"),
        "wallet_del": MessageLookupByLibrary.simpleMessage("删除钱包"),
        "wallet_del_only": MessageLookupByLibrary.simpleMessage("您确定删除钱包?"),
        "wallet_details_title": MessageLookupByLibrary.simpleMessage("钱包详情"),
        "wallet_edit_name": MessageLookupByLibrary.simpleMessage("钱包昵称修改"),
        "wallet_edit_name_error":
            MessageLookupByLibrary.simpleMessage("修改昵称出错请稍后再试"),
        "wallet_edit_name_input":
            MessageLookupByLibrary.simpleMessage("请输入钱包昵称"),
        "wallet_edit_tips": MessageLookupByLibrary.simpleMessage(
            "以英文字母或者汉字开头，限6~16个字符，一个汉字为2个字符"),
        "wallet_export_change_pwd":
            MessageLookupByLibrary.simpleMessage("修改密码"),
        "wallet_export_mnemonic": MessageLookupByLibrary.simpleMessage("导出助记词"),
        "wallet_export_private_key":
            MessageLookupByLibrary.simpleMessage("导出私钥"),
        "wallet_export_reset_pwd": MessageLookupByLibrary.simpleMessage("重置密码"),
        "wallet_identity": MessageLookupByLibrary.simpleMessage("钱包身份"),
        "wallet_import_key_content1":
            MessageLookupByLibrary.simpleMessage("安全警告，私钥导出后请妥善保管，不要泄露"),
        "wallet_import_key_content2":
            MessageLookupByLibrary.simpleMessage("一旦泄露，可能导致资产损失"),
        "wallet_import_key_copy": MessageLookupByLibrary.simpleMessage("复制私钥"),
        "wallet_import_key_copy_success":
            MessageLookupByLibrary.simpleMessage("私钥已复制"),
        "wallet_import_key_tips": MessageLookupByLibrary.simpleMessage("导出提示"),
        "wallet_import_mnemonic_error":
            MessageLookupByLibrary.simpleMessage("您当前钱包导入时，并非采用助记词导入"),
        "wallet_password": MessageLookupByLibrary.simpleMessage("钱包密码"),
        "wallet_password_err": MessageLookupByLibrary.simpleMessage("请输入正确密码")
      };
}
