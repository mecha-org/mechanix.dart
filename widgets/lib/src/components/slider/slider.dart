import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'slider_enums.dart';
import 'slider_size.dart';
import 'slider_theme.dart';

export 'slider_enums.dart';
export 'slider_size.dart';
export 'slider_theme.dart';

class MechanixSlider extends StatefulWidget {
  const MechanixSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions,
    this.size = MechanixSliderSize.medium,
    this.direction = Axis.horizontal,
    this.variant = MechanixSliderVariant.standard,
    this.showValueLabel = true,
    this.labelFormatter,
    this.focusNode,
    this.autofocus = false,
    this.theme,
  }) : assert(min <= max),
       assert(value >= min && value <= max),
       assert(divisions == null || divisions > 0);

  /// The currently selected value. Must be between [min] and [max].
  final double value;

  /// Called continuously while the user changes the value.
  ///
  /// If null, the slider is disabled.
  final ValueChanged<double>? onChanged;

  /// Called once when the user starts changing the value.
  final ValueChanged<double>? onChangeStart;

  /// Called once when the user is done changing the value.
  final ValueChanged<double>? onChangeEnd;

  /// The minimum selectable value.
  final double min;

  /// The maximum selectable value.
  final double max;

  /// The number of equal steps the range is split into.
  ///
  /// If null, the slider is continuous. Otherwise the value snaps to the
  /// nearest step and one tick is drawn per step.
  final int? divisions;

  /// The sizing token controlling bar and pointer heights.
  final MechanixSliderSize size;

  /// Whether the slider runs horizontally (filling from the start edge) or
  /// vertically (filling from the bottom).
  final Axis direction;

  /// The visual variant. Only [MechanixSliderVariant.standard] is supported.
  final MechanixSliderVariant variant;

  /// Whether to show the value next to the pointer while pressed or dragging.
  final bool showValueLabel;

  /// Formats the value shown in the label. Defaults to the rounded value.
  final String Function(double value)? labelFormatter;

  /// Optional FocusNode.
  final FocusNode? focusNode;

  /// Whether this slider should auto focus on init.
  final bool autofocus;

  /// Custom theme override for this slider instance.
  final SliderThemeDataConfig? theme;

  bool get isEnabled => onChanged != null;

  @override
  State<MechanixSlider> createState() => _MechanixSliderState();
}

class _MechanixSliderState extends State<MechanixSlider> {
  /// Fallback length used when the slider is laid out with unbounded constraints.
  static const double _defaultLength = 200.0;

  /// Space between the pointer and the value label.
  static const double _labelGap = 4.0;

  final _SliderPaintCache _paintCache = _SliderPaintCache();

  bool _isHovered = false;
  bool _isFocused = false;
  bool _isDragging = false;
  bool _isPressed = false;
  double? _lastEmittedValue;

  late double _range;
  late double _step;
  late double _pageStep;
  late SliderSizeConfig _sizeConfig;
  TextDirection _textDirection = TextDirection.ltr;
  Set<WidgetState>? _cachedStates;
  late SliderThemeDataConfig _ambientTheme;
  late SliderThemeDataConfig _themeConfig;

  late final ValueNotifier<double> _fractionNotifier;

  @override
  void initState() {
    super.initState();
    _updateDimensions();
    _fractionNotifier = ValueNotifier<double>(_calculateFraction(widget.value));
  }

  @override
  void dispose() {
    _fractionNotifier.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _textDirection = Directionality.of(context);
    _ambientTheme = MechanixSliderTheme.of(context);
    _themeConfig = _ambientTheme.merge(widget.theme);
  }

  void _updateDimensions() {
    _range = widget.max - widget.min;
    _step =
        widget.divisions != null ? _range / widget.divisions! : _range / 100;
    _pageStep = _range / 10 > _step ? _range / 10 : _step;
    _sizeConfig = SliderSizeConfig.of(widget.size);
  }

  double _calculateFraction(double value) =>
      _range == 0 ? 0.0 : ((value - widget.min) / _range).clamp(0.0, 1.0);

