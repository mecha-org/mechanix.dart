import 'package:flutter/material.dart';

class TouchOptimizedSplashFactory extends InteractiveInkFeatureFactory {
  const TouchOptimizedSplashFactory();

  @override
  InteractiveInkFeature create({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Offset position,
    required Color color,
    required TextDirection textDirection,
    bool containedInkWell = false,
    RectCallback? rectCallback,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    double? radius,
    VoidCallback? onRemoved,
  }) {
    return _TouchOptimizedSplash(
      controller: controller,
      referenceBox: referenceBox,
      color: color,
      position: position,
      borderRadius: borderRadius,
      customBorder: customBorder,
      rectCallback: rectCallback,
      containedInkWell: containedInkWell,
      onRemoved: onRemoved,
    );
  }
}

class _TouchOptimizedSplash extends InteractiveInkFeature {
  _TouchOptimizedSplash({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Color color,
    required this.position,
    this.borderRadius,
    this.customBorder,
    this.rectCallback,
    this.containedInkWell = false,
    VoidCallback? onRemoved,
  }) : super(
          controller: controller,
          referenceBox: referenceBox,
          color: color,
          onRemoved: onRemoved,
        ) {
    // Immediately mark for painting - critical for touch responsiveness
    controller.addInkFeature(this);
    controller.markNeedsPaint();

    // Use TickerMode to ensure animation starts immediately
    _fadeController = AnimationController(
      duration: Duration.zero, // Instant appearance
      vsync: controller.vsync,
      value: 1.0, // Start at full opacity immediately
    )..addListener(() {
        controller.markNeedsPaint();
      });
  }

  final Offset position;
  final BorderRadius? borderRadius;
  final ShapeBorder? customBorder;
  final RectCallback? rectCallback;
  final bool containedInkWell;

  late AnimationController _fadeController;
  bool _fadeOutStarted = false;

  @override
  void confirm() {
    _startFadeOut();
  }

  @override
  void cancel() {
    _startFadeOut();
  }

  void _startFadeOut() {
    if (_fadeOutStarted) return;
    _fadeOutStarted = true;

    _fadeController.duration = const Duration(milliseconds: 200);
    _fadeController.reverse().then((_) {
      dispose();
    });
  }

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {
    final double alpha = _fadeController.value;

    if (alpha == 0.0) return;

    final Paint paint = Paint()
      ..color = color.withOpacity(color.opacity * alpha);

    final Offset? originOffset = MatrixUtils.getAsTranslation(transform);

    Rect rect;
    if (rectCallback != null) {
      rect = rectCallback!();
    } else {
      rect = Offset.zero & referenceBox.size;
    }

    canvas.save();

    if (originOffset != null) {
      canvas.translate(originOffset.dx, originOffset.dy);
    } else {
      canvas.transform(transform.storage);
    }

    if (customBorder != null) {
      canvas.clipPath(
        customBorder!.getOuterPath(rect, textDirection: TextDirection.ltr),
      );
    } else if (borderRadius != null) {
      final RRect rrect = RRect.fromRectAndCorners(
        rect,
        topLeft: borderRadius!.topLeft,
        topRight: borderRadius!.topRight,
        bottomLeft: borderRadius!.bottomLeft,
        bottomRight: borderRadius!.bottomRight,
      );
      canvas.clipRRect(rrect);
    } else if (containedInkWell) {
      canvas.clipRect(rect);
    }

    canvas.drawRect(rect, paint);
    canvas.restore();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }
}
