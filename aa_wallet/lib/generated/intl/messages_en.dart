// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(num) => "uploading ${num}...";

  static String m1(version) => "find new version V${version}";

  static String m2(version) => "AAToken ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_coin_type_subtitle": MessageLookupByLibrary.simpleMessage(
            "Please add the coin under the identity wallet (multiple choice)"),
        "add_coin_type_title":
            MessageLookupByLibrary.simpleMessage("Add Coin type"),
        "add_wallet_aac": MessageLookupByLibrary.simpleMessage("AAC"),
        "add_wallet_aac_subtitle":
            MessageLookupByLibrary.simpleMessage("AAcoin"),
        "add_wallet_btc": MessageLookupByLibrary.simpleMessage("BTC"),
        "add_wallet_btc_subtitle":
            MessageLookupByLibrary.simpleMessage("Bitcoin"),
        "add_wallet_choose_coin_type":
            MessageLookupByLibrary.simpleMessage("Choose coin type"),
        "add_wallet_eth": MessageLookupByLibrary.simpleMessage("ETH"),
        "add_wallet_eth_subtitle":
            MessageLookupByLibrary.simpleMessage("Ethereum"),
        "app_album": MessageLookupByLibrary.simpleMessage("form album"),
        "app_build_now": MessageLookupByLibrary.simpleMessage("coming soon"),
        "app_camera": MessageLookupByLibrary.simpleMessage("take photo"),
        "app_cancel": MessageLookupByLibrary.simpleMessage("cancel"),
        "app_confirm": MessageLookupByLibrary.simpleMessage("confirm"),
        "app_copy_success":
            MessageLookupByLibrary.simpleMessage("copy success"),
        "app_i_know": MessageLookupByLibrary.simpleMessage("I know"),
        "app_img_upload": m0,
        "app_name": MessageLookupByLibrary.simpleMessage("AAToken"),
        "app_no_date": MessageLookupByLibrary.simpleMessage("no date"),
        "app_permission_camera_close":
            MessageLookupByLibrary.simpleMessage("camera permission is close"),
        "app_permission_location_close": MessageLookupByLibrary.simpleMessage(
            "location permission is close"),
        "app_permission_microphone_close": MessageLookupByLibrary.simpleMessage(
            "microphone permission is close"),
        "app_permission_open":
            MessageLookupByLibrary.simpleMessage("open permission"),
        "app_permission_photos_close":
            MessageLookupByLibrary.simpleMessage("photos permission is close"),
        "app_permission_storage_close":
            MessageLookupByLibrary.simpleMessage("storage permission is close"),
        "app_permission_title":
            MessageLookupByLibrary.simpleMessage("permission tips"),
        "app_permission_video_close":
            MessageLookupByLibrary.simpleMessage("video permission is close"),
        "app_save_photos": MessageLookupByLibrary.simpleMessage("save photo"),
        "app_save_photos_failure":
            MessageLookupByLibrary.simpleMessage("save photo fail"),
        "app_save_photos_success":
            MessageLookupByLibrary.simpleMessage("save photo success"),
        "app_tips": MessageLookupByLibrary.simpleMessage("Tips"),
        "app_update_version": m1,
        "app_version": m2,
        "back_up_do_not_screen_capture1": MessageLookupByLibrary.simpleMessage(
            "Please don\'t capture screen"),
        "back_up_do_not_screen_capture2": MessageLookupByLibrary.simpleMessage(
            "Do not take screenshots to share and store, it may be collected by third-party malware and cause asset loss"),
        "back_up_mnemonic": MessageLookupByLibrary.simpleMessage(
            "Please copy the mnemonic words in order to ensure that the backup is correct"),
        "back_up_mnemonic_confirm":
            MessageLookupByLibrary.simpleMessage("Confirm BackUp"),
        "back_up_mnemonic_tips": MessageLookupByLibrary.simpleMessage(
            "\n1. Properly keep the mnemonic phrase to a safe place isolated from the network.\n2. Do not share and store mnemonic words in a networked environment, such as emails, photo albums, social applications, etc."),
        "back_up_mnemonic_title":
            MessageLookupByLibrary.simpleMessage("BackUp mnemonic"),
        "back_up_tips": MessageLookupByLibrary.simpleMessage("BackUp Tips"),
        "back_up_tips_content1": MessageLookupByLibrary.simpleMessage(
            "Obtaining the mnemonic phrase is equivalent to owning the wallet asset ownership"),
        "back_up_tips_content2": MessageLookupByLibrary.simpleMessage(
            "The mnemonic is composed of English words, please copy it and keep it in a safe place"),
        "back_up_tips_content3": MessageLookupByLibrary.simpleMessage(
            "The mnemonic phrase is lost and cannot be retrieved, please make sure to back up the mnemonic phrase"),
        "choose_caret_wallet_title":
            MessageLookupByLibrary.simpleMessage("Choose identity"),
        "confirm_mnemonic":
            MessageLookupByLibrary.simpleMessage("Confirm Mnemonic"),
        "confirm_mnemonic_sequence": MessageLookupByLibrary.simpleMessage(
            "Please click on the mnemonic words in order to confirm that you back it up correctly"),
        "confirm_mnemonic_sequence_err": MessageLookupByLibrary.simpleMessage(
            "Please click again if the mnemonic is wrong"),
        "creat_wallet": MessageLookupByLibrary.simpleMessage("Creat Wallet"),
        "creat_wallet_content":
            MessageLookupByLibrary.simpleMessage("use wallet by fist time"),
        "creat_wallet_details": MessageLookupByLibrary.simpleMessage(
            "you will have a multi-chain wallet under your identity,for example ETH、AAC"),
        "creat_wallet_fist": MessageLookupByLibrary.simpleMessage(
            "Create your first digital wallet"),
        "creat_wallet_ing":
            MessageLookupByLibrary.simpleMessage("Creat wallet now..."),
        "creat_wallet_name":
            MessageLookupByLibrary.simpleMessage("Wallet name"),
        "creat_wallet_name_input": MessageLookupByLibrary.simpleMessage(
            "Please enter you wallet name"),
        "creat_wallet_pwd": MessageLookupByLibrary.simpleMessage("Password"),
        "creat_wallet_pwd_input": MessageLookupByLibrary.simpleMessage(
            "Please enter you wallet password"),
        "creat_wallet_pwd_repeat": MessageLookupByLibrary.simpleMessage(
            "The passwords are inconsistent"),
        "creat_wallet_pwd_tips": MessageLookupByLibrary.simpleMessage(
            "No less than 8 characters, it is recommended to mix letters、 numbers、 and symbols"),
        "creat_wallet_repeat_pwd_input": MessageLookupByLibrary.simpleMessage(
            "Please repeat you wallet password"),
        "creat_wallet_tips_content": MessageLookupByLibrary.simpleMessage(
            "\n1.The password will be used as the transaction password of the wallet.\n2. The wallet will not store the password, nor can it help you retrieve it. Please be sure to keep the password properly."),
        "creat_wallet_title":
            MessageLookupByLibrary.simpleMessage("Creat wallet"),
        "language_choose":
            MessageLookupByLibrary.simpleMessage("Choose Language"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "profile_update_record":
            MessageLookupByLibrary.simpleMessage("Update record"),
        "profile_wallet_management":
            MessageLookupByLibrary.simpleMessage("Wallet Management"),
        "recover_import_mnemonic": MessageLookupByLibrary.simpleMessage(
            "Please enter the mnemonic words separated by spaces"),
        "recover_import_private_key": MessageLookupByLibrary.simpleMessage(
            "Please enter the plaintext private key"),
        "recover_wallet_content":
            MessageLookupByLibrary.simpleMessage("already have a wallet"),
        "recover_wallet_import_mnemonic":
            MessageLookupByLibrary.simpleMessage("import mnemonic"),
        "recover_wallet_import_private_key":
            MessageLookupByLibrary.simpleMessage("import private key"),
        "recover_wallet_mnemonic":
            MessageLookupByLibrary.simpleMessage("Mnemonic"),
        "recover_wallet_private_key":
            MessageLookupByLibrary.simpleMessage("Private key"),
        "recover_wallet_title":
            MessageLookupByLibrary.simpleMessage("Recover wallet"),
        "wallet": MessageLookupByLibrary.simpleMessage("Wallet"),
        "wallet_assets": MessageLookupByLibrary.simpleMessage("Assets"),
        "wallet_choose": MessageLookupByLibrary.simpleMessage("Choose wallet"),
        "wallet_create_import":
            MessageLookupByLibrary.simpleMessage("Create/Import"),
        "wallet_del": MessageLookupByLibrary.simpleMessage("Delete wallet"),
        "wallet_del_only": MessageLookupByLibrary.simpleMessage(
            "Are you sure to delete the current wallet?"),
        "wallet_details_title":
            MessageLookupByLibrary.simpleMessage("Wallet Detail"),
        "wallet_edit_name":
            MessageLookupByLibrary.simpleMessage("Wallet nickname"),
        "wallet_edit_name_error": MessageLookupByLibrary.simpleMessage(
            "Error modifying nickname, please try again later"),
        "wallet_edit_name_input": MessageLookupByLibrary.simpleMessage(
            "Please enter wallet nickname"),
        "wallet_edit_tips": MessageLookupByLibrary.simpleMessage(
            "Start with an English letter, limited to 6~16 characters"),
        "wallet_export_change_pwd":
            MessageLookupByLibrary.simpleMessage("Change password"),
        "wallet_export_mnemonic":
            MessageLookupByLibrary.simpleMessage("Export mnemonic"),
        "wallet_export_private_key":
            MessageLookupByLibrary.simpleMessage("Export private key"),
        "wallet_export_reset_pwd":
            MessageLookupByLibrary.simpleMessage("Rest password"),
        "wallet_identity":
            MessageLookupByLibrary.simpleMessage("Wallet identity"),
        "wallet_import_key_content1": MessageLookupByLibrary.simpleMessage(
            "Security warning, after exporting the private key, please keep it safe and don’t disclose it"),
        "wallet_import_key_content2": MessageLookupByLibrary.simpleMessage(
            "Once leaked, it may cause asset loss"),
        "wallet_import_key_copy":
            MessageLookupByLibrary.simpleMessage("Copy private key"),
        "wallet_import_key_copy_success":
            MessageLookupByLibrary.simpleMessage("Copy success"),
        "wallet_import_key_tips":
            MessageLookupByLibrary.simpleMessage("Import Tips"),
        "wallet_import_mnemonic_error": MessageLookupByLibrary.simpleMessage(
            "When you import, you are not importing with mnemonic"),
        "wallet_password":
            MessageLookupByLibrary.simpleMessage("Wallet Password"),
        "wallet_password_err":
            MessageLookupByLibrary.simpleMessage("Your password is error")
      };
}