  String _format(double value) =>
      widget.labelFormatter?.call(value) ?? value.round().toString();

  double _snap(double value) {
    final clamped = value.clamp(widget.min, widget.max).toDouble();
    final divisions = widget.divisions;
    if (divisions == null || _range == 0) return clamped;
    final t = (clamped - widget.min) / _range;
    return widget.min + (t * divisions).round() / divisions * _range;
  }

  bool _isReversed(TextDirection textDirection) =>
      widget.direction == Axis.vertical || textDirection == TextDirection.rtl;

  RenderBox? _activeRenderBox;
  double? _cachedTrackLength;

  /// Converts a local position into a value, along the slider axis.
  ///
  /// The length is read from the laid out render box, so no [LayoutBuilder]
  /// is needed to know it during build.
  double _valueAt(Offset position) {
    final length = _cachedTrackLength ??
        () {
          final renderBox =
              _activeRenderBox ?? (context.findRenderObject() as RenderBox?);
          if (renderBox == null || !renderBox.hasSize) return null;
          return widget.direction == Axis.horizontal
              ? renderBox.size.width
              : renderBox.size.height;
        }();
    if (length == null) return widget.value;

    final isHorizontal = widget.direction == Axis.horizontal;
    final pointerWidth = _sizeConfig.pointerWidth;
    var main = isHorizontal ? position.dx : position.dy;
    if (_isReversed(_textDirection)) main = length - main;
    final track = length - pointerWidth;
    final t = track <= 0
        ? 0.0
        : ((main - pointerWidth / 2) / track).clamp(0.0, 1.0);
    return _snap(widget.min + t * _range);
  }

  void _emit(double value) {
    final newFraction = _calculateFraction(value);
    if (_fractionNotifier.value != newFraction) {
      _fractionNotifier.value = newFraction;
    }
    if (value == _lastEmittedValue) return;
    _lastEmittedValue = value;
    if (value != widget.value) widget.onChanged?.call(value);
  }

  /// Applies a one-shot change (tap, keyboard, accessibility action).
  void _commit(double value) {
    if (!widget.isEnabled) return;
    widget.onChangeStart?.call(widget.value);
    _emit(value);
    widget.onChangeEnd?.call(value);
  }

  void _setPressed(bool value) {
    if (_isPressed != value) {
      _cachedStates = null;
      setState(() => _isPressed = value);
    }
  }

  void _setHovered(bool value) {
    if (_isHovered != value) {
      _cachedStates = null;
      setState(() => _isHovered = value);
    }
  }

  void _handleTapUp(TapUpDetails details) =>
      _commit(_valueAt(details.localPosition));

  void _handleDragStart(DragStartDetails details) {
    _cachedStates = null;
    _activeRenderBox = context.findRenderObject() as RenderBox?;
    if (_activeRenderBox != null && _activeRenderBox!.hasSize) {
      _cachedTrackLength = widget.direction == Axis.horizontal
          ? _activeRenderBox!.size.width
          : _activeRenderBox!.size.height;
    }
    setState(() => _isDragging = true);
    widget.onChangeStart?.call(widget.value);
    _emit(_valueAt(details.localPosition));
  }

  void _handleDragUpdate(DragUpdateDetails details) =>
      _emit(_valueAt(details.localPosition));

  void _handleDragEnd([DragEndDetails? _]) {
    _activeRenderBox = null;
    _cachedTrackLength = null;
    if (!_isDragging) return;
    _cachedStates = null;
    setState(() => _isDragging = false);
    widget.onChangeEnd?.call(_lastEmittedValue ?? widget.value);
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (!widget.isEnabled || event is KeyUpEvent) {
      return KeyEventResult.ignored;
    }
    final rtl = _textDirection == TextDirection.rtl;
    final key = event.logicalKey;

    double? target;
    if (key == LogicalKeyboardKey.arrowUp) {
      target = widget.value + _step;
    } else if (key == LogicalKeyboardKey.arrowDown) {
      target = widget.value - _step;
    } else if (key == LogicalKeyboardKey.arrowRight) {
      target = widget.value + (rtl ? -_step : _step);
    } else if (key == LogicalKeyboardKey.arrowLeft) {
      target = widget.value + (rtl ? _step : -_step);
    } else if (key == LogicalKeyboardKey.pageUp) {
      target = widget.value + _pageStep;
    } else if (key == LogicalKeyboardKey.pageDown) {
      target = widget.value - _pageStep;
    } else if (key == LogicalKeyboardKey.home) {
      target = widget.min;
    } else if (key == LogicalKeyboardKey.end) {
      target = widget.max;
    }

    if (target == null) return KeyEventResult.ignored;
    _commit(_snap(target));
    return KeyEventResult.handled;
  }

