import 'package:aa_wallet/page/splash/splash_service.dart';
import 'package:aa_wallet/res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashService> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: <Widget>[
          FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 1,
            child: Image.asset(
              Res.splash,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
