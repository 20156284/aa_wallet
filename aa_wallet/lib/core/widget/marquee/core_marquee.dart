import 'dart:async';
import 'package:flutter/material.dart';
import 'animation_direction.dart';
import 'marquee_item.dart';

class CoreMarquee extends StatefulWidget {

  CoreMarquee({
    Key? key,
    this.children,
    this.texts,
    Color? selectTextColor,
    Color? textColor,
    int? duration,
    int? itemDuration,
    bool? autoStart,
    AnimationDirection? animationDirection,
    this.animateDistance,
    bool? singleLine,
    ValueChanged<int>? onChange,
  })  : assert(children != null || texts != null),
        assert(onChange != null),
        duration = duration ?? 4,
        itemDuration = itemDuration ?? 500,
        autoStart = autoStart ?? true,
        singleLine = singleLine ?? true,
        textColor = textColor ?? Colors.black,
        selectTextColor = selectTextColor ?? Colors.black,
        animationDirection = animationDirection ?? AnimationDirection.b2t,
        super(key: key);

  /// 跑马灯的具体类容
  List<Widget>? children;

  ///  text 的具体内容
  List<String>? texts;

  /// 当前正在跑的文字的颜色
  /// 只在texts有值时生效
  Color selectTextColor;

  /// 正常的文字颜色
  /// 只在texts有值时生效
  Color textColor;

  /// 跑马灯的切换时长 默认是4秒
  int duration;

  /// 跑马灯的切换时长 默认是500毫秒
  int itemDuration;

  ///是否自动开始
  bool autoStart;

  ///动画显示的切换方式，默认是从上往下切换
  AnimationDirection animationDirection;

  ///移动的距离
  ///如果没有设置就是默认获取组件宽高，横向动画就是组建的宽度，纵向的就是组件的高度
  double? animateDistance;

  ///是否是单行显示
  bool singleLine;

  ///点击事件回调
  ValueChanged<int>? onChange;

  @override
  State<StatefulWidget> createState() {
    return _FlutterMarquee();
  }
}

class _FlutterMarquee extends State<CoreMarquee> {
  late Timer _timer; // 定时器timer
  int currentPage = 0;
  bool lastPage = false;
  List<CoreMarqueeItem> items = <CoreMarqueeItem>[];
  late CoreMarqueeItem firstItem = CoreMarqueeItem();
  late CoreMarqueeItem secondItem = CoreMarqueeItem();

  @override
  void initState() {
    super.initState();
    if (widget.texts != null) {
      for (var i = 0; i < widget.texts!.length; i++) {
        items.add(CoreMarqueeItem(
          child: Text(
            widget.texts![i],
            maxLines: 1,
            textAlign: TextAlign.left,
          ),
          // text: widget.texts[i],
          onPress: () {
            if (widget.onChange != null) {
              widget.onChange!(i);
            }
          },
          singleLine: widget.singleLine,
          animationDirection: widget.animationDirection,
          animateDistance: widget.animateDistance,
          itemDuration: widget.itemDuration,
        ));
      }
    } else {
      for (var i = 0; i < widget.children!.length; i++) {
        items.add(CoreMarqueeItem(
          child: widget.children![i],
          // text: widget.texts[i],
          onPress: () {
            if (widget.onChange != null) {
              widget.onChange!(i);
            }
          },
          singleLine: widget.singleLine,
          animationDirection: widget.animationDirection,
          animateDistance: widget.animateDistance,
          itemDuration: widget.itemDuration,
        ));
      }
    }

    firstItem = items[0];

    if (widget.autoStart) {
      _timer = Timer.periodic(Duration(seconds: widget.duration), (timer) {
        setState(() {
          currentPage++;
          if (currentPage >= items.length) {
            //last item
            currentPage = 0;
            firstItem = items[items.length - 1]..modeListener.value = true;
            secondItem = items[currentPage]..modeListener.value = false;
          } else if (currentPage <= 0) {
            // first item
            currentPage = items.length - 1;
            firstItem = items[0]..modeListener.value = true;
            secondItem = items[currentPage]..modeListener.value = false;
          } else {
            firstItem = items[currentPage - 1]..modeListener.value = true;
            secondItem = items[currentPage]..modeListener.value = false;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ///设置动画的宽度或者高度
    if (widget.animateDistance == null) {
      if (widget.animationDirection == AnimationDirection.l2r ||
          widget.animationDirection == AnimationDirection.l2r) {
        final double width = MediaQuery.of(context).size.width;
        firstItem.animateDistance = width;
        secondItem.animateDistance = width;
      } else {
        final double height = MediaQuery.of(context).size.height;
        firstItem.animateDistance = height;
        secondItem.animateDistance = height;
      }
    }
    final List<CoreMarqueeItem> items = secondItem == null
        ? <CoreMarqueeItem>[firstItem..textColor = widget.selectTextColor]
        : <CoreMarqueeItem>[
            secondItem..textColor = widget.selectTextColor,
            firstItem..textColor = widget.textColor
          ];

    return ClipRect(
        child: Center(
      child: Stack(
        children: items,
      ),
    ));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
