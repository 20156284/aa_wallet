// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppS {
  AppS();

  static AppS? _current;

  static AppS get current {
    assert(_current != null,
        'No instance of AppS was loaded. Try to initialize the AppS delegate before accessing AppS.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppS> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppS();
      AppS._current = instance;

      return instance;
    });
  }

  static AppS of(BuildContext context) {
    final instance = AppS.maybeOf(context);
    assert(instance != null,
        'No instance of AppS present in the widget tree. Did you add AppS.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppS? maybeOf(BuildContext context) {
    return Localizations.of<AppS>(context, AppS);
  }

  /// `AAToken`
  String get app_name {
    return Intl.message(
      'AAToken',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get app_cancel {
    return Intl.message(
      'cancel',
      name: 'app_cancel',
      desc: '',
      args: [],
    );
  }

  /// `confirm`
  String get app_confirm {
    return Intl.message(
      'confirm',
      name: 'app_confirm',
      desc: '',
      args: [],
    );
  }

  /// `location permission is close`
  String get app_permission_location_close {
    return Intl.message(
      'location permission is close',
      name: 'app_permission_location_close',
      desc: '',
      args: [],
    );
  }

  /// `microphone permission is close`
  String get app_permission_microphone_close {
    return Intl.message(
      'microphone permission is close',
      name: 'app_permission_microphone_close',
      desc: '',
      args: [],
    );
  }

  /// `photos permission is close`
  String get app_permission_photos_close {
    return Intl.message(
      'photos permission is close',
      name: 'app_permission_photos_close',
      desc: '',
      args: [],
    );
  }

  /// `camera permission is close`
  String get app_permission_camera_close {
    return Intl.message(
      'camera permission is close',
      name: 'app_permission_camera_close',
      desc: '',
      args: [],
    );
  }

  /// `video permission is close`
  String get app_permission_video_close {
    return Intl.message(
      'video permission is close',
      name: 'app_permission_video_close',
      desc: '',
      args: [],
    );
  }

  /// `storage permission is close`
  String get app_permission_storage_close {
    return Intl.message(
      'storage permission is close',
      name: 'app_permission_storage_close',
      desc: '',
      args: [],
    );
  }

  /// `permission tips`
  String get app_permission_title {
    return Intl.message(
      'permission tips',
      name: 'app_permission_title',
      desc: '',
      args: [],
    );
  }

  /// `open permission`
  String get app_permission_open {
    return Intl.message(
      'open permission',
      name: 'app_permission_open',
      desc: '',
      args: [],
    );
  }

  /// `form album`
  String get app_album {
    return Intl.message(
      'form album',
      name: 'app_album',
      desc: '',
      args: [],
    );
  }

  /// `take photo`
  String get app_camera {
    return Intl.message(
      'take photo',
      name: 'app_camera',
      desc: '',
      args: [],
    );
  }

  /// `save photo`
  String get app_save_photos {
    return Intl.message(
      'save photo',
      name: 'app_save_photos',
      desc: '',
      args: [],
    );
  }

  /// `save photo success`
  String get app_save_photos_success {
    return Intl.message(
      'save photo success',
      name: 'app_save_photos_success',
      desc: '',
      args: [],
    );
  }

  /// `save photo fail`
  String get app_save_photos_failure {
    return Intl.message(
      'save photo fail',
      name: 'app_save_photos_failure',
      desc: '',
      args: [],
    );
  }

  /// `copy success`
  String get app_copy_success {
    return Intl.message(
      'copy success',
      name: 'app_copy_success',
      desc: '',
      args: [],
    );
  }

  /// `I know`
  String get app_i_know {
    return Intl.message(
      'I know',
      name: 'app_i_know',
      desc: '',
      args: [],
    );
  }

  /// `find new version V{version}`
  String app_update_version(Object version) {
    return Intl.message(
      'find new version V$version',
      name: 'app_update_version',
      desc: '',
      args: [version],
    );
  }

  /// `coming soon`
  String get app_build_now {
    return Intl.message(
      'coming soon',
      name: 'app_build_now',
      desc: '',
      args: [],
    );
  }

  /// `no date`
  String get app_no_date {
    return Intl.message(
      'no date',
      name: 'app_no_date',
      desc: '',
      args: [],
    );
  }

  /// `uploading {num}...`
  String app_img_upload(Object num) {
    return Intl.message(
      'uploading $num...',
      name: 'app_img_upload',
      desc: '',
      args: [num],
    );
  }

  /// `Tips`
  String get app_tips {
    return Intl.message(
      'Tips',
      name: 'app_tips',
      desc: '',
      args: [],
    );
  }

  /// `AAToken {version}`
  String app_version(Object version) {
    return Intl.message(
      'AAToken $version',
      name: 'app_version',
      desc: '',
      args: [version],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message(
      'Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Assets`
  String get wallet_assets {
    return Intl.message(
      'Assets',
      name: 'wallet_assets',
      desc: '',
      args: [],
    );
  }

  /// `Choose wallet`
  String get wallet_choose {
    return Intl.message(
      'Choose wallet',
      name: 'wallet_choose',
      desc: '',
      args: [],
    );
  }

  /// `Wallet identity`
  String get wallet_identity {
    return Intl.message(
      'Wallet identity',
      name: 'wallet_identity',
      desc: '',
      args: [],
    );
  }

  /// `Create/Import`
  String get wallet_create_import {
    return Intl.message(
      'Create/Import',
      name: 'wallet_create_import',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Update record`
  String get profile_update_record {
    return Intl.message(
      'Update record',
      name: 'profile_update_record',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Management`
  String get profile_wallet_management {
    return Intl.message(
      'Wallet Management',
      name: 'profile_wallet_management',
      desc: '',
      args: [],
    );
  }

  /// `Choose Language`
  String get language_choose {
    return Intl.message(
      'Choose Language',
      name: 'language_choose',
      desc: '',
      args: [],
    );
  }

  /// `Creat wallet`
  String get creat_wallet_title {
    return Intl.message(
      'Creat wallet',
      name: 'creat_wallet_title',
      desc: '',
      args: [],
    );
  }

  /// `use wallet by fist time`
  String get creat_wallet_content {
    return Intl.message(
      'use wallet by fist time',
      name: 'creat_wallet_content',
      desc: '',
      args: [],
    );
  }

  /// `you will have a multi-chain wallet under your identity,for example ETH、AAC`
  String get creat_wallet_details {
    return Intl.message(
      'you will have a multi-chain wallet under your identity,for example ETH、AAC',
      name: 'creat_wallet_details',
      desc: '',
      args: [],
    );
  }

  /// `Wallet name`
  String get creat_wallet_name {
    return Intl.message(
      'Wallet name',
      name: 'creat_wallet_name',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get creat_wallet_pwd {
    return Intl.message(
      'Password',
      name: 'creat_wallet_pwd',
      desc: '',
      args: [],
    );
  }

  /// `Please enter you wallet name`
  String get creat_wallet_name_input {
    return Intl.message(
      'Please enter you wallet name',
      name: 'creat_wallet_name_input',
      desc: '',
      args: [],
    );
  }

  /// `Please enter you wallet password`
  String get creat_wallet_pwd_input {
    return Intl.message(
      'Please enter you wallet password',
      name: 'creat_wallet_pwd_input',
      desc: '',
      args: [],
    );
  }

  /// `Please repeat you wallet password`
  String get creat_wallet_repeat_pwd_input {
    return Intl.message(
      'Please repeat you wallet password',
      name: 'creat_wallet_repeat_pwd_input',
      desc: '',
      args: [],
    );
  }

  /// `No less than 8 characters, it is recommended to mix letters、 numbers、 and symbols`
  String get creat_wallet_pwd_tips {
    return Intl.message(
      'No less than 8 characters, it is recommended to mix letters、 numbers、 and symbols',
      name: 'creat_wallet_pwd_tips',
      desc: '',
      args: [],
    );
  }

  /// `Creat Wallet`
  String get creat_wallet {
    return Intl.message(
      'Creat Wallet',
      name: 'creat_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Create your first digital wallet`
  String get creat_wallet_fist {
    return Intl.message(
      'Create your first digital wallet',
      name: 'creat_wallet_fist',
      desc: '',
      args: [],
    );
  }

  /// `\n1.The password will be used as the transaction password of the wallet.\n2. The wallet will not store the password, nor can it help you retrieve it. Please be sure to keep the password properly.`
  String get creat_wallet_tips_content {
    return Intl.message(
      '\n1.The password will be used as the transaction password of the wallet.\n2. The wallet will not store the password, nor can it help you retrieve it. Please be sure to keep the password properly.',
      name: 'creat_wallet_tips_content',
      desc: '',
      args: [],
    );
  }

  /// `The passwords are inconsistent`
  String get creat_wallet_pwd_repeat {
    return Intl.message(
      'The passwords are inconsistent',
      name: 'creat_wallet_pwd_repeat',
      desc: '',
      args: [],
    );
  }

  /// `Creat wallet now...`
  String get creat_wallet_ing {
    return Intl.message(
      'Creat wallet now...',
      name: 'creat_wallet_ing',
      desc: '',
      args: [],
    );
  }

  /// `BackUp Tips`
  String get back_up_tips {
    return Intl.message(
      'BackUp Tips',
      name: 'back_up_tips',
      desc: '',
      args: [],
    );
  }

  /// `Obtaining the mnemonic phrase is equivalent to owning the wallet asset ownership`
  String get back_up_tips_content1 {
    return Intl.message(
      'Obtaining the mnemonic phrase is equivalent to owning the wallet asset ownership',
      name: 'back_up_tips_content1',
      desc: '',
      args: [],
    );
  }

  /// `The mnemonic is composed of English words, please copy it and keep it in a safe place`
  String get back_up_tips_content2 {
    return Intl.message(
      'The mnemonic is composed of English words, please copy it and keep it in a safe place',
      name: 'back_up_tips_content2',
      desc: '',
      args: [],
    );
  }

  /// `The mnemonic phrase is lost and cannot be retrieved, please make sure to back up the mnemonic phrase`
  String get back_up_tips_content3 {
    return Intl.message(
      'The mnemonic phrase is lost and cannot be retrieved, please make sure to back up the mnemonic phrase',
      name: 'back_up_tips_content3',
      desc: '',
      args: [],
    );
  }

  /// `Please don't capture screen`
  String get back_up_do_not_screen_capture1 {
    return Intl.message(
      'Please don\'t capture screen',
      name: 'back_up_do_not_screen_capture1',
      desc: '',
      args: [],
    );
  }

  /// `Do not take screenshots to share and store, it may be collected by third-party malware and cause asset loss`
  String get back_up_do_not_screen_capture2 {
    return Intl.message(
      'Do not take screenshots to share and store, it may be collected by third-party malware and cause asset loss',
      name: 'back_up_do_not_screen_capture2',
      desc: '',
      args: [],
    );
  }

  /// `BackUp mnemonic`
  String get back_up_mnemonic_title {
    return Intl.message(
      'BackUp mnemonic',
      name: 'back_up_mnemonic_title',
      desc: '',
      args: [],
    );
  }

  /// `Please copy the mnemonic words in order to ensure that the backup is correct`
  String get back_up_mnemonic {
    return Intl.message(
      'Please copy the mnemonic words in order to ensure that the backup is correct',
      name: 'back_up_mnemonic',
      desc: '',
      args: [],
    );
  }

  /// `\n1. Properly keep the mnemonic phrase to a safe place isolated from the network.\n2. Do not share and store mnemonic words in a networked environment, such as emails, photo albums, social applications, etc.`
  String get back_up_mnemonic_tips {
    return Intl.message(
      '\n1. Properly keep the mnemonic phrase to a safe place isolated from the network.\n2. Do not share and store mnemonic words in a networked environment, such as emails, photo albums, social applications, etc.',
      name: 'back_up_mnemonic_tips',
      desc: '',
      args: [],
    );
  }

  /// `Confirm BackUp`
  String get back_up_mnemonic_confirm {
    return Intl.message(
      'Confirm BackUp',
      name: 'back_up_mnemonic_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Mnemonic`
  String get confirm_mnemonic {
    return Intl.message(
      'Confirm Mnemonic',
      name: 'confirm_mnemonic',
      desc: '',
      args: [],
    );
  }

  /// `Please click on the mnemonic words in order to confirm that you back it up correctly`
  String get confirm_mnemonic_sequence {
    return Intl.message(
      'Please click on the mnemonic words in order to confirm that you back it up correctly',
      name: 'confirm_mnemonic_sequence',
      desc: '',
      args: [],
    );
  }

  /// `Please click again if the mnemonic is wrong`
  String get confirm_mnemonic_sequence_err {
    return Intl.message(
      'Please click again if the mnemonic is wrong',
      name: 'confirm_mnemonic_sequence_err',
      desc: '',
      args: [],
    );
  }

  /// `Add Coin type`
  String get add_coin_type_title {
    return Intl.message(
      'Add Coin type',
      name: 'add_coin_type_title',
      desc: '',
      args: [],
    );
  }

  /// `Please add the coin under the identity wallet (multiple choice)`
  String get add_coin_type_subtitle {
    return Intl.message(
      'Please add the coin under the identity wallet (multiple choice)',
      name: 'add_coin_type_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Recover wallet`
  String get recover_wallet_title {
    return Intl.message(
      'Recover wallet',
      name: 'recover_wallet_title',
      desc: '',
      args: [],
    );
  }

  /// `already have a wallet`
  String get recover_wallet_content {
    return Intl.message(
      'already have a wallet',
      name: 'recover_wallet_content',
      desc: '',
      args: [],
    );
  }

  /// `Mnemonic`
  String get recover_wallet_mnemonic {
    return Intl.message(
      'Mnemonic',
      name: 'recover_wallet_mnemonic',
      desc: '',
      args: [],
    );
  }

  /// `import mnemonic`
  String get recover_wallet_import_mnemonic {
    return Intl.message(
      'import mnemonic',
      name: 'recover_wallet_import_mnemonic',
      desc: '',
      args: [],
    );
  }

  /// `Private key`
  String get recover_wallet_private_key {
    return Intl.message(
      'Private key',
      name: 'recover_wallet_private_key',
      desc: '',
      args: [],
    );
  }

  /// `import private key`
  String get recover_wallet_import_private_key {
    return Intl.message(
      'import private key',
      name: 'recover_wallet_import_private_key',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the mnemonic words separated by spaces`
  String get recover_import_mnemonic {
    return Intl.message(
      'Please enter the mnemonic words separated by spaces',
      name: 'recover_import_mnemonic',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the plaintext private key`
  String get recover_import_private_key {
    return Intl.message(
      'Please enter the plaintext private key',
      name: 'recover_import_private_key',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Detail`
  String get wallet_details_title {
    return Intl.message(
      'Wallet Detail',
      name: 'wallet_details_title',
      desc: '',
      args: [],
    );
  }

  /// `Export mnemonic`
  String get wallet_export_mnemonic {
    return Intl.message(
      'Export mnemonic',
      name: 'wallet_export_mnemonic',
      desc: '',
      args: [],
    );
  }

  /// `Export private key`
  String get wallet_export_private_key {
    return Intl.message(
      'Export private key',
      name: 'wallet_export_private_key',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get wallet_export_change_pwd {
    return Intl.message(
      'Change password',
      name: 'wallet_export_change_pwd',
      desc: '',
      args: [],
    );
  }

  /// `Rest password`
  String get wallet_export_reset_pwd {
    return Intl.message(
      'Rest password',
      name: 'wallet_export_reset_pwd',
      desc: '',
      args: [],
    );
  }

  /// `Delete wallet`
  String get wallet_del {
    return Intl.message(
      'Delete wallet',
      name: 'wallet_del',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete the current wallet?`
  String get wallet_del_only {
    return Intl.message(
      'Are you sure to delete the current wallet?',
      name: 'wallet_del_only',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Password`
  String get wallet_password {
    return Intl.message(
      'Wallet Password',
      name: 'wallet_password',
      desc: '',
      args: [],
    );
  }

  /// `Your password is error`
  String get wallet_password_err {
    return Intl.message(
      'Your password is error',
      name: 'wallet_password_err',
      desc: '',
      args: [],
    );
  }

  /// `When you import, you are not importing with mnemonic`
  String get wallet_import_mnemonic_error {
    return Intl.message(
      'When you import, you are not importing with mnemonic',
      name: 'wallet_import_mnemonic_error',
      desc: '',
      args: [],
    );
  }

  /// `Import Tips`
  String get wallet_import_key_tips {
    return Intl.message(
      'Import Tips',
      name: 'wallet_import_key_tips',
      desc: '',
      args: [],
    );
  }

  /// `Security warning, after exporting the private key, please keep it safe and don’t disclose it`
  String get wallet_import_key_content1 {
    return Intl.message(
      'Security warning, after exporting the private key, please keep it safe and don’t disclose it',
      name: 'wallet_import_key_content1',
      desc: '',
      args: [],
    );
  }

  /// `Once leaked, it may cause asset loss`
  String get wallet_import_key_content2 {
    return Intl.message(
      'Once leaked, it may cause asset loss',
      name: 'wallet_import_key_content2',
      desc: '',
      args: [],
    );
  }

  /// `Copy private key`
  String get wallet_import_key_copy {
    return Intl.message(
      'Copy private key',
      name: 'wallet_import_key_copy',
      desc: '',
      args: [],
    );
  }

  /// `Copy success`
  String get wallet_import_key_copy_success {
    return Intl.message(
      'Copy success',
      name: 'wallet_import_key_copy_success',
      desc: '',
      args: [],
    );
  }

  /// `Wallet nickname`
  String get wallet_edit_name {
    return Intl.message(
      'Wallet nickname',
      name: 'wallet_edit_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter wallet nickname`
  String get wallet_edit_name_input {
    return Intl.message(
      'Please enter wallet nickname',
      name: 'wallet_edit_name_input',
      desc: '',
      args: [],
    );
  }

  /// `Start with an English letter, limited to 6~16 characters`
  String get wallet_edit_tips {
    return Intl.message(
      'Start with an English letter, limited to 6~16 characters',
      name: 'wallet_edit_tips',
      desc: '',
      args: [],
    );
  }

  /// `Error modifying nickname, please try again later`
  String get wallet_edit_name_error {
    return Intl.message(
      'Error modifying nickname, please try again later',
      name: 'wallet_edit_name_error',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppS> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppS> load(Locale locale) => AppS.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
