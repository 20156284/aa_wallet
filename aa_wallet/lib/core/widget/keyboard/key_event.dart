class KeyDownEvent {
  KeyDownEvent(this.key);

  ///  当前点击的按钮所代表的值
  String key;

  bool isClose() => key == 'close';
}
