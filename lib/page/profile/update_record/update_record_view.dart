import 'package:aa_wallet/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'update_record_logic.dart';

class UpdateRecordPage extends GetView<UpdateRecordLogic> {
  const UpdateRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS().profile_update_record),
        backgroundColor: Colors.white,
        border: Border.all(width: 0.0, style: BorderStyle.none),
      ),
      child: Container(),
    );
  }
}
