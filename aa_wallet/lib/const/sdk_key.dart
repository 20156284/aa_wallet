// ===============================================
// sdk_key
//
// Create by will on 2021/1/11 11:18
// Copyright @treasure-app.All rights reserved.
// ===============================================

class SDKKey {
  SDKKey();

  static const amapAppKeyIOS = '40a8598c53d49c3c6ed689a186c89a23';
  static const amapAppKeyAndroid = '0e7ab9e994def244274602dbe73751bd';

  //腾讯qq开放者平台
  static const String tencentAndroidId = '1106252921';

  static const String tencentIosId = '1109836158';

  //微信开发者平台
  static String WECHAT_APPID = 'wx0922d1855c7e8e1b';
  static String WECHAT_UNIVERSAL_LINK = 'https://www.abopin.com/'; // iOS 请配置
  static String WECHAT_APPSECRET = '1d2ebbb5b452ac6a3e31cf4b11cb07a0';
  static String WECHAT_MINIAPPID = 'your wechat miniAppId';
  static String WECHAT_PARTNERID = '1604306883';

  static const bool alipayUseRSA2 = true;
  static const String alipayAppId = '2021002129608488'; // 支付/登录
  static const String alipayPID = 'your alipay pid'; // 登录
  static const String alipayTargetId = 'your alipay targetId'; // 登录
  static const String alipayPrivateKey =
      'your alipay rsa private key(pkcs1/pkcs8)'; // 支付/登录

  static const String appId = '';
}
