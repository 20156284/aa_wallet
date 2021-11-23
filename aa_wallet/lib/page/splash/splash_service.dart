import 'dart:async';
import 'package:async/async.dart';
import 'package:get/get.dart';

class SplashService extends GetxService {
  final memo = AsyncMemoizer<void>();

  Future<void> init() {
    return memo.runOnce(_initFunction);
  }

  //此处可以做一个变换 之类的比如说 换图片呀 缩放动画呀 这些
  void _changeActive() {}

  Future<void> _initFunction() async {
    final t = Timer.periodic(
      const Duration(seconds: 3),
      (t) => _changeActive(),
    );
    //simulate some long running operation
    await Future.delayed(const Duration(seconds: 3));
    //cancel the timer once we are done
    t.cancel();
  }
}
