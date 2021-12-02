import 'package:aa_wallet/page/profile/profile_page/profile_page_view.dart';
import 'package:aa_wallet/page/wallet/wallet_main/wallet_main_view.dart';
import 'package:get/get.dart';

class AppMainLogic extends GetxController {
  final bodyWidget = [const WalletMainPage(), const ProfilePage()];
  final chooseIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    checkAppUpdate();
  }

  // Future<AppUpgradeInfo> checkAppInfo(
  //     SysResp sysResp, List<String> contents) async {
  //   //这里一般访问网络接口，将返回的数据解析成如下格式
  //   // return Future.delayed(const Duration(seconds: 0), () {
  //   //
  //   // });
  //
  //   return AppUpgradeInfo(
  //     title: AppS().app_update_version(sysResp.info!.versions!),
  //     contents: contents,
  //     force: sysResp.info!.force_up == 1,
  //     apkDownloadUrl: Platform.isIOS ? sysResp.info!.ios_url : sysResp.urls!,
  //   );
  // }

  void checkAppUpdate() async {
    // final packageInfo = await PackageInfo.fromPlatform();
    // SysApi.acquire()
    //     .getVersion(
    //   version: packageInfo.version,
    //   client: Platform.operatingSystem,
    //   isList: false,
    // )
    //     .then(
    //   (value) {
    //     if (value != null) {
    //       bool isUpdate = CoreUtil.versionCheck(
    //           localVersion: packageInfo.version,
    //           serverVersion: value.info!.versions);
    //       if (isUpdate) {
    //         List<String> contents = <String>[];
    //         try {
    //           contents = value.content!.replaceAll('<br>', '').split('\r\n');
    //         } catch (e) {
    //           contents = <String>[value.content!];
    //         }
    //
    //         AppUpgrade.appUpgrade(
    //           Get.context!,
    //           checkAppInfo(value, contents),
    //           iosAppId: SDKKey.appId,
    //           okBackgroundColors: [
    //             const Color(0xFF44AFFF),
    //             const Color(0xFF0091FF),
    //           ],
    //           okTextStyle: TextStyle(
    //               color: CupertinoTheme.of(Get.context!).primaryColor),
    //           progressBarColor:
    //               AppTheme.of(Get.context!).tabActiveColor.withOpacity(0.4),
    //         );
    //       }
    //     }
    //   },
    // );
  }
}
