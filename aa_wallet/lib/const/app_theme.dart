// ===============================================
// app_theme
// 主题有空要配置黑夜模式
// Create by Will on 2020/10/5 6:17 PM
// Copyright @aa_wallet.All rights reserved.
// ===============================================

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme extends StatelessWidget {
  const AppTheme({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  final AppThemeData data;
  final Widget child;

  static AppThemeData of(BuildContext context) {
    final _InheritedSugarTheme inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedSugarTheme>()!;
    return inheritedTheme.theme.data;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedSugarTheme(
      theme: this,
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class _InheritedSugarTheme extends InheritedWidget {
  const _InheritedSugarTheme({
    Key? key,
    required this.theme,
    required Widget child,
  }) : super(key: key, child: child);

  final AppTheme theme;

  @override
  bool updateShouldNotify(_InheritedSugarTheme old) =>
      theme.data != old.theme.data;
}

class AppThemeData with Diagnosticable {
  const AppThemeData({
    this.secondaryTextStyle = const TextStyle(
      color: Color(0xff707070),
      fontSize: 14,
      fontWeight: FontWeight.normal,
      textBaseline: TextBaseline.alphabetic,
    ),
    this.auxiliaryText = const TextStyle(
      color: Color(0xff5f5f5f),
      fontWeight: FontWeight.w300,
    ),
    this.hintText = const TextStyle(
      color: Color(0xff8f8f8f),
      height: 1,
    ),
    this.backButtonColor = const CupertinoDynamicColor.withBrightness(
      color: Color(0xFF1A1A1A),
      darkColor: CupertinoColors.white,
    ),
    this.dividerColor = const CupertinoDynamicColor.withBrightness(
      color: Color(0xFFE0E0E0),
      darkColor: Colors.white,
    ),
    this.tabBarBackgroundColor = const CupertinoDynamicColor.withBrightness(
      color: Color(0xFFFEFFFE),
      darkColor: Colors.black,
    ),
    this.sealingLineColor = const Color(0xffd1d1d1),
    this.listTileColor = CupertinoColors.systemBackground,
    this.onlineColor = const Color(0xffDCF4E6),
    this.tabActiveColor = const CupertinoDynamicColor.withBrightness(
      color: Color(0xFF1D1D1D),
      darkColor: Color(0xFFF9F9F9),
      // Values extracted from navigation bar. For toolbar or tabBar the dark color is 0xF0161616.
    ),
    this.vipBackgroundColor = const Color(0xff4A4C6C),
    this.userLabelColor = const Color(0xffEBEFF2),
    this.receiveMessageBubbleDecoration = const BoxDecoration(
      color: CupertinoDynamicColor.withBrightness(
        color: CupertinoColors.white,
        darkColor: CupertinoColors.black,
      ),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    this.chevronRightColor = const CupertinoDynamicColor.withBrightness(
      color: Color(0xFFCCCCCC),
      darkColor: CupertinoColors.white,
    ),
    this.inputBgColor = const Color(0xFFF9FBFF),
  });

  // 用于普通级段落信息引导词
  final TextStyle secondaryTextStyle;

  // 用于普通级段落信息引导词
  final Color inputBgColor;

  // 用于辅助、次要的文字信息、普通按钮描边
  final TextStyle auxiliaryText;

  // 用于需要输入文字框内的提示性文字
  final TextStyle hintText;

  final Color backButtonColor;

  // 分割线颜色
  final Color dividerColor;

  // 密封线颜色
  final Color sealingLineColor;

  final Color listTileColor;

  // 在线搭配颜色
  final Color onlineColor;

  // 在线搭配颜色
  final Color tabActiveColor;

  final Color tabBarBackgroundColor;

  final Color userLabelColor;

  // vip 背景颜色
  final Color vipBackgroundColor;

  // 消息气泡
  final BoxDecoration receiveMessageBubbleDecoration;

  final Color chevronRightColor;
}

class AppTextTheme extends TextTheme {
  AppTextTheme({
    // NavigationBar title
    // 标题栏-标题
    final Color? headLineColor,
    // ListTile title
    final Color? subtitleColor1,
    // ListTile subtitle
    final Color? subtitleColor2,
    // Used for emphasizing text that would otherwise be [bodyText2].
    final Color? bodyTextColor1,
    // The default text style for [Material].
    final Color? bodyTextColor2,
    // Auxiliary text
    // 注释类文本
    final Color? captionColor,
  }) : super(
          headline1: defaultTextTheme.headline1!.apply(
            color: headLineColor,
          ),
          headline2: defaultTextTheme.headline2!.apply(
            color: headLineColor,
          ),
          headline3: defaultTextTheme.headline3!.apply(
            color: headLineColor,
          ),
          headline4: defaultTextTheme.headline4!.apply(
            color: headLineColor,
          ),
          headline5: defaultTextTheme.headline5!.apply(
            color: headLineColor,
          ),
          headline6: defaultTextTheme.headline6!.apply(
            color: headLineColor,
          ),
          subtitle1: defaultTextTheme.subtitle1!.apply(
            color: subtitleColor1,
          ),
          subtitle2: defaultTextTheme.subtitle2!.apply(
            color: subtitleColor2,
          ),
          bodyText1: defaultTextTheme.bodyText1!.apply(
            color: bodyTextColor1,
          ),
          bodyText2: defaultTextTheme.bodyText2!.apply(
            color: bodyTextColor2,
          ),
          caption: defaultTextTheme.caption!.apply(
            color: captionColor,
          ),
        );

  static const defaultTextTheme = Typography.dense2018;
  static const color1 = CupertinoColors.white;
  static const color2 = Color(0xFFCECECE);
  static const color3 = Color(0xFFADADAD);
  static const color4 = Color(0xFF666666);
  static const color5 = Color(0xFF444444);
}

ThemeData appThemeData(Brightness brightness) {
  final cupertinoThemeData = appCupertinoThemeData(brightness);

  return ThemeData(
    brightness: cupertinoThemeData.brightness,
    primaryColor: cupertinoThemeData.primaryColor,
    primarySwatch: createMaterialColor(cupertinoThemeData.primaryColor),
    scaffoldBackgroundColor: cupertinoThemeData.scaffoldBackgroundColor,
    dividerColor: const Color(0xFFDCE2E9),
    splashColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      color: cupertinoThemeData.primaryColor,
      iconTheme: const IconThemeData(color: Colors.white),
      // brightness: cupertinoThemeData.brightness,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //设置为透明
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: cupertinoThemeData.brightness,
      ),
    ),
    textTheme: AppTextTheme(
      headLineColor: AppTextTheme.color5,
      subtitleColor1: AppTextTheme.color5,
      subtitleColor2: AppTextTheme.color4,
      bodyTextColor1: AppTextTheme.color3,
      bodyTextColor2: AppTextTheme.color5,
      captionColor: AppTextTheme.color2,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
      },
    ),
    cupertinoOverrideTheme: cupertinoThemeData,
    dividerTheme: const DividerThemeData(
      color: Color(0xFFDCE2E9),
      space: 0,
      thickness: 0.5,
      indent: 0,
      endIndent: 0,
    ),
  );
}

CupertinoThemeData appCupertinoThemeData(Brightness brightness) {
  return CupertinoThemeData(
    primaryColor: const CupertinoDynamicColor.withBrightness(
      color: Color(0xFF0F6EFF),
      darkColor: Color(0xFF0F6EFF),
    ),
    barBackgroundColor: const CupertinoDynamicColor.withBrightness(
      color: Color(0xffFFCC00),
      darkColor: Colors.black,
    ),
    brightness: brightness,
    primaryContrastingColor: const Color.fromRGBO(50, 110, 255, 1),
    scaffoldBackgroundColor: const CupertinoDynamicColor(
      color: Color(0xFFF6F6F6),
      darkColor: Colors.black,
      highContrastColor: Color.fromARGB(255, 255, 255, 255),
      darkHighContrastColor: Color.fromARGB(255, 0, 0, 0),
      elevatedColor: Color.fromARGB(255, 255, 255, 255),
      darkElevatedColor: Color.fromARGB(255, 28, 28, 30),
      highContrastElevatedColor: Color.fromARGB(255, 255, 255, 255),
      darkHighContrastElevatedColor: Color.fromARGB(255, 36, 36, 38),
    ),
    textTheme: const CupertinoTextThemeData(
      textStyle: TextStyle(
        color: CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.white,
          darkColor: CupertinoColors.black,
        ),
        fontSize: 14,
      ),
      actionTextStyle: TextStyle(
        color: Color(0xffC0C0C0),
      ),
      tabLabelTextStyle: TextStyle(
        color: CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.black,
          darkColor: CupertinoColors.white,
        ),
        fontSize: 12,
      ),
      navTitleTextStyle: TextStyle(
        color: CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.black,
          darkColor: CupertinoColors.white,
        ),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      navLargeTitleTextStyle: TextStyle(
        color: CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.white,
          darkColor: CupertinoColors.black,
        ),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      navActionTextStyle: TextStyle(
        color: CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.black,
          darkColor: CupertinoColors.white,
        ),
        // color: const Color(0xffFFCC00),
        fontSize: 18,
      ),
    ),
  );
}

AppThemeData appCustomThemeData() {
  return const AppThemeData();
}

MaterialColor createMaterialColor(Color color) {
  final List<double> strengths = <double>[.05];
  final Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (final double strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
