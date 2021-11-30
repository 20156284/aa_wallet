// ===============================================
// moor_database
//
// Create by will on 2021/11/16 19:11
// Copyright @aa_wallet.All rights reserved.
// ===============================================
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

// 建表 这里 为了安全 只是存储 用户相对应的 钱包密码 和钱包地址 钱包名称 即可 不用存私钥
@DataClassName('WalletEntry')
class Wallet extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().nullable()();

  //加密后的密码
  TextColumn get password => text().nullable()();

  //加密后的助记词
  TextColumn get mnemonic => text().nullable()();

  //加密后的私钥
  TextColumn get privateKey => text().nullable()();

  //钱包类型
  TextColumn get protocol => text().nullable()();

  //rpc地址
  TextColumn get rpcUrl => text().nullable()();

  //钱包地址
  TextColumn get address => text().nullable()();

  //是否选择为主钱包
  BoolColumn get is_main => boolean().nullable()();

  //是否第一次默认的创建 因为默认创建的话 会天机 aa的所有代币
  //其他不需要 当然相对应的删除 也就没有
  //包括回复钱包的时候 也会默认给他创建aa的代币
  BoolColumn get is_fist => boolean().nullable()();
}

@DataClassName('TokenEntry')
class Token extends Table {
  IntColumn get id => integer().autoIncrement()();

  //钱包主键的id
  IntColumn get wallet_id =>
      integer().customConstraint('NULLABLE REFERENCES wallet(id)')();

  //代币地址
  TextColumn get contractAddress => text().nullable()();

  //代币Icon
  TextColumn get imageUrl => text().nullable()();

  //代币区块
  TextColumn get protocol => text().nullable()();

  //代币名称
  TextColumn get coinKey => text().nullable()();

  //代币小数位
  IntColumn get decimals => integer().nullable()();

  //当前币种的余额 但是不会存进数据库 只是方便前端显示而已
  TextColumn get balance => text().nullable()();

  //当前币种的兑换后的显示的价格 但是不会存进数据库 只是方便前端显示而已
  TextColumn get totalMoney => text().nullable()();
}

@UseMoor(tables: [Wallet, Token])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  Future<List<WalletEntry>> getAllWallets() => select(wallet).get();

  /// 每当基础数据发生变化时，都会发出新项
  Stream<List<WalletEntry>> watchAllWallet() => select(wallet).watch();

  /// 插入一条数据
  Future<int> insertWallet({
    String? name,
    String? password,
    String? mnemonic,
    String? privateKey,
    String? protocol,
    String? address,
    String? rpcUrl,
    bool? isMain,
    bool? isFist,
  }) =>
      into(wallet).insert(
        WalletCompanion(
          name: Value(name),
          password: Value(password),
          privateKey: Value(privateKey),
          protocol: Value(protocol),
          address: Value(address),
          mnemonic: Value(mnemonic),
          rpcUrl: Value(rpcUrl),
          is_main: Value(isMain),
          is_fist: Value(isFist),
        ),
      );

  /// 更新一条数据
  Future<bool> updateWallet(WalletEntry entry) => update(wallet).replace(entry);

  /// 删除一条数据
  Future<int> deleteWallet(WalletEntry entry) => delete(wallet).delete(entry);

  Future<List<TokenEntry>> getAllToken() => select(token).get();

  /// 每当基础数据发生变化时，都会发出新项
  Stream<List<TokenEntry>> watchAllToken() => select(token).watch();

  /// 插入一条数据
  Future<int> insertToken({
    required int wallet_id,
    String? contractAddress,
    String? imageUrl,
    String? protocol,
    String? coinKey,
    int? decimals,
  }) =>
      into(token).insert(
        TokenCompanion(
          wallet_id: Value(wallet_id),
          contractAddress: Value(contractAddress),
          imageUrl: Value(imageUrl),
          protocol: Value(protocol),
          coinKey: Value(coinKey),
          decimals: Value(decimals),
        ),
      );

  /// 更新一条数据
  Future<bool> updateToken(TokenEntry tokenEntry) =>
      update(token).replace(tokenEntry);

  /// 删除一条数据
  Future<int> deleteToken(TokenEntry tokenEntry) =>
      delete(token).delete(tokenEntry);
}