  Set<WidgetState> get _states =>
      _cachedStates ??= {
        if (!widget.isEnabled) WidgetState.disabled,
        if (_isHovered) WidgetState.hovered,
        if (_isFocused) WidgetState.focused,
        if (_isPressed) WidgetState.pressed,
        if (_isDragging) WidgetState.dragged,
      };

  @override
  void didUpdateWidget(MechanixSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.min != widget.min ||
        oldWidget.max != widget.max ||
        oldWidget.divisions != widget.divisions ||
        oldWidget.size != widget.size) {
      _updateDimensions();
    }
    if (oldWidget.value != widget.value ||
        oldWidget.min != widget.min ||
        oldWidget.max != widget.max) {
      final newFraction = _calculateFraction(widget.value);
      if (_fractionNotifier.value != newFraction) {
        _fractionNotifier.value = newFraction;
      }
    }
    if (oldWidget.theme != widget.theme) {
      _themeConfig = _ambientTheme.merge(widget.theme);
    }
    if (oldWidget.isEnabled != widget.isEnabled) {
      _cachedStates = null;
    }
    if (!widget.isEnabled) {
      _isDragging = false;
      _isPressed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.variant != MechanixSliderVariant.standard) {
      throw UnimplementedError(
        'MechanixSlider variant ${widget.variant.name} is not implemented yet.',
      );
    }

    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
    final textDirection = _textDirection;
    final sizeConfig = _sizeConfig;
    final themeConfig = _themeConfig;
    final states = _states;
    final isHorizontal = widget.direction == Axis.horizontal;
    final isEnabled = widget.isEnabled;
    final dragsHorizontally = isEnabled && isHorizontal;
    final dragsVertically = isEnabled && !isHorizontal;

