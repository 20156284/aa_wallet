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

  static String m0(build) => "build:${build}";

  static String m1(num) => "正在上传第${num}张...";

  static String m2(version) => "发现新版本${version}";

  static String m3(version) => "version:${version}";

  static String m4(coin) => "扫二维码,转入${coin}";

  static String m5(time) => "添加代币成功${time}秒后返回";

  static String m6(money) => "≈${money} ASDT";

  static String m7(fee) => "手续费:${fee}";

  static String m8(amount) => "AAA数量:${amount}";

  static String m9(money) => "0/${money}AAA<1分钟";

  static String m10(money) => "0/${money}AAA<5分钟";

  static String m11(money) => "0/${money}AAA<30分钟";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_coin_type_subtitle":
            MessageLookupByLibrary.simpleMessage("请添加身份钱包下的币种(多选)"),
        "add_coin_type_title": MessageLookupByLibrary.simpleMessage("添加币种"),
        "add_token_input":
            MessageLookupByLibrary.simpleMessage("输入Token名称或合约地址"),
        "add_wallet_aac": MessageLookupByLibrary.simpleMessage("AAA"),
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
        "app_build": m0,
        "app_build_now": MessageLookupByLibrary.simpleMessage("敬请期待"),
        "app_camera": MessageLookupByLibrary.simpleMessage("拍照"),
        "app_cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "app_confirm": MessageLookupByLibrary.simpleMessage("确定"),
        "app_copy_success": MessageLookupByLibrary.simpleMessage("复制成功"),
        "app_del": MessageLookupByLibrary.simpleMessage("删除"),
        "app_i_know": MessageLookupByLibrary.simpleMessage("我知道了"),
        "app_img_upload": m1,
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
        "app_save": MessageLookupByLibrary.simpleMessage("保存"),
        "app_save_photos": MessageLookupByLibrary.simpleMessage("保存图片至相册"),
        "app_save_photos_failure": MessageLookupByLibrary.simpleMessage("保存失败"),
        "app_save_photos_success":
            MessageLookupByLibrary.simpleMessage("图片已经保存至相册"),
        "app_tips": MessageLookupByLibrary.simpleMessage(" 温馨提示 "),
        "app_update_now": MessageLookupByLibrary.simpleMessage("立刻更新"),
        "app_update_version": m2,
        "app_version": m3,
        "back_up_do_not_screen_capture1":
            MessageLookupByLibrary.simpleMessage("请勿截屏"),
        "back_up_do_not_screen_capture2": MessageLookupByLibrary.simpleMessage(
            "请勿截屏分享和储存，这将可能被第三方恶意软件收集，造成资产损失"),
        "back_up_mnemonic":
            MessageLookupByLibrary.simpleMessage("请按顺序抄写助记词，确保备份正确"),
        "back_up_mnemonic_confirm":
            MessageLookupByLibrary.simpleMessage("已确认备份"),
        "back_up_mnemonic_confirm_success":
            MessageLookupByLibrary.simpleMessage("助记词已复制"),
        "back_up_mnemonic_copy": MessageLookupByLibrary.simpleMessage("复制助记词"),
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
        "change_page_confirm": MessageLookupByLibrary.simpleMessage("确认修改"),
        "change_page_confirm_pwd": MessageLookupByLibrary.simpleMessage("确认密码"),
        "change_page_confirm_pwd_input":
            MessageLookupByLibrary.simpleMessage("请确认新密码"),
        "change_page_new_pwd": MessageLookupByLibrary.simpleMessage("新密码"),
        "change_page_new_pwd_input":
            MessageLookupByLibrary.simpleMessage("请设置新密码"),
        "change_page_now_pwd": MessageLookupByLibrary.simpleMessage("当前密码"),
        "change_page_now_pwd_input":
            MessageLookupByLibrary.simpleMessage("请输入当前密码"),
        "change_page_pwd_fail": MessageLookupByLibrary.simpleMessage("修改密码失败"),
        "change_page_pwd_success":
            MessageLookupByLibrary.simpleMessage("修改密码成功"),
        "choose_caret_wallet_title":
            MessageLookupByLibrary.simpleMessage("选择不同身份"),
        "collections_addr": MessageLookupByLibrary.simpleMessage("钱包地址"),
        "collections_addr_copy": MessageLookupByLibrary.simpleMessage("复制钱包地址"),
        "collections_addr_in_eth": m4,
        "collections_addr_tips":
            MessageLookupByLibrary.simpleMessage("该地址仅支持AACOIN资产,请勿转入其他公链资产"),
        "confirm_mnemonic": MessageLookupByLibrary.simpleMessage("确认助记词"),
        "confirm_mnemonic_sequence":
            MessageLookupByLibrary.simpleMessage("请按顺序点击助记词，以确认您正确备份"),
        "confirm_mnemonic_sequence_err":
            MessageLookupByLibrary.simpleMessage("助记词有误请重新点击"),
        "creat_wallet": MessageLookupByLibrary.simpleMessage("创建"),
        "creat_wallet_content": MessageLookupByLibrary.simpleMessage("第一次使用钱包"),
        "creat_wallet_details":
            MessageLookupByLibrary.simpleMessage("您将会拥有身份下的多链钱包,比如ETH、AAC"),
        "creat_wallet_finish": MessageLookupByLibrary.simpleMessage("创建钱包完成"),
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
            MessageLookupByLibrary.simpleMessage("不少于8位字符，混合字母、数字、符号"),
        "creat_wallet_repeat_pwd_input":
            MessageLookupByLibrary.simpleMessage("请再次确认钱包密码"),
        "creat_wallet_tips_content": MessageLookupByLibrary.simpleMessage(
            "\n1.该密码将作为钱包的交易密码.\n2.钱包不会储存密码，也无法帮您找回，请务必妥善保管密码."),
        "creat_wallet_title": MessageLookupByLibrary.simpleMessage("创建钱包"),
        "custom_token_add_success": m5,
        "custom_token_addr": MessageLookupByLibrary.simpleMessage("代币合约地址"),
        "custom_token_addr_input":
            MessageLookupByLibrary.simpleMessage("请输入代币合约地址"),
        "custom_token_decimal": MessageLookupByLibrary.simpleMessage("Decimal"),
        "custom_token_decimal_input":
            MessageLookupByLibrary.simpleMessage("请输入Decimal"),
        "custom_token_no_support":
            MessageLookupByLibrary.simpleMessage("暂不支持该代币"),
        "custom_token_symbol": MessageLookupByLibrary.simpleMessage("Symbol"),
        "custom_token_symbol_input":
            MessageLookupByLibrary.simpleMessage("请输入Symbol"),
        "language_choose": MessageLookupByLibrary.simpleMessage("选择语言"),
        "profile": MessageLookupByLibrary.simpleMessage("我的"),
        "profile_update_record": MessageLookupByLibrary.simpleMessage("更新记录"),
        "profile_wallet_management":
            MessageLookupByLibrary.simpleMessage("钱包管理"),
        "recover_import_mnemonic":
            MessageLookupByLibrary.simpleMessage("请输入助记单词，并且使用空格分隔"),
        "recover_import_mnemonic_tips":
            MessageLookupByLibrary.simpleMessage("助记词应该为12个单词"),
        "recover_import_private_key":
            MessageLookupByLibrary.simpleMessage("请输入明文私钥"),
        "recover_import_private_key_tips":
            MessageLookupByLibrary.simpleMessage("标准秘钥长度是64位"),
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
        "token_details_roughly_money": m6,
        "token_details_state_all": MessageLookupByLibrary.simpleMessage("全部"),
        "token_details_state_transfer_in":
            MessageLookupByLibrary.simpleMessage("转入"),
        "token_details_state_transfer_out":
            MessageLookupByLibrary.simpleMessage("转出"),
        "token_details_transfer": MessageLookupByLibrary.simpleMessage("转账"),
        "token_main_assets": MessageLookupByLibrary.simpleMessage("首页资产管理"),
        "token_transfer_addr": MessageLookupByLibrary.simpleMessage("收款地址"),
        "token_transfer_addr_input":
            MessageLookupByLibrary.simpleMessage("请输入AACoin地址"),
        "token_transfer_cell_addr":
            MessageLookupByLibrary.simpleMessage("交易地址"),
        "token_transfer_cell_fee": MessageLookupByLibrary.simpleMessage("交易费用"),
        "token_transfer_cell_hash":
            MessageLookupByLibrary.simpleMessage("交易哈希"),
        "token_transfer_cell_state":
            MessageLookupByLibrary.simpleMessage("交易状态"),
        "token_transfer_cell_time":
            MessageLookupByLibrary.simpleMessage("交易时间"),
        "token_transfer_cell_total":
            MessageLookupByLibrary.simpleMessage("交易数量"),
        "token_transfer_customize": MessageLookupByLibrary.simpleMessage("自定义"),
        "token_transfer_fee": MessageLookupByLibrary.simpleMessage("矿工费"),
        "token_transfer_fee_aa": m7,
        "token_transfer_fee_err": MessageLookupByLibrary.simpleMessage("手续费不足"),
        "token_transfer_money": MessageLookupByLibrary.simpleMessage("数量"),
        "token_transfer_money_aa": m8,
        "token_transfer_money_input":
            MessageLookupByLibrary.simpleMessage("请输入转账数量"),
        "token_transfer_no_more": MessageLookupByLibrary.simpleMessage("余额不足"),
        "token_transfer_quick": MessageLookupByLibrary.simpleMessage("快"),
        "token_transfer_quick_info": m9,
        "token_transfer_recommend": MessageLookupByLibrary.simpleMessage("推荐"),
        "token_transfer_recommend_info": m10,
        "token_transfer_slow": MessageLookupByLibrary.simpleMessage("慢"),
        "token_transfer_slow_info": m11,
        "token_transfer_success":
            MessageLookupByLibrary.simpleMessage("已打包待上链"),
        "token_user_all_assets": MessageLookupByLibrary.simpleMessage("我的所有资产"),
        "wallet": MessageLookupByLibrary.simpleMessage("钱包"),
        "wallet_add_copy_success":
            MessageLookupByLibrary.simpleMessage("钱包地址已复制"),
        "wallet_assets": MessageLookupByLibrary.simpleMessage("资产"),
        "wallet_choose": MessageLookupByLibrary.simpleMessage("选择钱包"),
        "wallet_create_import": MessageLookupByLibrary.simpleMessage("创建/导入"),
        "wallet_del": MessageLookupByLibrary.simpleMessage("删除钱包"),
        "wallet_del_coin_err": MessageLookupByLibrary.simpleMessage("不能删除主币"),
        "wallet_del_coin_tips":
            MessageLookupByLibrary.simpleMessage("您确定要删除该代币?"),
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
        "wallet_has": MessageLookupByLibrary.simpleMessage("钱包已存在无需创建"),
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
