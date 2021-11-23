// ===============================================
// image_viewer
//
// Create by Will on 2020/10/27 3:39 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageViewer {
  ImageViewer();

  static ImageViewerPageRoute buildRoute(
    List<ImageProvider> imageProviders, {
    Object Function(int index)? heroTagGenerator,
    int initialIndex = 0,
  }) {
    return ImageViewerPageRoute(
      pageBuilder: (context, animation, secondaryAnimation) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.black,
          ),
          child: ExtendedImageSlidePage(
            child: ImageViewerPageView(
              imageProviders,
              heroTagGenerator: heroTagGenerator,
              initialIndex: initialIndex,
            ),
            slideAxis: SlideAxis.both,
            slideType: SlideType.onlyImage,
          ),
        );
      },
    );
  }
}

class ImageViewerPageRoute<T> extends PageRoute<T> {
  ImageViewerPageRoute({
    RouteSettings? settings,
    required this.pageBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = false,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
    bool fullscreenDialog = false,
  }) : super(settings: settings, fullscreenDialog: fullscreenDialog);

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  @override
  final bool maintainState;

  final RoutePageBuilder pageBuilder;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return pageBuilder(context, animation, secondaryAnimation);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}

class ImageViewerPageView extends StatelessWidget {
  const ImageViewerPageView(
    this._imageProviders, {
    Key? key,
    this.heroTagGenerator,
    this.initialIndex = 0,
  }) : super(key: key);

  final List<ImageProvider> _imageProviders;
  final Object Function(int index)? heroTagGenerator;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ExtendedImageGesturePageView.builder(
        scrollDirection: Axis.horizontal,
        controller: ExtendedPageController(
          initialPage: initialIndex,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ExtendedImage(
            image: _imageProviders[index],
            fit: BoxFit.contain,
            mode: ExtendedImageMode.gesture,
            initGestureConfigHandler: (state) => GestureConfig(
              cacheGesture: false,
              initialScale: 1.0,
              inPageView: true,
            ),
            enableSlideOutPage: true,
            heroBuilderForSlidingPage: (widget) {
              final heroTag = heroTagGenerator?.call(index);

              if (heroTag == null) {
                return widget;
              }

              return Hero(
                tag: heroTag,
                child: widget,
              );
            },
          );
        },
        itemCount: _imageProviders.length,
      ),
      onTap: () => Navigator.maybePop(context),
    );
  }
}
