import 'package:flutter/material.dart';

/// An [InteractiveInkFeatureFactory] that creates a flat bounding-box
/// touch highlight with an instant 0ms attack and a fixed 150ms fade-out upon release.
///
/// Unlike standard Material ink ripples, this does not paint an expanding radial wave;
/// instead it fills the entire button/ink bounds immediately with the specified touch/splash color,
/// guaranteeing visible tactile feedback even on ultra-fast taps and within scrollables.
///
/// **Performance & Rendering Architecture**:
/// - **Zero GPU clipping**: Directly draws shapes via `drawRRect`, `drawPath`, `drawCircle`, and `drawRect`
///   instead of stencil clipping (`clipRRect`/`clipPath`), avoiding off-screen stencil passes.
/// - **Geometry & Path Caching**: Caches evaluated [Path] and [RRect] across animation ticks, eliminating
///   redundant path re-tessellation and object allocations during the fade-out phase.
/// - **Zero heap allocation during paint**: Reuses a cached [Paint] object across all paint calls.
/// - **Matrix translation fast-path**: Shifts geometry coordinates directly instead of pushing expensive
///   `canvas.save()` / `canvas.restore()` state stack operations for translation transforms.
/// - **Overlap deduplication**: Automatically coalesces and cancels obsolete splashes on the same
///   reference box during rapid repeated taps, preventing opacity stacking and duplicate active tickers.
/// - **Degenerate rect safe**: Gracefully skips painting when reference bounds are unmeasured or collapsed.
/// - **RTL-aware**: Preserves ambient [TextDirection] for asymmetrical shape borders.
/// - **Safe lifecycle**: Status-driven teardown prevents double-dispose and unhandled ticker cancellations.
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
      textDirection: textDirection,
      radius: radius,
      onRemoved: onRemoved,
    );
  }
}

class _TouchOptimizedSplash extends InteractiveInkFeature {
  _TouchOptimizedSplash({
    required MaterialInkController controller,
    required super.referenceBox,
    required super.color,
    required this.position,
    this.borderRadius,
    super.customBorder,
    this.rectCallback,
    this.containedInkWell = false,
    required this.textDirection,
    this.radius,
    super.onRemoved,
  }) : super(controller: controller) {
    final _TouchOptimizedSplash? active = _activeSplashes[referenceBox];
    if (active != null && !active._disposed) {
      active.dispose();
    }
    _activeSplashes[referenceBox] = this;

    // Immediately register and mark for painting - critical for instant 0ms touch responsiveness
    controller.addInkFeature(this);
    controller.markNeedsPaint();

    _fadeController =
        AnimationController(
            duration: const Duration(milliseconds: 150),
            vsync: controller.vsync,
            value: 1.0, // Start at 1.0 opacity immediately (0ms attack)
          )
          ..addListener(controller.markNeedsPaint)
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              dispose();
            }
          });
  }

  static final Expando<_TouchOptimizedSplash> _activeSplashes =
      Expando<_TouchOptimizedSplash>();

  final Offset position;
  final BorderRadius? borderRadius;
  final RectCallback? rectCallback;
  final bool containedInkWell;
  final TextDirection textDirection;
  final double? radius;

  late final AnimationController _fadeController;
  final Paint _paint = Paint();
  bool _fadeOutStarted = false;
  bool _disposed = false;

  // Cached geometry across animation frames
  Rect? _lastBounds;
  Path? _cachedPath;
  RRect? _cachedRRect;

  @override
  void confirm() {
    _startFadeOut();
  }

  @override
  void cancel() {
    _startFadeOut();
  }

  void _startFadeOut() {
    if (_fadeOutStarted || _disposed) return;
    _fadeOutStarted = true;
    if (_fadeController.value <= 0.0) {
      dispose();
      return;
    }
    _fadeController.reverse();
  }

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {
    final double value = _fadeController.value;
    if (value <= 0.0 || color.a <= 0.0) return;

    if (rectCallback == null && !referenceBox.hasSize) return;

    final Rect rect = rectCallback != null
        ? rectCallback!()
        : (Offset.zero & referenceBox.size);

    if (rect.isEmpty) return;

    // Smooth perceptual ease-out fade curve
    final double alpha = Curves.easeOut.transform(value);
    _paint.color = color.withValues(alpha: color.a * alpha);

    final Offset? originOffset = MatrixUtils.getAsTranslation(transform);

    if (originOffset != null) {
      final Rect localRect = rect.shift(originOffset);
      _drawShape(canvas, localRect);
    } else {
      // Slow path: Complex matrix transform (scale / rotate / 3D skew)
      canvas.save();
      canvas.transform(transform.storage);
      _drawShape(canvas, rect);
      canvas.restore();
    }
  }

  /// Draws the flat shape directly without expensive GPU stencil clipping passes.
  /// Reuses cached Paths and RRects across all animation frames if bounds are unchanged.
  void _drawShape(Canvas canvas, Rect bounds) {
    if (customBorder != null) {
      if (_cachedPath == null || _lastBounds != bounds) {
        _lastBounds = bounds;
        _cachedPath = customBorder!.getOuterPath(
          bounds,
          textDirection: textDirection,
        );
      }
      canvas.drawPath(_cachedPath!, _paint);
    } else if (borderRadius != null && borderRadius != BorderRadius.zero) {
      if (_cachedRRect == null || _lastBounds != bounds) {
        _lastBounds = bounds;
        _cachedRRect = borderRadius!.toRRect(bounds);
      }
      canvas.drawRRect(_cachedRRect!, _paint);
    } else if (!containedInkWell && radius != null) {
      canvas.drawCircle(bounds.center, radius!, _paint);
    } else {
      canvas.drawRect(bounds, _paint);
    }
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    if (_activeSplashes[referenceBox] == this) {
      _activeSplashes[referenceBox] = null;
    }
    _cachedPath = null;
    _cachedRRect = null;
    _lastBounds = null;
    _fadeController.dispose();
    super.dispose();
  }
}
