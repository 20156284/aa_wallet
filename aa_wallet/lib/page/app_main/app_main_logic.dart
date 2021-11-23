import 'package:aa_wallet/page/profile/profile_page/profile_page_view.dart';
import 'package:aa_wallet/page/wallet/wallet_main/wallet_main_view.dart';
import 'package:get/get.dart';

class AppMainLogic extends GetxController {
  final bodyWidget = [const WalletMainPage(), const ProfilePage()];
  final chooseIndex = 0.obs;
}
