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
  TextColumn get name => text().withLength(min: 1, max: 50)();
  //加密后的密码
  TextColumn get password => text()();
  //加密后的助记词
  TextColumn get mnemonic => text()();
  //加密后的私钥
  TextColumn get privateKey => text()();
  //钱包类型
  TextColumn get protocol => text()();
  //rpc地址
  TextColumn get rpcUrl => text()();
  TextColumn get address => text()();
  BoolColumn get is_main => boolean()();
}

@UseMoor(tables: [Wallet])
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
  }) =>
      into(wallet).insert(
        WalletCompanion(
          name: Value(name ?? ''),
          password: Value(password ?? ''),
          privateKey: Value(privateKey ?? ''),
          protocol: Value(protocol ?? ''),
          address: Value(address ?? ''),
          mnemonic: Value(mnemonic ?? ''),
          rpcUrl: Value(rpcUrl ?? ''),
          is_main: Value(isMain ?? false),
        ),
      );

  /// 更新一条数据
  Future<bool> updateWallet(WalletEntry entry) => update(wallet).replace(entry);

  /// 删除一条数据
  Future<int> deleteWallet(WalletEntry entry) => delete(wallet).delete(entry);
}