    final activeTickColor =
        themeConfig.activeTickColor?.resolve(states) ??
        (isEnabled
            ? colorScheme.onSecondaryFixed
            : colorScheme.onSecondaryFixed.withValues(alpha: 0.16));
    final inactiveTickColor =
        themeConfig.inactiveTickColor?.resolve(states) ??
        colorScheme.secondaryFixedDim;
    final pointerColor =
        themeConfig.pointerColor?.resolve(states) ??
        (isEnabled
            ? colorScheme.onSecondary
            : colorScheme.onSecondary.withValues(alpha: 0.32));
    final labelStyle =
        themeConfig.valueLabelStyle ??
        themeData.textTheme.labelLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
        );

    final t = _range == 0
        ? 0.0
        : ((widget.value - widget.min) / _range).clamp(0.0, 1.0);

    final valueText = _format(widget.value);
    final isActive = _isPressed || _isDragging;

    return Semantics(
      slider: true,
      enabled: isEnabled,
      focusable: isEnabled,
      focused: _isFocused,
      value: valueText,
      increasedValue: _format(_snap(widget.value + _step)),
      decreasedValue: _format(_snap(widget.value - _step)),
      textDirection: textDirection,
      onIncrease: isEnabled ? () => _commit(_snap(widget.value + _step)) : null,
      onDecrease: isEnabled ? () => _commit(_snap(widget.value - _step)) : null,
      child: Focus(
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        canRequestFocus: isEnabled,
        onKeyEvent: _handleKeyEvent,
        onFocusChange: (focused) => setState(() => _isFocused = focused),
        child: MouseRegion(
          cursor: isEnabled ? SystemMouseCursors.click : MouseCursor.defer,
          onEnter: (_) => _setHovered(true),
          onExit: (_) => _setHovered(false),
          // A raw Listener reacts to the press immediately; the tap
          // recognizer only fires after the gesture arena resolves.
          child: Listener(
            onPointerDown: isEnabled ? (_) => _setPressed(true) : null,
            onPointerUp: (_) => _setPressed(false),
            onPointerCancel: (_) => _setPressed(false),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              excludeFromSemantics: true,
              onTapUp: isEnabled ? _handleTapUp : null,
              onHorizontalDragStart: dragsHorizontally
                  ? _handleDragStart
                  : null,
              onHorizontalDragUpdate: dragsHorizontally
                  ? _handleDragUpdate
                  : null,
              onHorizontalDragEnd: dragsHorizontally ? _handleDragEnd : null,
              onHorizontalDragCancel: dragsHorizontally ? _handleDragEnd : null,
              onVerticalDragStart: dragsVertically ? _handleDragStart : null,
              onVerticalDragUpdate: dragsVertically ? _handleDragUpdate : null,
              onVerticalDragEnd: dragsVertically ? _handleDragEnd : null,
              onVerticalDragCancel: dragsVertically ? _handleDragEnd : null,
              child: LimitedBox(
                maxWidth: _defaultLength,
                maxHeight: _defaultLength,
                child: SizedBox(
                  width: isHorizontal
                      ? double.infinity
                      : sizeConfig.pointerHeight,
                  height: isHorizontal
                      ? sizeConfig.pointerHeight
                      : double.infinity,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final length = isHorizontal
                          ? constraints.maxWidth
                          : constraints.maxHeight;
                      final pointerWidth = sizeConfig.pointerWidth;
                      final reversed = _isReversed(textDirection);

                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned.fill(
                            // Dragging repaints every frame; keep that from dirtying
                            // the ancestors' layers.
                            child: RepaintBoundary(
                              child: CustomPaint(
                                painter: _SliderPainter(
                                  cache: _paintCache,
                                  fraction: t,
                                  fractionListenable: _fractionNotifier,
                                  divisions: widget.divisions,
                                  direction: widget.direction,
                                  reversed: reversed,
                                  sizeConfig: sizeConfig,
                                  activeTickColor: activeTickColor,
                                  inactiveTickColor: inactiveTickColor,
                                  pointerColor: pointerColor,
                                  showPointer: isActive,
                                ),
                              ),
                            ),
                          ),
                          if (widget.showValueLabel && isActive)
                            ValueListenableBuilder<double>(
                              valueListenable: _fractionNotifier,
                              builder: (context, fraction, _) {
                                final pointerCenter = pointerWidth / 2 +
                                    fraction * (length - pointerWidth);
                                final along = reversed
                                    ? length - pointerCenter
                                    : pointerCenter;
                                final val = widget.min + fraction * _range;
                                return _buildValueLabel(
                                  along: along,
                                  sizeConfig: sizeConfig,
                                  labelStyle: labelStyle,
                                  textDirection: textDirection,
                                  valueText: _format(val),
                                  isHorizontal: isHorizontal,
                                );
                              },
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildValueLabel({
    required double along,
    required SliderSizeConfig sizeConfig,
    required TextStyle? labelStyle,
    required TextDirection textDirection,
    required String valueText,
    required bool isHorizontal,
  }) {
    final textWidget = IgnorePointer(
      child: Text(
        valueText,
        style: labelStyle,
        textDirection: textDirection,
      ),
    );

    if (isHorizontal) {
      return Positioned(
        left: along,
        bottom: sizeConfig.pointerHeight + _labelGap,
        child: FractionalTranslation(
          translation: const Offset(-0.5, 0.0),
          child: textWidget,
        ),
      );
    }

    final isRtl = textDirection == TextDirection.rtl;
    return Positioned(
      left: isRtl ? sizeConfig.pointerHeight + _labelGap : null,
      right: isRtl ? null : sizeConfig.pointerHeight + _labelGap,
      top: along,
      child: FractionalTranslation(
        translation: const Offset(0.0, -0.5),
        child: textWidget,
      ),
    );
  }
}

/// Paint resources that outlive a single [_SliderPainter], so a drag frame
/// only slices cached data instead of rebuilding tick geometry, paints or
/// re-laying out the label text.
class _SliderPaintCache {
  final Paint activePaint = Paint();
  final Paint inactivePaint = Paint();
  final Paint pointerPaint = Paint();

  /// Tick centers along the main axis, measured from the start of the fill,
  /// in ascending order.
  Float64List tickCenters = Float64List(0);

  /// One line segment (x0, y0, x1, y1) per tick, across the slider axis, in
  /// the same order as [tickCenters].
  Float32List tickLines = Float32List(0);

  Size? _size;
  int? _divisions;
  Axis? _direction;
  bool? _reversed;
  SliderSizeConfig? _sizeConfig;

  /// Recomputes the tick geometry only when an input it depends on changed.
  void updateTicks({
    required Size size,
    required int? divisions,
    required Axis direction,
    required bool reversed,
    required SliderSizeConfig sizeConfig,
  }) {
    if (size == _size &&
        divisions == _divisions &&
        direction == _direction &&
        reversed == _reversed &&
        sizeConfig == _sizeConfig) {
      return;
    }
    _size = size;
    _divisions = divisions;
    _direction = direction;
    _reversed = reversed;
    _sizeConfig = sizeConfig;

    final isHorizontal = direction == Axis.horizontal;
    final length = isHorizontal ? size.width : size.height;
    final crossCenter = (isHorizontal ? size.height : size.width) / 2;
    final halfBar = sizeConfig.barHeight / 2;

    final centers = _computeTickCenters(length, divisions, sizeConfig);
    final lines = Float32List(centers.length * 4);
    for (var i = 0; i < centers.length; i++) {
      final along = reversed ? length - centers[i] : centers[i];
      final j = i * 4;
      if (isHorizontal) {
        lines[j] = along;
        lines[j + 1] = crossCenter - halfBar;
        lines[j + 2] = along;
        lines[j + 3] = crossCenter + halfBar;
      } else {
        lines[j] = crossCenter - halfBar;
        lines[j + 1] = along;
        lines[j + 2] = crossCenter + halfBar;
        lines[j + 3] = along;
      }
    }
    tickCenters = centers;
    tickLines = lines;
  }

  static Float64List _computeTickCenters(
    double length,
    int? divisions,
    SliderSizeConfig sizeConfig,
  ) {
    if (divisions != null) {
      final track = length - sizeConfig.pointerWidth;
      final centers = Float64List(divisions + 1);
      for (var i = 0; i <= divisions; i++) {
        centers[i] = sizeConfig.pointerWidth / 2 + track * i / divisions;
      }
      return centers;
    }
    final tickWidth = sizeConfig.tickWidth;
    final pitch = tickWidth + sizeConfig.tickGap;
    final count = ((length + sizeConfig.tickGap) / pitch).floor();
    if (count < 2) return Float64List(1)..[0] = length / 2;
    final spacing = (length - tickWidth) / (count - 1);
    final centers = Float64List(count);
    for (var i = 0; i < count; i++) {
      centers[i] = tickWidth / 2 + spacing * i;
    }
    return centers;
  }
}

/// Paints the tick bar and, while active, the value pointer.
///
/// Positions are computed along the "main" axis measured from the start of
/// the fill (the minimum value), then mapped onto the canvas.
class _SliderPainter extends CustomPainter {
  _SliderPainter({
    required this.cache,
    required this.fraction,
    this.fractionListenable,
    required this.divisions,
    required this.direction,
    required this.reversed,
    required this.sizeConfig,
    required this.activeTickColor,
    required this.inactiveTickColor,
    required this.pointerColor,
    required this.showPointer,
  }) : super(repaint: fractionListenable);

  final _SliderPaintCache cache;
  final double fraction;
  final ValueListenable<double>? fractionListenable;
  final int? divisions;
  final Axis direction;
  final bool reversed;
  final SliderSizeConfig sizeConfig;
  final Color activeTickColor;
  final Color inactiveTickColor;
  final Color pointerColor;
  final bool showPointer;

  double get currentFraction => fractionListenable?.value ?? fraction;

  bool get _isHorizontal => direction == Axis.horizontal;

  /// A rect centered at [main] along the axis, spanning [thickness] along it
  /// and [extent] across it.
  Rect _rect(Size size, double main, double thickness, double extent) {
    final length = _isHorizontal ? size.width : size.height;
    final along = reversed ? length - main : main;
    final crossCenter = (_isHorizontal ? size.height : size.width) / 2;
    return _isHorizontal
        ? Rect.fromCenter(
            center: Offset(along, crossCenter),
            width: thickness,
            height: extent,
          )
        : Rect.fromCenter(
            center: Offset(crossCenter, along),
            width: extent,
            height: thickness,
          );
  }

  /// Index of the first entry in the ascending [values] that is greater than
  /// [bound], or greater than or equal to it when [inclusive].
  static int _firstIndex(Float64List values, double bound, bool inclusive) {
    var low = 0;
    var high = values.length;
    while (low < high) {
      final mid = (low + high) >> 1;
      final v = values[mid];
      if (inclusive ? v < bound : v <= bound) {
        low = mid + 1;
      } else {
        high = mid;
      }
    }
    return low;
  }

  void _drawTicks(Canvas canvas, int start, int end, Paint paint) {
    if (end <= start) return;
    final lines = (start == 0 && end == cache.tickCenters.length)
        ? cache.tickLines
        : Float32List.sublistView(cache.tickLines, start * 4, end * 4);
    canvas.drawRawPoints(
      ui.PointMode.lines,
      lines,
      paint,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    cache.updateTicks(
      size: size,
      divisions: divisions,
      direction: direction,
      reversed: reversed,
      sizeConfig: sizeConfig,
    );

    final length = _isHorizontal ? size.width : size.height;
    final pointerWidth = sizeConfig.pointerWidth;
    final pointerCenter =
        pointerWidth / 2 + currentFraction * (length - pointerWidth);
    final clearance = pointerWidth / 2 + sizeConfig.tickGap;

    final centers = cache.tickCenters;
    final activeEnd = showPointer
        ? _firstIndex(centers, pointerCenter - clearance, false)
        : currentFraction == 0
        ? 0
        : _firstIndex(centers, pointerCenter + 1e-6, false);
    final inactiveStart = showPointer
        ? _firstIndex(centers, pointerCenter + clearance, true)
        : activeEnd;

    final tickWidth = sizeConfig.tickWidth;
    _drawTicks(
      canvas,
      0,
      activeEnd,
      cache.activePaint
        ..color = activeTickColor
        ..strokeWidth = tickWidth,
    );
    _drawTicks(
      canvas,
      inactiveStart,
      centers.length,
      cache.inactivePaint
        ..color = inactiveTickColor
        ..strokeWidth = tickWidth,
    );

    if (!showPointer) return;
    final pointerRect = _rect(
      size,
      pointerCenter,
      pointerWidth,
      sizeConfig.pointerHeight,
    );
    canvas.drawRect(pointerRect, cache.pointerPaint..color = pointerColor);
  }

  @override
  bool shouldRepaint(_SliderPainter oldDelegate) {
    return currentFraction != oldDelegate.currentFraction ||
        fractionListenable != oldDelegate.fractionListenable ||
        showPointer != oldDelegate.showPointer ||
        activeTickColor != oldDelegate.activeTickColor ||
        inactiveTickColor != oldDelegate.inactiveTickColor ||
        pointerColor != oldDelegate.pointerColor ||
        divisions != oldDelegate.divisions ||
        direction != oldDelegate.direction ||
        reversed != oldDelegate.reversed ||
        sizeConfig != oldDelegate.sizeConfig;
  }
}
