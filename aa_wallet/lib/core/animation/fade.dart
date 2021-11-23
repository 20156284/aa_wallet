// ===============================================
// fade
//
// Create by will on 3/20/21 12:36 AM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:flutter/cupertino.dart';

class FadeAnimation extends StatefulWidget {
  const FadeAnimation({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key);

  final Widget child;
  final AnimationController controller;

  @override
  FadeAnimationState createState() => FadeAnimationState();
}

class FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  static final Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);

  late Animation<double> _animation;
  late Animation<double> _animationOpacity;

  @override
  void initState() {
    super.initState();

    _animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);
    _animationOpacity = tweenOpacity.animate(_animation);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationOpacity,
      child: widget.child,
    );
  }
}
