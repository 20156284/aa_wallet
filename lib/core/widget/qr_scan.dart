// ===============================================
// qr_scan
//
// Create by will on 2021/9/13 09:57
// Copyright @interstellar.All rights reserved.
// ===============================================

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CoreQRScan {
  const CoreQRScan();
  static Future<String?> pushScan({
    required BuildContext context,
    //边框颜色
    Color borderColor = const Color(0xFFFF0000),
    //边框圆角
    double borderRadius = 10,
    //边框大小
    double borderLength = 30,
    //边框宽度
    double borderWidth = 10,
    //扫描区域大小
    double cutOutSize = 200,
    //扫描区虚幻的颜色
    Color overlayColor = const Color.fromRGBO(0, 0, 0, 80),
  }) async {
    final String? result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return QRScan(
          borderColor: borderColor,
          borderRadius: borderRadius,
          borderLength: borderLength,
          borderWidth: borderWidth,
          cutOutSize: cutOutSize,
          overlayColor: overlayColor,
        );
      }),
    );
    return result;
  }
}

class QRScan extends StatefulWidget {
  const QRScan({
    Key? key,
    this.borderColor,
    this.borderWidth,
    this.overlayColor,
    this.borderRadius,
    this.borderLength,
    this.cutOutSize,
  }) : super(key: key);

  //边框颜色
  final Color? borderColor;

  //边框宽度
  final double? borderWidth;

  //背景虚化颜色
  final Color? overlayColor;

  //边框圆角
  final double? borderRadius;

  //边框大小
  final double? borderLength;

  //扫描区域大小
  final double? cutOutSize;

  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'CoreQR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildQrView(),
          const SafeArea(
            child: CupertinoNavigationBarBackButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView() {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: widget.borderColor!,
          borderRadius: widget.borderRadius!,
          borderLength: widget.borderLength!,
          borderWidth: widget.borderWidth!,
          cutOutSize: widget.cutOutSize!),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    // setState(() {
    //   this.controller = controller;
    // });

    this.controller = controller;

    result = await controller.scannedDataStream.first;
    if (result != null) Navigator.of(context).pop(result!.code);
    // WidgetsBinding.instance!
    //     .addPostFrameCallback((_) => Navigator.of(context).pop(result!.code));
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
