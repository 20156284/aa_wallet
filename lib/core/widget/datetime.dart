// ===============================================
// datetime
//
// Create by Will on 2020/11/2 9:50 AM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:aa_wallet/core/logger.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class DateTimeText extends StatefulWidget {
  DateTimeText(
    DateTime datetime, {
    Key? key,
    this.textStyle = const TextStyle(
      color: Color(0xFFBEBEBE),
      fontSize: 10,
    ),
    this.textAlign,
    this.dateFormat,
    this.tipsTitle,
    this.canTouch = false,
    this.countDown,
    this.timeOut = 'is time out you can change this tips use timeOut ',
  })  : datetime = datetime.toLocal(),
        super(key: key);

  DateTime? datetime;
  final TextStyle? textStyle;
  final TextAlign? textAlign;

  //倒计时
  final int? countDown;

  //如果使用 默认走上面的 _formatSameDay 这些国际化时间格式
  final String? dateFormat;

  //比如短信倒计时
  final String? tipsTitle;

  // 超时的提示语
  final String? timeOut;

  //是否可点击 比如 商城抢单倒计时是不可点击 默认不可点击
  bool? canTouch;

  @override
  State<StatefulWidget> createState() {
    return DateTimeState();
  }
}

class DateTimeState extends State<DateTimeText>
    with SingleTickerProviderStateMixin {
  late final ValueNotifier<String?> _timeNotifier = ValueNotifier<String?>(null);
  late Ticker _ticker;
  bool begin = false;

  //开启倒数时间
  DateTime countDownDateNow = DateTime.now();

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_frameCallback)..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: _timeNotifier,
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            if (widget.canTouch!) {
              CoreKitLogger().d('DateTimeText touch');
              countDownDateNow = DateTime.now();
              countDownDateNow.add(Duration(seconds: widget.countDown!));
              begin = true;
              widget.canTouch = false;
            }
          },
          child: Text(
            value ?? widget.tipsTitle ?? '',
            style: widget.textStyle,
            textAlign: widget.textAlign,
          ),
        );
      },
    );
  }

  void _frameCallback(Duration elapsed) {
    if (widget.countDown == null) {
      final now = DateTime.now();
      final Duration duration = widget.datetime!.difference(now);
      if (duration.inSeconds < 0) {
        _timeNotifier.value = widget.timeOut;
      } else {
        _timeNotifier.value = formatDate(duration, format: widget.dateFormat!);
      }
    } else {
      if (begin) {
        //初始开启的时间
        final DateTime now = DateTime.now();
        final int seconds = now.difference(countDownDateNow).inSeconds;
        if (seconds < widget.countDown!) {
          _timeNotifier.value = '${widget.countDown! - seconds}S';
        } else {
          begin = false;
          widget.canTouch = true;
          _timeNotifier.value = widget.tipsTitle ?? '';
        }
      }
    }
  }

  String formatDate(Duration dateTime, {String? format}) {
    if (dateTime == null) return '';
    format = format ?? DateFormats.full;

    final int days = dateTime.inDays;
    int hours = dateTime.inHours;
    int minutes = dateTime.inMinutes;
    int seconds = dateTime.inSeconds;

    if (hours > 24) {
      hours = hours % 24;
    }
    if (minutes > 60) {
      minutes = minutes % 60;
    }
    if (seconds > 60) {
      seconds = seconds % 60;
    }

    format = _comFormat(days, format, 'd', 'dd');
    format = _comFormat(hours, format, 'H', 'HH');
    format = _comFormat(minutes, format, 'm', 'mm');
    format = _comFormat(seconds, format, 's', 'ss');

    return format;
  }

  String _comFormat(int value, String format, String single, String full) {
    if (format.contains(single)) {
      if (format.contains(full)) {
        format =
            format.replaceAll(full, value < 10 ? '0$value' : value.toString());
      } else {
        format = format.replaceAll(single, value.toString());
      }
    }
    return format;
  }
}
