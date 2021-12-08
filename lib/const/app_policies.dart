// ===============================================
// app_policies
//
// Create by will on 2021/1/12 16:41
// Copyright @treasure-app.All rights reserved.
// ===============================================

class AppPolicies {
  // static const testAvatar = '${AppServers.baseUrl}/group1/M00/00/08/rB4AAl-3q9eAciJ5AAAJCmUNgrg510.png?attname=default_avatar.png';
  static const testAvatar = 'assets/images/ic_default.png';

  //最大支持图片数量
  static const int lotteryGroupMaxPic = 9;
  //一行放几张图片
  static const int crossAxisCount = 3;
  //GridView 子之间的间距
  static const double Spacing = 10;

  static const String appCode = 'LOTTERY_MERCHANT';

  // 所有function hash
  static const funcHashes = {
    'filled(bytes32)': '0x288cdc91',
    'getOrderQueueInfo(address,address,bool)': '0x22f42f6b',
    'transfer(address,uint256)': '0xa9059cbb',
    'getOrderInfo(bytes32,bytes32,bool)': '0xb7f92b4a',
    'takeOrder()': '0xefe29415',
    'approve()': '0x095ea7b3',
    'allowance': '0xdd62ed3e',
    'cancelOrder(bytes32,bytes32)': '0xa47d9d33',
    'cancelOrder2(bytes32,bytes32)': '0xa18d42d3',
    'orderFlag(bytes32)': '0xf8a8db0e',
    'sellQueue(bytes32)': '0xf875a998',
    'getOrderDepth(bytes32)': '0x3e8c0c4c',
    'getBQODHash()': '0xefe331cf',
    'getBQHash()': '0x30d598ed',
    'getDecimals()': '0x313ce567',
    'getTokenBalance()': '0x70a08231',
    'getConfigData()': '0xfeee047e',
    'getConfigSignature()': '0x0b973ca2',
    'orderFlags(bytes32 od_hash)': '0x76356e86',
    'configurations(string key)': '0x1214dd58',
  };

  static const int maxGas = 100000;
}
