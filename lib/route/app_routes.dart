// ===============================================
// app_routes
//
// Create by will on 2021/10/25 12:05
// Copyright @aa_wallet.All rights reserved.
// ===============================================

part of 'app_pages.dart';

abstract class AppRoutes {
  AppRoutes._();

  static const lead = _Paths.lead;
  static const splash = _Paths.splash;
  static const coinType = _Paths.coinType;

  static const appMain = _Paths.appMain;
  static const languageChoose = _Paths.languageChoose;

  static const creatWallet = _Paths.creatWallet;
  static const backUp = _Paths.backUp;
  static const backUpMnemonic = _Paths.backUpMnemonic;
  static const confirmMnemonic = _Paths.confirmMnemonic;
  static const recoverWallet = _Paths.recoverWallet;
  static const recoverByMnemonic = _Paths.recoverByMnemonic;
  static const recoverByPrivateKey = _Paths.recoverByPrivateKey;
  static const walletDetails = _Paths.walletDetails;
  static const walletEditName = _Paths.walletEditName;
  static const exportPrivateKey = _Paths.exportPrivateKey;
  static const walletManagement = _Paths.walletManagement;
  static const addWallet = _Paths.addWallet;
  static const chooseCreatWallet = _Paths.chooseCreatWallet;
  static const addToken = _Paths.addToken;
  static const tokenDetails = _Paths.tokenDetails;
  static const tokenTransfer = _Paths.tokenTransfer;
  static const collectionAddress = _Paths.collectionAddress;
  static const updateRecord = _Paths.updateRecord;
}

abstract class _Paths {
  static const String splash = '/splashView';
  static const String appMain = '/appMainPage';
  static const String languageChoose = '/languageChoose';

  static const String lead = '/lead';
  static const String coinType = '/coinType';

  static const String creatWallet = '/creatWallet';
  static const String backUp = '/backUp';
  static const String backUpMnemonic = '/backUpMnemonic';
  static const String confirmMnemonic = '/confirmMnemonic';
  static const String recoverWallet = '/recoverWallet';
  static const String recoverByMnemonic = '/recoverByMnemonic';
  static const String recoverByPrivateKey = '/recoverByPrivateKey';
  static const String walletDetails = '/walletDetails';
  static const String walletEditName = '/walletEditName';
  static const String exportPrivateKey = '/exportPrivateKey';
  static const String walletManagement = '/walletManagement';
  static const String addWallet = '/addWallet';
  static const String chooseCreatWallet = '/chooseCreatWallet';
  static const String addToken = '/addToken';
  static const String tokenDetails = '/tokenDetails';
  static const String tokenTransfer = '/tokenTransfer';
  static const String collectionAddress = '/collectionAddress';
  static const String updateRecord = '/updateRecord';
}
