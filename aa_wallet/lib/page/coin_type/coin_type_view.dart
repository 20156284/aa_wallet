import 'package:aa_wallet/core/utils/core_utils.dart';
import 'package:aa_wallet/core/widget/core_kit_style.dart';
import 'package:aa_wallet/entity/token/coin_key_entity.dart';
import 'package:aa_wallet/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'coin_type_logic.dart';

class CoinTypePage extends GetView<CoinTypeLogic> {
  const CoinTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().add_coin_type_title),
        backgroundColor: Colors.white,
        border: Border.all(width: 0.0, style: BorderStyle.none),
      ),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final coinKeyEntity = controller.coinKeyList[index];
          return _buildCell(coinKeyEntity);
        },
        itemCount: controller.coinKeyList.length,
      ),
    );
  }

  Widget _buildCell(CoinKeyEntity coinKeyEntity) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (CoreUtil.isNotEmptyString(coinKeyEntity.imageUrl))
            CoreKitStyle.image(coinKeyEntity.imageUrl!, size: 40),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                coinKeyEntity.coinKey ?? '',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                coinKeyEntity.protocol ?? '',
                style: const TextStyle(
                    fontSize: 12, color: CupertinoColors.inactiveGray),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
