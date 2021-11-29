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
    final String? result = await Navigator.push(
      context,
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
          _buildQrView(context),
          const SafeArea(
            child: CupertinoNavigationBarBackButton(),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   body: Column(
    //     children: <Widget>[
    //       Expanded(flex: 4, child: _buildQrView(context)),
    //       Expanded(
    //         flex: 1,
    //         child: FittedBox(
    //           fit: BoxFit.contain,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: <Widget>[
    //               if (result != null)
    //                 Text(
    //                     'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
    //               else
    //                 Text('Scan a code'),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: <Widget>[
    //                   Container(
    //                     margin: EdgeInsets.all(8),
    //                     child: ElevatedButton(
    //                         onPressed: () async {
    //                           await controller?.toggleFlash();
    //                           setState(() {});
    //                         },
    //                         child: FutureBuilder(
    //                           future: controller?.getFlashStatus(),
    //                           builder: (context, snapshot) {
    //                             return Text('Flash: ${snapshot.data}');
    //                           },
    //                         )),
    //                   ),
    //                   Container(
    //                     margin: EdgeInsets.all(8),
    //                     child: ElevatedButton(
    //                         onPressed: () async {
    //                           await controller?.flipCamera();
    //                           setState(() {});
    //                         },
    //                         child: FutureBuilder(
    //                           future: controller?.getCameraInfo(),
    //                           builder: (context, snapshot) {
    //                             if (snapshot.data != null) {
    //                               return Text(
    //                                   'Camera facing ${describeEnum(snapshot.data!)}');
    //                             } else {
    //                               return Text('loading');
    //                             }
    //                           },
    //                         )),
    //                   )
    //                 ],
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: <Widget>[
    //                   Container(
    //                     margin: EdgeInsets.all(8),
    //                     child: ElevatedButton(
    //                       onPressed: () async {
    //                         await controller?.pauseCamera();
    //                       },
    //                       child: Text('pause', style: TextStyle(fontSize: 20)),
    //                     ),
    //                   ),
    //                   Container(
    //                     margin: EdgeInsets.all(8),
    //                     child: ElevatedButton(
    //                       onPressed: () async {
    //                         await controller?.resumeCamera();
    //                       },
    //                       child: Text('resume', style: TextStyle(fontSize: 20)),
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  Widget _buildQrView(BuildContext context) {
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
    setState(() {
      this.controller = controller;
    });
    //  controller.scannedDataStream.listen((scanData) {
    //   setState(() {
    //     debugPrint(scanData.code);
    //     result = scanData;
    //   });
    // });

    result = await controller.scannedDataStream.first;
    if (result != null)
      WidgetsBinding.instance!
          .addPostFrameCallback((_) => Navigator.of(context).pop(result!.code));

    // await for (var value in controller.scannedDataStream) {
    //   debugPrint(value.code);
    //   result= value;
    // }
    // debugPrint(result!.code);
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
