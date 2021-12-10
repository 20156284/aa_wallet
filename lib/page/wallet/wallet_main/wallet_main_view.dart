import 'package:aa_wallet/const/env_config.dart';
import 'package:aa_wallet/core/toast.dart';
import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/data_base/moor_database.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:aa_wallet/page/wallet/wallet_management_widget/wallet_management_widget_view.dart';
import 'package:aa_wallet/res.dart';
import 'package:aa_wallet/route/app_pages.dart';
import 'package:aa_wallet/service/wallet_service.dart';
import 'package:aa_wallet/utils/token_server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'wallet_main_logic.dart';

class WalletMainPage extends StatefulWidget {
  const WalletMainPage({Key? key}) : super(key: key);

  @override
  _WalletMainPageState createState() => _WalletMainPageState();
}

class _WalletMainPageState extends State<WalletMainPage> {
  final WalletMainLogic logic = Get.put(WalletMainLogic());

  //刷新控件
  late RefreshController refreshCtrl = RefreshController(initialRefresh: true);

  late Worker worker;

  @override
  void initState() {
    super.initState();
    final walletService = WalletService.to;
    //监听钱包的变化
    worker = ever(walletService.wallet, handleWalletChanged);
  }

  /**
   * 监听钱包变换的事件
   * @author Will
   * @date 2021/11/18 15:05
   * @param _wallet 钱包实体类
   */
  void handleWalletChanged(WalletEntry _wallet) async {
    logic.wallet.value = _wallet;
    logic.wallet.refresh();
    logic.onShow();
    onRefreshFun();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().wallet),
        backgroundColor: Colors.white,
        border: Border.all(width: 0.0, style: BorderStyle.none),
        leading: InkWell(
          onTap: () => onShowMoreWallet(),
          child: Container(
            height: kMinInteractiveDimensionCupertino,
            width: kMinInteractiveDimensionCupertino,
            alignment: Alignment.centerLeft,
            child: Image.asset(
              Res.ic_choose,
              height: 24,
              width: 24,
            ),
          ),
        ),
      ),
      child: Obx(
        () => SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: const WaterDropHeader(),
          controller: refreshCtrl,
          onRefresh: () => onRefreshFun(),
          child: _buildChild(),
        ),
      ),
      // child: Column(
      //   children: [
      //     _buildWalletMain(),
      //     _buildAssets(),
      //   ],
      // ),
    );
  }

  Widget _buildChild() {
    return ListView.builder(
      itemBuilder: (c, i) {
        switch (i) {
          case 0:
            return _buildWalletMain();
          case 1:
            return _buildAssets();
          default:
            final tokenEntry = logic.tokenList[i - 2];
            return _buildCell(
              title: tokenEntry.coinKey,
              imageUrl: tokenEntry.imageUrl,
              balance: tokenEntry.balance,
              totalMoney: tokenEntry.totalMoney,
              onTap: () =>
                  Get.toNamed(AppRoutes.tokenDetails, arguments: tokenEntry),
            );
        }
      },
      itemCount: logic.tokenList.length + 2,
    );
  }

  Widget _buildWalletMain() {
    return Container(
      width: Get.width - 15 * 2,
      height: Get.width * 108 / 375,
      decoration: BoxDecoration(
        color: const Color(0xFF0F6EFF),
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              print(logic.wallet.value.toString());
              Get.toNamed(AppRoutes.walletDetails,
                  arguments: logic.wallet.value);
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Obx(
                  () => Text(
                    logic.wallet.value.name ?? '',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                Image.asset(
                  Res.ic_more,
                  width: 14,
                  height: 3,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          Obx(
            () => InkWell(
              onTap: () => logic.onCopy(),
              child: Text(
                logic.showAddress.value,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppS().wallet_assets,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () => logic.onAddAssets(),
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.centerRight,
              child: const Icon(
                CupertinoIcons.add_circled,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCell(
      {required String? title,
      String? imageUrl,
      String? balance,
      String? totalMoney,
      GestureTapCallback? onTap}) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CoreKitStyle.image(imageUrl!, size: 40),
                const SizedBox(
                  width: 13,
                ),
                Expanded(
                  child: Text(
                    title ?? '',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      balance ?? '',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      totalMoney ?? '',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF878889),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Divider(
            indent: 71,
          ),
        ],
      ),
    );
  }

  void onShowMoreWallet() {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (context) {
        return Container(
          width: Get.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          height: Get.height * 2 / 3,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.centerLeft,
                        child: const Icon(
                          CupertinoIcons.clear,
                          color: Colors.black,
                          size: 13,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        AppS().wallet_choose,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                        Get.toNamed(AppRoutes.walletManagement);
                      },
                      child: Text(
                        AppS().profile_wallet_management,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const Expanded(
                child: WalletManagementWidgetPage(
                  isDialog: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void onRefreshFun() async {
    //默认的rpcUrl
    String rpcUrl = Env.envConfig.aaaRpcUrl;
    final walletService = WalletService.to;

    switch (walletService.protocol.value) {
      case 'ERC20':
        rpcUrl = Env.envConfig.ethRpcUrl;
        break;
      case 'TRC20':
        break;
      case 'ARC20':
        rpcUrl = Env.envConfig.aaaRpcUrl;
        break;
    }

    final cancelFunc = CoreKitToast.showLoading();

    WalletService.to.appDate.getAllToken().then((value) async {
      logic.dbTokenList = value;

      final newList = <TokenEntry>[];
      for (final tokenEntry in logic.dbTokenList) {
        TokenEntry newTokenEntry = TokenEntry(id: 0, wallet_id: 0);
        //只去查询 当前 主币下 代币的余额
        if (tokenEntry.protocol == logic.wallet.value.protocol &&
            tokenEntry.wallet_id == logic.wallet.value.id) {
          if (tokenEntry.contractAddress == null) {
            //这个是主币 所以 获取主币的余额
            final balance = await TokenService.getBalance(
              logic.wallet.value.address!,
              rpcUrl: rpcUrl,
            );
            WalletService.to.aaaAmount.value = num.parse(balance);
            newTokenEntry = tokenEntry.copyWith(balance: balance);
          } else {
            //这个是代币的 获取小数点
            final int decimals = await TokenService.getDecimals(
              tokenEntry.contractAddress!,
              rpcUrl: rpcUrl,
            );
            final balance = await TokenService.getTokenBalance(decimals,
                logic.wallet.value.address!, tokenEntry.contractAddress!,
                rpcUrl: rpcUrl);
            newTokenEntry =
                tokenEntry.copyWith(balance: balance, decimals: decimals);
          }
          newList.add(newTokenEntry);
        }
      }

      logic.tokenList.value = newList;
      logic.tokenList.refresh();

      refreshCtrl.refreshCompleted();
    }).catchError((error) {
      CoreKitToast.showError(error);
    }).whenComplete(cancelFunc);
  }

  @override
  void dispose() {
    //释放当前页面的监听事件
    worker.dispose();
    super.dispose();
  }
}
