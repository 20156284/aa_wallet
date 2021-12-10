// ===============================================
// auth_controller
//
// Create by will on 2021/5/17 21:47
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'dart:io';

import 'package:aa_wallet/const/env_config.dart';
import 'package:aa_wallet/core/core_kit.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:aa_wallet/service/app_service.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  @override
  void onInit() async {
    super.onInit();

    // //开启代理抓包
    // HttpProxyOverride httpProxyOverride =
    //     await HttpProxyOverride.createHttpProxy();
    // if (Env.appEnv != EnvName.release) {
    //   if (httpProxyOverride.host != null && httpProxyOverride.port != null) {
    //     HttpOverrides.global = httpProxyOverride;
    //   }
    // }
    configureCoreKit();
    _loadLocalDate();
  }

  /**
   * 加載本地緩存 判斷用戶是否存在
   * @author Will
   * @date 2021/11/20 11:53
   */
  void _loadLocalDate() async {
    //查找用户是否 创建过钱包 如果创建过 直接不引导
    if (await getAllWall()) {
      Get.offAllNamed(AppRoutes.appMain);
    } else {
      //没用户数据 跳转 引导页面
      Get.offAllNamed(AppRoutes.lead);
    }
    //檢測更新
    AppService.to.checkAppUpdate();
    // Get.offAllNamed(AppRoutes.coinType);
  }

  /**
   * 配置app請求路徑預防被串改
   * @author Will
   * @date 2021/11/20 11:53
   */
  void configureCoreKit() async {
    final packageInfo = await PackageInfo.fromPlatform();

    // 初始化CoreKit
    CoreKit.config = CoreKitConfig(
      apiBaseUrlsGetter: Future.value([Env.envConfig.baseUrl]),
      apiHeadersGenerator: () async {
        final Map<String, dynamic> headers = {
          'platformType': Platform.operatingSystem,
          'version': packageInfo.version,
        };

        return headers;
      }(),
    );
  }

  /**
   * 获取用户的所有钱包
   * @author Will
   * @date 2021/11/17 11:20
   */
  Future<bool> getAllWall() async {
    final List<WalletEntry> walletList =
        await WalletService.to.appDate.getAllWallets();
    return walletList.isNotEmpty;
  }
}
