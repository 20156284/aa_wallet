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
    required this.aaaWss,
    required this.ethWss,
  });

  //环境名称
  final String appTitle;

  //服务器地址
  final String baseUrl;

  //aaaRpc 的地址
  final String aaaRpcUrl;
  //ethRpc 的地址
  final String ethRpcUrl;

  //aaa wss 的地址
  final String aaaWss;
  //ethRpc 的地址
  final String ethWss;
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
    ethRpcUrl: 'http://eth.aachain.org',
    aaaWss: '',
    ethWss: 'wss://ropsten.infura.io/ws/v3/4129fe30d0a340388d20e1fbd19d8039',
  );

  // 发布环境
  static final EnvConfig _releaseConfig = EnvConfig(
    appTitle: 'releaseTitle',
    baseUrl: 'https://aatoken.aachain.org',
    aaaRpcUrl: 'http://rpc.aachain.org',
    ethRpcUrl: 'http://eth.aachain.org',
    aaaWss: '',
    ethWss: 'wss://mainnet.infura.io/ws/v3/4129fe30d0a340388d20e1fbd19d8039',
  );

  // 开发抓包
  static final EnvConfig _charlesDebugConfig = EnvConfig(
    appTitle: 'debugTitle',
    baseUrl: 'http://test2-api.aapay.io',
    aaaRpcUrl: 'http://159.138.134.163:8000',
    ethRpcUrl: 'https://ropsten.infura.io/v3/4129fe30d0a340388d20e1fbd19d8039',
    aaaWss: '',
    ethWss: 'wss://ropsten.infura.io/ws/v3/4129fe30d0a340388d20e1fbd19d8039',
  );

  // 上线抓包
  static final EnvConfig _charlesReleaseConfig = EnvConfig(
    appTitle: 'releaseTitle',
    baseUrl: 'https://aatoken.aachain.org',
    aaaRpcUrl: 'http://rpc.aachain.org',
    ethRpcUrl: 'http://eth.aachain.org',
    aaaWss: '',
    ethWss: 'wss://mainnet.infura.io/ws/v3/4129fe30d0a340388d20e1fbd19d8039',
  );

  static EnvConfig get envConfig => _getEnvConfig();

// 根据不同环境返回对应的环境配置
  static EnvConfig _getEnvConfig() {
    switch (appEnv) {
      case EnvName.debug:
        return _debugConfig;
      case EnvName.release:
        return _releaseConfig;

      case EnvName.charlesDebug:
        return _charlesDebugConfig;
      case EnvName.charlesRelease:
        return _charlesReleaseConfig;
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

  static const String charlesDebug = 'CharlesDebug';
  static const String charlesRelease = 'CharlesRelease';
}
