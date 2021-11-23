// ===============================================
// loading
//
// Create by Will on 2020/10/5 6:06 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../toast.dart';

/// 提示加载的Widget
class LoadingWidget extends StatelessWidget {
  const LoadingWidget(
    this._text, {
    Key? key,
    this.textListenable,
  }) : super(key: key);

  final String _text;
  final ValueListenable<String?>? textListenable;

  @override
  Widget build(BuildContext context) {
    return CoreKitToastContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
            strokeWidth: 2.0,
          ),
          if (_text != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                _text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          if (textListenable != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ValueListenableBuilder<String?>(
                valueListenable: textListenable!,
                builder: (context, value, child) {
                  if (value == null) {
                    return const SizedBox.shrink();
                  }

                  return Text(value);
                },
              ),
            ),
        ],
      ),
    );
  }
}
