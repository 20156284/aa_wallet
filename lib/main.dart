import 'dart:io';

import 'package:aa_wallet/service/wallet_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'const/app_theme.dart';
import 'core/core_kit_localizations.dart';
import 'core/toast.dart';
import 'generated/l10n.dart';
import 'page/splash/splash_service.dart';
import 'route/app_pages.dart';
import 'service/app_service.dart';
import 'service/auth_service.dart';

void main() {
  runApp(const MyApp());

  if (Platform.isAndroid) {
    const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //设置为透明
      statusBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      data: appCustomThemeData(),
      child: GetMaterialApp(
        builder: (context, child) {
          return CoreKitToastInit()(
            context,
            // FutureBuilder<void>(
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       return Material(
            //         child: CupertinoTheme(
            //           data: appCupertinoThemeData(
            //               MediaQuery.of(context).platformBrightness),
            //           child: child!,
            //         ),
            //       );
            //     }
            //     return const SplashView();
            //   },
            // ),
            Material(
              child: CupertinoTheme(
                data: appCupertinoThemeData(
                    MediaQuery.of(context).platformBrightness),
                child: InkWell(
                    // 点击空白处收起键盘
                    onTap: () => FocusScope.of(Get.overlayContext!)
                        .requestFocus(FocusNode()),
                    child: child!),
              ),
            ),
          );
        },
        theme: appThemeData(Brightness.light),
        darkTheme: appThemeData(Brightness.dark),
        debugShowCheckedModeBanner: true,
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          RefreshLocalizations.delegate,
          CoreKitLocalizations.delegate,
          AppS.delegate,
        ],
        initialBinding: BindingsBuilder(() {
          //钱包状态管理
          Get.put(WalletService());
          //app 配置的问题 比如说 APP语言 用户设置 主题都放到这个服务里面去
          Get.put(AppService(context));
          //启动屏服务 启动动画
          Get.put(SplashService());
          //用户授权信息状态管理
          Get.put(AuthService());
        }),
        navigatorObservers: [CoreKitToastNavigatorObserver()],
        supportedLocales: AppS.delegate.supportedLocales,
        title: 'AAToken',
        getPages: AppPages.routes,
        initialRoute: AppPages.INITIAL,
        logWriterCallback: (String text, {bool isError = false}) {
          Future.microtask(() => print('** $text. isError: [$isError]'));
        },
        // enableLog: true,
        // opaqueRoute: Get.isOpaqueRouteDefault,
        // popGesture: Get.isPopGestureEnable,
      ),
    );
  }
}
