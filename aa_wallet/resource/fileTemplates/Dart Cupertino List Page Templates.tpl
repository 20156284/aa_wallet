// ===============================================
// ${NAME}
// 
// Create by ${USER} on ${DATE} ${TIME}
// Copyright @${PROJECT_NAME}.All rights reserved.
// ===============================================


import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:${PROJECT_NAME}/const/app_theme.dart';
import 'package:${PROJECT_NAME}/core/logger.dart';
import 'package:${PROJECT_NAME}/core/toast.dart';
import 'package:${PROJECT_NAME}/generated/l10n.dart';
import 'package:${PROJECT_NAME}/res.dart';

class ${CLASS_NAME}Page extends StatefulWidget {
  @override
  _${CLASS_NAME}PageState createState() => _${CLASS_NAME}PageState();
}

class _${CLASS_NAME}PageState extends State<${CLASS_NAME}Page> {
  //列表数组 承放 相对应的列表
  List<ExpResp> _expRespList = <ExpResp>[];

  //刷新控件
  RefreshController _refeshCtrl;

  //是否加载更多
  bool _canLoadMore = false;

  //偏移页码
  int _pageIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //开启自动刷新
    _refeshCtrl = RefreshController(initialRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppS() .me_page_comment),
        border: Border.all(width: 0.0, style: BorderStyle.none),
      ),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        controller: _refeshCtrl,
        onRefresh: () => _onRefreshFun(),
        onLoading: () => _onLoadingFun(),
        child: _build${CLASS_NAME}Items(),
      ),
    );
  }

  _onRefreshFun() {
  ExptApi.acquire().getExp(offsize: 1).then((value) {
    final hasData = value?.isNotEmpty == true;
    _refeshCtrl.refreshCompleted(resetFooterState: hasData);

    _canLoadMore = hasData;
     _pageIndex = 1;
     _expRespList.clear();
     if (hasData) {
       _expRespList.addAll(value);
     }
     if (mounted) setState(() {});
   }).catchError((error) {
     CoreKitToast.showError(error);
     CoreKitLogger().e('加载[getExp]出错了', error);
     _refeshCtrl.loadFailed();
   });
  }

  _onLoadingFun() {
   final nextPage = _pageIndex + 1;
   EXpApi.acquire().getExp(offsize: nextPage).then((value) {
     final hasData = value?.isNotEmpty == true;
     if (hasData) {
       _refeshCtrl.loadComplete();
       _canLoadMore = true;
       _pageIndex = nextPage;
       _expRespList.addAll(value);
       if (mounted) setState(() {});
     } else {
       _refeshCtrl.loadNoData();
       _canLoadMore = false;
       setState(() {});
     }
   }).catchError((error) {
     CoreKitLogger().e('加载[comment]出错了', error);
     _refeshCtrl.loadFailed();
   });
  }

  Widget _build${CLASS_NAME}Items() {
    final apps = AppS() ;
    if (_expRespList.isEmpty) {
      return Column(
        children: [
          SizedBox(
              height:
                  FlutterScreenutil.ScreenUtil().setHeight(64.0).toDouble()),
          ExtendedImage(
            image: ExtendedAssetImageProvider(Res.ic_splash),
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
              height:
                  FlutterScreenutil.ScreenUtil().setHeight(46.0).toDouble()),
          Text(
            'sorry you have not ${CLASS_NAME} 😸',
            style: const TextStyle(
              color: Color(0xFFADADAD),
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
    return ListView.builder(
      itemBuilder: (c, i) {
        //承放您要返回的列表 样式
          return Container();
      },
      // itemExtent: 100.0,
      itemCount: _expRespList.length,
    );
  }
}
