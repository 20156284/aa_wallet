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

  /// `Delete`
  String get app_del {
    return Intl.message(
      'Delete',
      name: 'app_del',
      desc: '',
      args: [],
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

  /// `No less than 8 characters, mixed letters, numbers, symbols`
  String get creat_wallet_pwd_tips {
    return Intl.message(
      'No less than 8 characters, mixed letters, numbers, symbols',
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

  /// `Creat wallet finish`
  String get creat_wallet_finish {
    return Intl.message(
      'Creat wallet finish',
      name: 'creat_wallet_finish',
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

  /// `Copy mnemonic`
  String get back_up_mnemonic_copy {
    return Intl.message(
      'Copy mnemonic',
      name: 'back_up_mnemonic_copy',
      desc: '',
      args: [],
    );
  }

  /// `Mnemonic has copy`
  String get back_up_mnemonic_confirm_success {
    return Intl.message(
      'Mnemonic has copy',
      name: 'back_up_mnemonic_confirm_success',
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

  /// `The mnemonic phrase should be 12 words`
  String get recover_import_mnemonic_tips {
    return Intl.message(
      'The mnemonic phrase should be 12 words',
      name: 'recover_import_mnemonic_tips',
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

  /// `The standard key length is 64 bits`
  String get recover_import_private_key_tips {
    return Intl.message(
      'The standard key length is 64 bits',
      name: 'recover_import_private_key_tips',
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

  /// `Copy success`
  String get wallet_add_copy_success {
    return Intl.message(
      'Copy success',
      name: 'wallet_add_copy_success',
      desc: '',
      args: [],
    );
  }

  /// `Wallet address has existing`
  String get wallet_has {
    return Intl.message(
      'Wallet address has existing',
      name: 'wallet_has',
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

  /// `Choose coin type`
  String get add_wallet_choose_coin_type {
    return Intl.message(
      'Choose coin type',
      name: 'add_wallet_choose_coin_type',
      desc: '',
      args: [],
    );
  }

  /// `ETH`
  String get add_wallet_eth {
    return Intl.message(
      'ETH',
      name: 'add_wallet_eth',
      desc: '',
      args: [],
    );
  }

  /// `Ethereum`
  String get add_wallet_eth_subtitle {
    return Intl.message(
      'Ethereum',
      name: 'add_wallet_eth_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `BTC`
  String get add_wallet_btc {
    return Intl.message(
      'BTC',
      name: 'add_wallet_btc',
      desc: '',
      args: [],
    );
  }

  /// `Bitcoin`
  String get add_wallet_btc_subtitle {
    return Intl.message(
      'Bitcoin',
      name: 'add_wallet_btc_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `AAA`
  String get add_wallet_aac {
    return Intl.message(
      'AAA',
      name: 'add_wallet_aac',
      desc: '',
      args: [],
    );
  }

  /// `AAcoin`
  String get add_wallet_aac_subtitle {
    return Intl.message(
      'AAcoin',
      name: 'add_wallet_aac_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose identity`
  String get choose_caret_wallet_title {
    return Intl.message(
      'Choose identity',
      name: 'choose_caret_wallet_title',
      desc: '',
      args: [],
    );
  }

  /// `Add Token`
  String get token_add {
    return Intl.message(
      'Add Token',
      name: 'token_add',
      desc: '',
      args: [],
    );
  }

  /// `Main Assets Management`
  String get token_main_assets {
    return Intl.message(
      'Main Assets Management',
      name: 'token_main_assets',
      desc: '',
      args: [],
    );
  }

  /// `All Assets`
  String get token_user_all_assets {
    return Intl.message(
      'All Assets',
      name: 'token_user_all_assets',
      desc: '',
      args: [],
    );
  }

  /// `Customize Token`
  String get token_customize {
    return Intl.message(
      'Customize Token',
      name: 'token_customize',
      desc: '',
      args: [],
    );
  }

  /// `Please enter token name or token address`
  String get add_token_input {
    return Intl.message(
      'Please enter token name or token address',
      name: 'add_token_input',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get token_details_transfer {
    return Intl.message(
      'Transfer',
      name: 'token_details_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Collection`
  String get token_details_collection {
    return Intl.message(
      'Collection',
      name: 'token_details_collection',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get token_details_state_all {
    return Intl.message(
      'All',
      name: 'token_details_state_all',
      desc: '',
      args: [],
    );
  }

  /// `Out`
  String get token_details_state_transfer_out {
    return Intl.message(
      'Out',
      name: 'token_details_state_transfer_out',
      desc: '',
      args: [],
    );
  }

  /// `In`
  String get token_details_state_transfer_in {
    return Intl.message(
      'In',
      name: 'token_details_state_transfer_in',
      desc: '',
      args: [],
    );
  }

  /// `≈{money} ASDT`
  String token_details_roughly_money(Object money) {
    return Intl.message(
      '≈$money ASDT',
      name: 'token_details_roughly_money',
      desc: '',
      args: [money],
    );
  }

  /// `Transfer Total`
  String get token_transfer_cell_total {
    return Intl.message(
      'Transfer Total',
      name: 'token_transfer_cell_total',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Address`
  String get token_transfer_cell_addr {
    return Intl.message(
      'Transfer Address',
      name: 'token_transfer_cell_addr',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Hash`
  String get token_transfer_cell_hash {
    return Intl.message(
      'Transfer Hash',
      name: 'token_transfer_cell_hash',
      desc: '',
      args: [],
    );
  }

  /// `Transfer State`
  String get token_transfer_cell_state {
    return Intl.message(
      'Transfer State',
      name: 'token_transfer_cell_state',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Time`
  String get token_transfer_cell_time {
    return Intl.message(
      'Transfer Time',
      name: 'token_transfer_cell_time',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Address`
  String get token_transfer_addr {
    return Intl.message(
      'Transfer Address',
      name: 'token_transfer_addr',
      desc: '',
      args: [],
    );
  }

  /// `Please enter aacoin address`
  String get token_transfer_addr_input {
    return Intl.message(
      'Please enter aacoin address',
      name: 'token_transfer_addr_input',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get token_transfer_money {
    return Intl.message(
      'Amount',
      name: 'token_transfer_money',
      desc: '',
      args: [],
    );
  }

  /// `please enter amount`
  String get token_transfer_money_input {
    return Intl.message(
      'please enter amount',
      name: 'token_transfer_money_input',
      desc: '',
      args: [],
    );
  }

  /// `AAA Amount:{amount}`
  String token_transfer_money_aa(Object amount) {
    return Intl.message(
      'AAA Amount:$amount',
      name: 'token_transfer_money_aa',
      desc: '',
      args: [amount],
    );
  }

  /// `Fee`
  String get token_transfer_fee {
    return Intl.message(
      'Fee',
      name: 'token_transfer_fee',
      desc: '',
      args: [],
    );
  }

  /// `Fee:{fee}`
  String token_transfer_fee_aa(Object fee) {
    return Intl.message(
      'Fee:$fee',
      name: 'token_transfer_fee_aa',
      desc: '',
      args: [fee],
    );
  }

  /// `Slow`
  String get token_transfer_slow {
    return Intl.message(
      'Slow',
      name: 'token_transfer_slow',
      desc: '',
      args: [],
    );
  }

  /// `0/{money}AAA<30minute`
  String token_transfer_slow_info(Object money) {
    return Intl.message(
      '0/${money}AAA<30minute',
      name: 'token_transfer_slow_info',
      desc: '',
      args: [money],
    );
  }

  /// `Recommend`
  String get token_transfer_recommend {
    return Intl.message(
      'Recommend',
      name: 'token_transfer_recommend',
      desc: '',
      args: [],
    );
  }

  /// `0/{money}AAA<5minute`
  String token_transfer_recommend_info(Object money) {
    return Intl.message(
      '0/${money}AAA<5minute',
      name: 'token_transfer_recommend_info',
      desc: '',
      args: [money],
    );
  }

  /// `Quick`
  String get token_transfer_quick {
    return Intl.message(
      'Quick',
      name: 'token_transfer_quick',
      desc: '',
      args: [],
    );
  }

  /// `0/{money}AAA<1minute`
  String token_transfer_quick_info(Object money) {
    return Intl.message(
      '0/${money}AAA<1minute',
      name: 'token_transfer_quick_info',
      desc: '',
      args: [money],
    );
  }

  /// `Customize`
  String get token_transfer_customize {
    return Intl.message(
      'Customize',
      name: 'token_transfer_customize',
      desc: '',
      args: [],
    );
  }

  /// `Insufficient expenses`
  String get token_transfer_fee_err {
    return Intl.message(
      'Insufficient expenses',
      name: 'token_transfer_fee_err',
      desc: '',
      args: [],
    );
  }

  /// `This address only supports AACOIN assets, please do not transfer to other public chain assets`
  String get collections_addr_tips {
    return Intl.message(
      'This address only supports AACOIN assets, please do not transfer to other public chain assets',
      name: 'collections_addr_tips',
      desc: '',
      args: [],
    );
  }

  /// `Scan the QR code and transfer to {coin}`
  String collections_addr_in_eth(Object coin) {
    return Intl.message(
      'Scan the QR code and transfer to $coin',
      name: 'collections_addr_in_eth',
      desc: '',
      args: [coin],
    );
  }

  /// `Copy address`
  String get collections_addr_copy {
    return Intl.message(
      'Copy address',
      name: 'collections_addr_copy',
      desc: '',
      args: [],
    );
  }

  /// `Wallet address`
  String get collections_addr {
    return Intl.message(
      'Wallet address',
      name: 'collections_addr',
      desc: '',
      args: [],
    );
  }

  /// `Before Password`
  String get change_page_now_pwd {
    return Intl.message(
      'Before Password',
      name: 'change_page_now_pwd',
      desc: '',
      args: [],
    );
  }

  /// `Please enter before password`
  String get change_page_now_pwd_input {
    return Intl.message(
      'Please enter before password',
      name: 'change_page_now_pwd_input',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get change_page_new_pwd {
    return Intl.message(
      'New Password',
      name: 'change_page_new_pwd',
      desc: '',
      args: [],
    );
  }

  /// `Please enter new password`
  String get change_page_new_pwd_input {
    return Intl.message(
      'Please enter new password',
      name: 'change_page_new_pwd_input',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get change_page_confirm_pwd {
    return Intl.message(
      'Confirm password',
      name: 'change_page_confirm_pwd',
      desc: '',
      args: [],
    );
  }

  /// `Please enter confirm password`
  String get change_page_confirm_pwd_input {
    return Intl.message(
      'Please enter confirm password',
      name: 'change_page_confirm_pwd_input',
      desc: '',
      args: [],
    );
  }

  /// `Confirm change`
  String get change_page_confirm {
    return Intl.message(
      'Confirm change',
      name: 'change_page_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Change password success`
  String get change_page_pwd_success {
    return Intl.message(
      'Change password success',
      name: 'change_page_pwd_success',
      desc: '',
      args: [],
    );
  }

  /// `Change password fail`
  String get change_page_pwd_fail {
    return Intl.message(
      'Change password fail',
      name: 'change_page_pwd_fail',
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
