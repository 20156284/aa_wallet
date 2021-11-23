// ===============================================
// core_utils
//
// Create by will on 2021/9/3 10:32
// Copyright @interstellar.All rights reserved.
// ===============================================

import 'dart:math';

class CoreUtil {
  const CoreUtil();
  // 是否是空字符串
  static bool isEmptyString(String? str) {
    if (str == null || str.isEmpty) {
      return true;
    }
    return false;
  }

  // 是否不是空字符串
  static bool isNotEmptyString(String? str) {
    if (str != null && str.isNotEmpty) {
      return true;
    }
    return false;
  }

  // 🔥格式化手机号为344
  static String formatMobile344(String mobile) {
    if (isEmptyString(mobile)) return '';
    mobile =
        mobile.replaceAllMapped(RegExp(r'(^\d{3}|\d{4}\B)'), (Match match) {
      return '${match.group(0)} ';
    });
    if (mobile.endsWith(' ')) {
      mobile = mobile.substring(0, mobile.length - 1);
    }
    return mobile;
  }

  /// 纯数字 ^[0-9]*$
  static bool pureDigitCharacters(String input) {
    const String regex = r'^[0-9]*$';
    return matches(regex, input);
  }

  ///只允许输入小数 ^[0-9.]*$
  static bool pureDecimalCharacters(String input) {
    const String regex = r'^[0-9.]*$';
    return matches(regex, input);
  }

  //正则中国手机
  static bool validMobileByChina(String input) {
    const String regex =
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$';
    return !matches(regex, input);
  }

  // 🔥是否为正确的QQ号码、微信号、QQ邮箱
  // - [微信号正则校验，qq正则，邮箱正则,英文名正则](https://blog.csdn.net/qq_29091239/article/details/80075981)
  // - [微信号正则校验](https://blog.csdn.net/unknowna/article/details/50524529)
  // - [更多正则匹配](https://blog.csdn.net/IMW_MG/article/details/78705359)
  static bool validQQ(String input) {
    const String regex = r'^[1-9][0-9]{4,9}$';
    return matches(regex, input);
  }

  static bool validWeChatId(String input) {
    const String regex = r'^[a-zA-Z]{1}[-_a-zA-Z0-9]{5,19}$';
    return matches(regex, input);
  }

  static bool validQQMail(String input) {
    const String regex = r'^[1-9][0-9]{4,9}@qq.com $';
    return matches(regex, input);
  }

  static bool fistIsNm(String input) {
    const String regex = r'^([1-9][0-9]*)+(.[0-9]{0,1})?$';
    return matches(regex, input);
  }

  static bool minMax(String input, int min, int max) {
    final String regex = '^.{$min,$max}\$';
    return !matches(regex, input);
  }

  static bool custom(String input, String regex) {
    return !matches(regex, input);
  }

  /// 匹配
  static bool matches(String regex, String input) {
    if (input.isEmpty) return false;
    final bool match = RegExp(regex).hasMatch(input);
    return match;
  }

  static bool versionCheck({String? localVersion, String? serverVersion}) {
    if (serverVersion == null || localVersion == null) return false;

    int serverVersionInt, localVersionInt;

    if (serverVersion.contains('v') || serverVersion.contains('V')) {
      serverVersion = serverVersion.replaceAll('v', '');
      serverVersion = serverVersion.replaceAll('V', '');
    }

    final serverList = serverVersion.split('.');
    final localList = localVersion.split('.');
    if (serverList.isEmpty || localList.isEmpty) {
      return false;
    }

    try {
      //预防版本好出现问题 报错卡着
      for (int i = 0; i < serverList.length; i++) {
        serverVersionInt = int.parse(serverList[i]);
        localVersionInt = int.parse(localList[i]);
        if (serverVersionInt > localVersionInt) {
          return true;
        } else if (serverVersionInt < localVersionInt) {
          return false;
        }
      }
    } catch (error) {
      return false;
    }
    return false;
  }

  static String randomBit(int len) {
    const String scopeF = '123456789'; //首位
    const String scopeC = '0123456789'; //中间
    String result = '';
    for (int i = 0; i < len; i++) {
      if (i == 0) {
        result = scopeF[Random().nextInt(scopeF.length)];
      } else {
        result = result + scopeC[Random().nextInt(scopeC.length)];
      }
    }
    return result;
  }
}
