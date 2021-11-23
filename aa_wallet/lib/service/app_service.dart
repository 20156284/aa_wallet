// ===============================================
// app_service
//
// Create by will on 2021/11/10 10:29
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'dart:convert';
import 'dart:ui';
import 'package:aa_wallet/entity/language_info.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/preference/app_preferences.dart';
import 'package:aa_wallet/preference/app_user_preferences.dart';
import 'package:aa_wallet/res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppService extends GetxService {
  AppService(this.context);

  final BuildContext context;

  static AppService get to => Get.find();

  final app = AppPreferences().obs;
  final langList = <LanguageInfo>[].obs;
  final haveBackUpMnemonic = false.obs;

  @override
  void onInit() async {
    super.onInit();
    _onLoadLanguage();
    onReadConfig();
    //监听 app 设置的 的变化
    ever(app, handleAppChanged);
  }

  /**
   * 加载语言
   * @author Will
   * @date 2021/11/16 14:52
   */
  void _onLoadLanguage() async {
    final String data =
        await DefaultAssetBundle.of(context).loadString(Res.language);
    final List<dynamic> languageList = json.decode(data) as List<dynamic>;
    final List<LanguageInfo> list = <LanguageInfo>[];
    for (final dynamic map in languageList) {
      final LanguageInfo languageInfo =
          LanguageInfo.fromJson(map as Map<String, dynamic>);
      list.add(languageInfo);
    }
    langList.value = list;
  }

  /**
   * 监听app 配置的变换 而重新更改
   * @author Will
   * @date 2021/11/16 14:16
   * @param 监听变化的对象
   */
  void handleAppChanged(_app) async {}

  /**
   * 读取用户设置的配置
   * @author Will
   * @date 2021/11/16 14:04
   */
  void onReadConfig() async {
    // 读取用户配置 方便写入内存 到时候 可以相应配读取用户信息
    final storeApp = (await AppUserPreferences.getInstance()).app;
    app.value = storeApp;
    if (storeApp.languageInfo != null) {
      changeLanguage(Locale(storeApp.languageInfo!.languageCode!,
          storeApp.languageInfo!.countryCode!));
    } else {
      //给出默认的 英文界面
      changeLanguage(const Locale('en', 'US'));
    }
  }

  /**
   * 语言的转换
   *
   * @author Will
   * @date 2021/11/16 10:48
   * @param 传入的本地化
   */
  void changeLanguage(Locale locale) {
    Get.updateLocale(locale);
    AppS.load(locale);

    _chooseLanguage(locale);
  }

  /**
   * 选择语言 让新设置的语言 保存起来
   * @author Will
   * @date 2021/11/16 15:12
   * @param null
   * @return null
   */
  void _chooseLanguage(Locale locale) {
    for (final lang in langList) {
      if (lang.languageCode == locale.languageCode &&
          lang.countryCode == locale.countryCode) {
        app.update((val) {
          val!.languageInfo = lang;
        });
        app.refresh();

        //通常 使用获取用户信息之后 存入数据库 让数据永远保存最新的一份
        AppUserPreferences.getInstance().then((v) => v.setApp(app.value));
        break;
      }
    }
  }
}
