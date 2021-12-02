// ===============================================
// app_pages
//
// Create by will on 2021/10/25 12:05
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'package:aa_wallet/page/app_main/app_main_binding.dart';
import 'package:aa_wallet/page/app_main/app_main_view.dart';
import 'package:aa_wallet/page/coin_type/coin_type_binding.dart';
import 'package:aa_wallet/page/coin_type/coin_type_view.dart';
import 'package:aa_wallet/page/language_choose/language_choose_binding.dart';
import 'package:aa_wallet/page/language_choose/language_choose_view.dart';
import 'package:aa_wallet/page/lead/back_up_mnemonic/back_up_mnemonic_binding.dart';
import 'package:aa_wallet/page/lead/back_up_mnemonic/back_up_mnemonic_view.dart';
import 'package:aa_wallet/page/lead/back_up_tips/back_up_tips_binding.dart';
import 'package:aa_wallet/page/lead/back_up_tips/back_up_tips_view.dart';
import 'package:aa_wallet/page/lead/confirm_mnemonic/confirm_mnemonic_binding.dart';
import 'package:aa_wallet/page/lead/confirm_mnemonic/confirm_mnemonic_view.dart';
import 'package:aa_wallet/page/lead/creat_wallet/creat_wallet_binding.dart';
import 'package:aa_wallet/page/lead/creat_wallet/creat_wallet_view.dart';
import 'package:aa_wallet/page/lead/lead/lead_binding.dart';
import 'package:aa_wallet/page/lead/lead/lead_view.dart';
import 'package:aa_wallet/page/lead/recover_by_mnemonic/recover_by_mnemonic_binding.dart';
import 'package:aa_wallet/page/lead/recover_by_mnemonic/recover_by_mnemonic_view.dart';
import 'package:aa_wallet/page/lead/recover_by_private_key/recover_by_private_key_binding.dart';
import 'package:aa_wallet/page/lead/recover_by_private_key/recover_by_private_key_view.dart';
import 'package:aa_wallet/page/lead/recover_wallet/recover_wallet_binding.dart';
import 'package:aa_wallet/page/lead/recover_wallet/recover_wallet_view.dart';
import 'package:aa_wallet/page/profile/profile_page/profile_page_binding.dart';
import 'package:aa_wallet/page/profile/update_record/update_record_binding.dart';
import 'package:aa_wallet/page/profile/update_record/update_record_view.dart';
import 'package:aa_wallet/page/splash/splash_view.dart';
import 'package:aa_wallet/page/wallet/add_token/add_token_binding.dart';
import 'package:aa_wallet/page/wallet/add_token/add_token_view.dart';
import 'package:aa_wallet/page/wallet/add_wallet/add_wallet_binding.dart';
import 'package:aa_wallet/page/wallet/add_wallet/add_wallet_view.dart';
import 'package:aa_wallet/page/wallet/choose_creat_wallet/choose_creat_wallet_binding.dart';
import 'package:aa_wallet/page/wallet/choose_creat_wallet/choose_creat_wallet_view.dart';
import 'package:aa_wallet/page/wallet/collection_address/collection_address_binding.dart';
import 'package:aa_wallet/page/wallet/collection_address/collection_address_view.dart';
import 'package:aa_wallet/page/wallet/export_private_key/export_private_key_binding.dart';
import 'package:aa_wallet/page/wallet/export_private_key/export_private_key_view.dart';
import 'package:aa_wallet/page/wallet/token_details/token_details_binding.dart';
import 'package:aa_wallet/page/wallet/token_details/token_details_view.dart';
import 'package:aa_wallet/page/wallet/token_transfer/token_transfer_binding.dart';
import 'package:aa_wallet/page/wallet/token_transfer/token_transfer_view.dart';
import 'package:aa_wallet/page/wallet/wallet_details/wallet_details_binding.dart';
import 'package:aa_wallet/page/wallet/wallet_details/wallet_details_view.dart';
import 'package:aa_wallet/page/wallet/wallet_edit_name/wallet_edit_name_binding.dart';
import 'package:aa_wallet/page/wallet/wallet_edit_name/wallet_edit_name_view.dart';
import 'package:aa_wallet/page/wallet/wallet_main/wallet_main_binding.dart';
import 'package:aa_wallet/page/wallet/wallet_management/wallet_management_binding.dart';
import 'package:aa_wallet/page/wallet/wallet_management/wallet_management_view.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = _Paths.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.appMain,
      page: () => const AppMainPage(),
      transition: Transition.zoom,
      bindings: [
        AppMainBinding(),
        WalletMainBinding(),
        ProfilePageBinding(),
      ],
    ),
    GetPage(
      name: _Paths.lead,
      page: () => const LeadPage(),
      binding: LeadBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.coinType,
      page: () => const CoinTypePage(),
      binding: CoinTypeBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.languageChoose,
      page: () => const LanguageChoosePage(),
      binding: LanguageChooseBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.creatWallet,
      page: () => const CreatWalletPage(),
      binding: CreatWalletBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.backUp,
      page: () => const BackUpTipsPage(),
      binding: BackUpTipsBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.backUpMnemonic,
      page: () => const BackUpMnemonicPage(),
      binding: BackUpMnemonicBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.confirmMnemonic,
      page: () => const ConfirmMnemonicPage(),
      binding: ConfirmMnemonicBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.recoverWallet,
      page: () => const RecoverWalletPage(),
      binding: RecoverWalletBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.recoverByMnemonic,
      page: () => const RecoverByMnemonicPage(),
      binding: RecoverByMnemonicBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.recoverByPrivateKey,
      page: () => const RecoverByPrivateKeyPage(),
      binding: RecoverByPrivateKeyBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.walletDetails,
      page: () => const WalletDetailsPage(),
      binding: WalletDetailsBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.walletEditName,
      page: () => const WalletEditNamePage(),
      binding: WalletEditNameBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.exportPrivateKey,
      page: () => const ExportPrivateKeyPage(),
      binding: ExportPrivateKeyBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.walletManagement,
      page: () => const WalletManagementPage(),
      binding: WalletManagementBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.addWallet,
      page: () => const AddWalletPage(),
      binding: AddWalletBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.chooseCreatWallet,
      page: () => const ChooseCreatWalletPage(),
      binding: ChooseCreatWalletBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.addToken,
      page: () => const AddTokenPage(),
      binding: AddTokenBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.tokenDetails,
      page: () => const TokenDetailsPage(),
      binding: TokenDetailsBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.tokenTransfer,
      page: () => const TokenTransferPage(),
      binding: TokenTransferBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.collectionAddress,
      page: () => const CollectionAddressPage(),
      binding: CollectionAddressBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.updateRecord,
      page: () => const UpdateRecordPage(),
      binding: UpdateRecordBinding(),
      transition: Transition.cupertino,
    ),
  ];
}
