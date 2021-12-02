// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_Hant locale. All the
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
  String get localeName => 'zh_Hant';

  static String m0(num) => "正在上傳第${num}張...";

  static String m1(version) => "發現新版本${version}";

  static String m2(version) => "AAToken ${version}新版本";

  static String m3(money) => "≈${money} ASDT";

  static String m4(money) => "0/${money}AAA<1分鐘";

  static String m5(money) => "0/${money}AAA<5分鐘";

  static String m6(money) => "0/${money}AAA<30分鐘";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_coin_type_subtitle":
            MessageLookupByLibrary.simpleMessage("请添加身份钱包下的币种(多选)"),
        "add_coin_type_title": MessageLookupByLibrary.simpleMessage("添加币种"),
        "add_token_input":
            MessageLookupByLibrary.simpleMessage("請輸入Token名稱或者合約地址"),
        "add_wallet_aac": MessageLookupByLibrary.simpleMessage("AAC"),
        "add_wallet_aac_subtitle":
            MessageLookupByLibrary.simpleMessage("AAcoin"),
        "add_wallet_btc": MessageLookupByLibrary.simpleMessage("BTC"),
        "add_wallet_btc_subtitle":
            MessageLookupByLibrary.simpleMessage("Bitcoin"),
        "add_wallet_choose_coin_type":
            MessageLookupByLibrary.simpleMessage("選擇幣種"),
        "add_wallet_eth": MessageLookupByLibrary.simpleMessage("ETH"),
        "add_wallet_eth_subtitle":
            MessageLookupByLibrary.simpleMessage("Ethereum"),
        "app_album": MessageLookupByLibrary.simpleMessage("從相冊選擇"),
        "app_build_now": MessageLookupByLibrary.simpleMessage("敬請期待"),
        "app_camera": MessageLookupByLibrary.simpleMessage("拍照"),
        "app_cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "app_confirm": MessageLookupByLibrary.simpleMessage("確定"),
        "app_copy_success": MessageLookupByLibrary.simpleMessage("複製成功"),
        "app_i_know": MessageLookupByLibrary.simpleMessage("好的"),
        "app_img_upload": m0,
        "app_name": MessageLookupByLibrary.simpleMessage("AAToken"),
        "app_no_date": MessageLookupByLibrary.simpleMessage("暫無記錄"),
        "app_permission_camera_close":
            MessageLookupByLibrary.simpleMessage("相機權限被您關閉"),
        "app_permission_location_close":
            MessageLookupByLibrary.simpleMessage("定位權限被您關閉"),
        "app_permission_microphone_close":
            MessageLookupByLibrary.simpleMessage("麥克風權限被您關閉"),
        "app_permission_open": MessageLookupByLibrary.simpleMessage("開啟權限"),
        "app_permission_photos_close":
            MessageLookupByLibrary.simpleMessage("照片權限被您關閉"),
        "app_permission_storage_close":
            MessageLookupByLibrary.simpleMessage("本地存儲被您關閉"),
        "app_permission_title": MessageLookupByLibrary.simpleMessage("權限提醒"),
        "app_permission_video_close":
            MessageLookupByLibrary.simpleMessage("音頻權限被您關閉"),
        "app_save_photos": MessageLookupByLibrary.simpleMessage("保存圖片至相冊"),
        "app_save_photos_failure": MessageLookupByLibrary.simpleMessage("保存失敗"),
        "app_save_photos_success":
            MessageLookupByLibrary.simpleMessage("圖片已保存至相冊"),
        "app_tips": MessageLookupByLibrary.simpleMessage(" 溫馨提示 "),
        "app_update_version": m1,
        "app_version": m2,
        "back_up_do_not_screen_capture1":
            MessageLookupByLibrary.simpleMessage("请勿截屏"),
        "back_up_do_not_screen_capture2": MessageLookupByLibrary.simpleMessage(
            "请勿截屏分享和储存，这将可能被第三方恶意软件收集，造成资产损失"),
        "back_up_mnemonic":
            MessageLookupByLibrary.simpleMessage("请按顺序抄写助记词，确保备份正确"),
        "back_up_mnemonic_confirm":
            MessageLookupByLibrary.simpleMessage("已確認備份"),
        "back_up_mnemonic_tips": MessageLookupByLibrary.simpleMessage(
            "\n1.拖上保管助記詞至隔離網絡的安全地方.\n2.請勿將助記詞在聯網的環境下分享和存儲，比如郵箱、相冊、社交應用等."),
        "back_up_mnemonic_title": MessageLookupByLibrary.simpleMessage("备份助记词"),
        "back_up_tips": MessageLookupByLibrary.simpleMessage("備份提示"),
        "back_up_tips_content1":
            MessageLookupByLibrary.simpleMessage("獲取助記詞等於擁有錢包資產所有權"),
        "back_up_tips_content2":
            MessageLookupByLibrary.simpleMessage("助記詞由英文單詞組成，請抄寫並妥善保管"),
        "back_up_tips_content3":
            MessageLookupByLibrary.simpleMessage("助记词丢失，无法找回，请务必备份助记词"),
        "choose_caret_wallet_title":
            MessageLookupByLibrary.simpleMessage("選擇不同身份"),
        "collections_addr": MessageLookupByLibrary.simpleMessage("錢包地址"),
        "collections_addr_copy": MessageLookupByLibrary.simpleMessage("複製錢包地址"),
        "collections_addr_in_eth":
            MessageLookupByLibrary.simpleMessage("掃二維碼，轉入ETH"),
        "collections_addr_tips":
            MessageLookupByLibrary.simpleMessage("該地址僅支持ETHERUM資產,請勿轉入其他公鏈資產"),
        "confirm_mnemonic": MessageLookupByLibrary.simpleMessage("確認助記詞"),
        "confirm_mnemonic_sequence":
            MessageLookupByLibrary.simpleMessage("請按順序點擊助記詞，已確認您真確備份"),
        "confirm_mnemonic_sequence_err":
            MessageLookupByLibrary.simpleMessage("助記詞排序有誤請重新排序"),
        "creat_wallet": MessageLookupByLibrary.simpleMessage("創建"),
        "creat_wallet_content": MessageLookupByLibrary.simpleMessage("首次使用錢包"),
        "creat_wallet_details":
            MessageLookupByLibrary.simpleMessage("您將會擁有身份下的多鏈錢包,比如ETH、AAC"),
        "creat_wallet_fist":
            MessageLookupByLibrary.simpleMessage("創建您的第一個數字錢包"),
        "creat_wallet_ing": MessageLookupByLibrary.simpleMessage("創建錢包中..."),
        "creat_wallet_name": MessageLookupByLibrary.simpleMessage("錢包名稱"),
        "creat_wallet_name_input":
            MessageLookupByLibrary.simpleMessage("請輸入錢包名稱"),
        "creat_wallet_pwd": MessageLookupByLibrary.simpleMessage("密碼"),
        "creat_wallet_pwd_input":
            MessageLookupByLibrary.simpleMessage("請輸入錢包密碼"),
        "creat_wallet_pwd_repeat":
            MessageLookupByLibrary.simpleMessage("兩次密碼不一致"),
        "creat_wallet_pwd_tips":
            MessageLookupByLibrary.simpleMessage("不少於8位字符，建議混合字母、數字、符號"),
        "creat_wallet_repeat_pwd_input":
            MessageLookupByLibrary.simpleMessage("請再次確認錢包密碼"),
        "creat_wallet_tips_content": MessageLookupByLibrary.simpleMessage(
            "\n1.該密碼將作為錢包的交易密碼.\n2.錢包不會存儲密碼，也無法幫您找回，請務必妥善保管密碼."),
        "creat_wallet_title": MessageLookupByLibrary.simpleMessage("創建錢包"),
        "language_choose": MessageLookupByLibrary.simpleMessage("選擇語言"),
        "profile": MessageLookupByLibrary.simpleMessage("我的"),
        "profile_update_record": MessageLookupByLibrary.simpleMessage("更新記錄"),
        "profile_wallet_management":
            MessageLookupByLibrary.simpleMessage("錢包管理"),
        "recover_import_mnemonic":
            MessageLookupByLibrary.simpleMessage("請輸入助記單詞，並使用空格分隔"),
        "recover_import_private_key":
            MessageLookupByLibrary.simpleMessage("請輸入明文私鑰"),
        "recover_wallet_content": MessageLookupByLibrary.simpleMessage("已擁有錢包"),
        "recover_wallet_import_mnemonic":
            MessageLookupByLibrary.simpleMessage("匯入助記詞"),
        "recover_wallet_import_private_key":
            MessageLookupByLibrary.simpleMessage("明文私鑰字符"),
        "recover_wallet_mnemonic": MessageLookupByLibrary.simpleMessage("助記詞"),
        "recover_wallet_private_key":
            MessageLookupByLibrary.simpleMessage("私鑰"),
        "recover_wallet_title": MessageLookupByLibrary.simpleMessage("恢復錢包"),
        "token_add": MessageLookupByLibrary.simpleMessage("添加代幣"),
        "token_customize": MessageLookupByLibrary.simpleMessage("自定義代幣"),
        "token_details_collection": MessageLookupByLibrary.simpleMessage("收款"),
        "token_details_roughly_money": m3,
        "token_details_state_all": MessageLookupByLibrary.simpleMessage("全部"),
        "token_details_state_transfer_in":
            MessageLookupByLibrary.simpleMessage("轉入"),
        "token_details_state_transfer_out":
            MessageLookupByLibrary.simpleMessage("轉出"),
        "token_details_transfer": MessageLookupByLibrary.simpleMessage("轉賬"),
        "token_main_assets": MessageLookupByLibrary.simpleMessage("首頁資產管理"),
        "token_transfer_addr": MessageLookupByLibrary.simpleMessage("收款地址"),
        "token_transfer_addr_input":
            MessageLookupByLibrary.simpleMessage("請輸入ETH地址"),
        "token_transfer_cell_addr":
            MessageLookupByLibrary.simpleMessage("交易地址"),
        "token_transfer_cell_hash":
            MessageLookupByLibrary.simpleMessage("交易Hash"),
        "token_transfer_cell_state":
            MessageLookupByLibrary.simpleMessage("交易狀態"),
        "token_transfer_cell_time":
            MessageLookupByLibrary.simpleMessage("交易時間"),
        "token_transfer_cell_total":
            MessageLookupByLibrary.simpleMessage("交易數量"),
        "token_transfer_customize": MessageLookupByLibrary.simpleMessage("自定義"),
        "token_transfer_fee": MessageLookupByLibrary.simpleMessage("礦工費"),
        "token_transfer_money": MessageLookupByLibrary.simpleMessage("金額"),
        "token_transfer_money_input":
            MessageLookupByLibrary.simpleMessage("請輸入轉賬金額"),
        "token_transfer_quick": MessageLookupByLibrary.simpleMessage("快"),
        "token_transfer_quick_info": m4,
        "token_transfer_recommend": MessageLookupByLibrary.simpleMessage("推薦"),
        "token_transfer_recommend_info": m5,
        "token_transfer_slow": MessageLookupByLibrary.simpleMessage("慢"),
        "token_transfer_slow_info": m6,
        "token_user_all_assets": MessageLookupByLibrary.simpleMessage("我的所有資產"),
        "wallet": MessageLookupByLibrary.simpleMessage("錢包"),
        "wallet_add_copy_success":
            MessageLookupByLibrary.simpleMessage("錢包地址已複製"),
        "wallet_assets": MessageLookupByLibrary.simpleMessage("資產"),
        "wallet_choose": MessageLookupByLibrary.simpleMessage("選擇錢包"),
        "wallet_create_import": MessageLookupByLibrary.simpleMessage("創建/導入"),
        "wallet_del": MessageLookupByLibrary.simpleMessage("刪除錢包"),
        "wallet_del_only": MessageLookupByLibrary.simpleMessage("您確定刪除當前錢包?"),
        "wallet_details_title": MessageLookupByLibrary.simpleMessage("錢包詳情"),
        "wallet_edit_name": MessageLookupByLibrary.simpleMessage("錢包暱稱修改"),
        "wallet_edit_name_error":
            MessageLookupByLibrary.simpleMessage("修改暱稱出錯，請稍後再試"),
        "wallet_edit_name_input":
            MessageLookupByLibrary.simpleMessage("請輸入錢包暱稱"),
        "wallet_edit_tips": MessageLookupByLibrary.simpleMessage(
            "以英文字幕開頭或者漢字開頭,限6~16個字符，一個漢字為2個字符"),
        "wallet_export_change_pwd":
            MessageLookupByLibrary.simpleMessage("修改密碼"),
        "wallet_export_mnemonic": MessageLookupByLibrary.simpleMessage("導出助記詞"),
        "wallet_export_private_key":
            MessageLookupByLibrary.simpleMessage("導出私鑰"),
        "wallet_export_reset_pwd": MessageLookupByLibrary.simpleMessage("重置密碼"),
        "wallet_identity": MessageLookupByLibrary.simpleMessage("錢包身份"),
        "wallet_import_key_content1":
            MessageLookupByLibrary.simpleMessage("安全警告，私鑰導出後請妥善保管，不要洩露"),
        "wallet_import_key_content2":
            MessageLookupByLibrary.simpleMessage("一旦洩露，可能導致資產損失"),
        "wallet_import_key_copy": MessageLookupByLibrary.simpleMessage("複製私鑰"),
        "wallet_import_key_copy_success":
            MessageLookupByLibrary.simpleMessage("私鑰已複製"),
        "wallet_import_key_tips": MessageLookupByLibrary.simpleMessage("導出提示"),
        "wallet_import_mnemonic_error":
            MessageLookupByLibrary.simpleMessage("您當前錢包導入時，並非採用助記詞導入"),
        "wallet_password": MessageLookupByLibrary.simpleMessage("錢包密碼"),
        "wallet_password_err": MessageLookupByLibrary.simpleMessage("請輸入正確密碼")
      };
}
