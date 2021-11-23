// ===============================================
// env_config
//
// Create by will on 2021/10/16 12:10
// Copyright @aa_wallet.All rights reserved.
// ===============================================

// 环境配置
class EnvConfig {
  EnvConfig({
    required this.appTitle,
    required this.baseUrl,
    required this.aaaRpcUrl,
    required this.ethRpcUrl,
  });

  //环境名称
  final String appTitle;

  //服务器地址
  final String baseUrl;

  //aaaRpc 的地址
  final String aaaRpcUrl;
  //ethRpc 的地址
  final String ethRpcUrl;

  // // 代理合约，用来给token授权
  // final String proxy;
  //
  // // 钱包合约 you-match:
  // // 执行下单等操作
  // final String tempMatchAddress;

  // // 收取交易费的账户relayer ，测试阶段用SHT的合约账户代替
  // static const taxAddress = "0xA9535b10EE96b4A03269D0e0DEf417aF97477FD6";
  //
  // // 查询订单的匹配了多个额度在这个合约上查询
  // static const hydroAddress = "0xF5cE9570F8523456cbffB4b18e201cD8d0a6A090";
  //
  // // 新增一个配置合约，用来获取交易页面右侧的token列表信息
  // static const youMatchConfig ="0xc607fE1c04f7ed326561e0C061Fcd20423759851";
}

// 获取的配置信息
class Env {
  Env();

  // 获取到当前环境
  static const appEnv = String.fromEnvironment(EnvName.envKey);

  // 开发环境
  static final EnvConfig _debugConfig = EnvConfig(
    appTitle: 'debugTitle',
    baseUrl: 'http://test2-api.aapay.io',
    aaaRpcUrl: 'http://159.138.134.163:8000',
    ethRpcUrl: 'http://159.138.134.163:8000',
  );

  // 发布环境
  static final EnvConfig _releaseConfig = EnvConfig(
    appTitle: 'releaseTitle',
    baseUrl: 'http://test2-api.aapay.io',
    aaaRpcUrl: 'http://119.8.104.104:8000',
    ethRpcUrl: 'http://119.8.104.104:8000',
  );

  // 测试环境
  static final EnvConfig _testConfig = EnvConfig(
    appTitle: 'testTitle',
    baseUrl: 'http://test2-api.aapay.io',
    aaaRpcUrl: 'http://119.8.104.104:8000',
    ethRpcUrl: 'http://119.8.104.104:8000',
  );

  static EnvConfig get envConfig => _getEnvConfig();

// 根据不同环境返回对应的环境配置
  static EnvConfig _getEnvConfig() {
    switch (appEnv) {
      case EnvName.debug:
        return _debugConfig;
      case EnvName.release:
        return _releaseConfig;
      case EnvName.test:
        return _testConfig;
      default:
        return _debugConfig;
    }
  }
}

// 声明的环境
abstract class EnvName {
  // 环境key
  static const String envKey = 'APP_ENV';

  // 环境value
  static const String debug = 'Debug';
  static const String release = 'Release';
  static const String test = 'Test';
}
