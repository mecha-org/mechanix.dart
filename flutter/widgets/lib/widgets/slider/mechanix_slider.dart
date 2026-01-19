import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/slider/mechanix_slider_theme.dart';

class MechanixSlider extends StatefulWidget {
  final double initialValue;
  final bool showBars;
  final bool isDotSlider;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeEnd;
  final IconWidget? leftIcon;
  final MechanixSliderThemeData? theme;

  const MechanixSlider.dot({
    super.key,
    this.initialValue = 0.4,
    this.onChanged,
    this.onChangeEnd,
    this.showBars = true,
    this.isDotSlider = true,
    this.leftIcon,
    this.theme,
  }) : assert(initialValue >= 0.0 && initialValue <= 1.0,
            'Initial value must be between 0.0 and 1.0');

  const MechanixSlider.bar({
    super.key,
    this.initialValue = 0.4,
    this.onChanged,
    this.onChangeEnd,
    this.showBars = true,
    this.isDotSlider = false,
    this.leftIcon,
    this.theme,
  }) : assert(initialValue >= 0.0 && initialValue <= 1.0,
            'Initial value must be between 0.0 and 1.0');

  @override
  State<MechanixSlider> createState() => _MechanixSliderState();
}

class _MechanixSliderState extends State<MechanixSlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  // Add this method to handle prop changes
  @override
  void didUpdateWidget(MechanixSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update internal value when initialValue prop changes
    if (widget.initialValue != oldWidget.initialValue) {
      _currentValue = widget.initialValue;
    }
  }

  void _updateValue(double localPositionX, double containerWidth) {
    final newValue = (localPositionX / containerWidth).clamp(0.0, 1.0);

    setState(() {
      _currentValue = newValue;
    });

    widget.onChanged?.call(newValue);
  }

  void _handleDragUpdate(
      {required DragUpdateDetails details,
      required double containerWidth,
      required MechanixSliderThemeData theme}) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(details.globalPosition);

    // Adjust for left padding and icon width if present
    final leftOffset = 16.0 +
        (widget.leftIcon != null
            ? theme.iconLeftPadding + theme.iconRightPadding + theme.boxWidth
            : 0.0);

    _updateValue(localPosition.dx - leftOffset, containerWidth);
  }

  void _handleDragEnd(DragEndDetails details) {
    widget.onChangeEnd?.call(_currentValue);
  }

  void _handleTapDown({
    required TapDownDetails details,
    required double containerWidth,
    required MechanixSliderThemeData theme,
  }) {
    // Adjust for left padding and icon width if present
    final leftOffset = 16.0 +
        (widget.leftIcon != null
            ? theme.iconLeftPadding + theme.iconRightPadding + theme.boxWidth
            : 0.0);

    _updateValue(details.localPosition.dx - leftOffset, containerWidth);
    widget.onChangeEnd?.call(_currentValue);
  }

  // DOT PATTERN SLIDER - Activates whole columns
  Widget _buildDotPatternSlider({
    required double containerWidth,
    required MechanixSliderThemeData theme,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: theme.widgetRadius,
      ),
      child: _buildDotColumns(containerWidth: containerWidth, theme: theme),
    );
  }

  Widget _buildDotColumns({
    required double containerWidth,
    required MechanixSliderThemeData theme,
  }) {
    if (!widget.showBars) return const SizedBox.shrink();

    const double dotRadius = 1.5;
    const double dotSpacing = 6.0;
    const int rows = 8;

    final dotDiameter = dotRadius * 2;
    final columns =
        ((containerWidth - dotSpacing) / (dotDiameter + dotSpacing)).floor();

    // Calculate active columns based on current value
    final activeColumns = (_currentValue * columns).round();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(columns, (colIndex) {
        final isActiveColumn = colIndex < activeColumns;

        return Padding(
          padding:
              EdgeInsets.only(right: colIndex < columns - 1 ? dotSpacing : 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(rows, (rowIndex) {
              return Container(
                width: dotDiameter,
                height: dotDiameter,
                margin: EdgeInsets.only(
                    bottom: rowIndex < rows - 1 ? dotSpacing : 0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      isActiveColumn ? theme.activeColor : theme.inactiveColor,
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  // BAR SLIDER
  Widget _buildBarSlider({
    required double containerWidth,
    required MechanixSliderThemeData theme,
  }) {
    if (!widget.showBars) return const SizedBox.shrink();

    const double barWidth = 2.0;
    const double barSpacing = 5.0;

    final totalBars = ((containerWidth) / (barWidth + barSpacing)).floor();
    final activeBars = (_currentValue * totalBars).round();

    return Container(
      decoration: BoxDecoration(
        borderRadius: theme.widgetRadius,
      ),
      child: Wrap(
        spacing: barSpacing,
        children: List.generate(totalBars, (index) {
          final isActive = index < activeBars;
          return Container(
            width: barWidth,
            height: theme.barHeight,
            decoration: BoxDecoration(
              color: isActive ? theme.activeColor : theme.inactiveColor,
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSliderWithIcon({
    required double availableWidth,
    required MechanixSliderThemeData theme,
  }) {
    final iconOffset = widget.leftIcon != null
        ? theme.iconLeftPadding + theme.iconRightPadding + theme.boxWidth
        : 0.0;
    final sliderWidth = availableWidth - iconOffset;

    return Row(
      children: [
        // Left Icon
        if (widget.leftIcon != null)
          Padding(
            padding: EdgeInsets.only(
                left: theme.iconLeftPadding, right: theme.iconRightPadding),
            child: widget.leftIcon,
          ),

        // Slider
        Expanded(
          child: widget.isDotSlider
              ? _buildDotPatternSlider(
                  containerWidth: sliderWidth, theme: theme)
              : _buildBarSlider(containerWidth: sliderWidth, theme: theme),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = MechanixSliderTheme.of(context).merge(context, widget.theme);

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth - 24.0;

        return GestureDetector(
          onPanUpdate: (details) {
            final iconOffset = widget.leftIcon != null
                ? theme.iconLeftPadding +
                    theme.iconRightPadding +
                    theme.boxWidth
                : 0.0;
            final sliderWidth = availableWidth - iconOffset;
            _handleDragUpdate(
                details: details, containerWidth: sliderWidth, theme: theme);
          },
          onPanEnd: _handleDragEnd,
          onTapDown: (details) {
            final iconOffset = widget.leftIcon != null
                ? theme.iconLeftPadding +
                    theme.iconRightPadding +
                    theme.boxWidth
                : 0.0;
            final sliderWidth = availableWidth - iconOffset;
            _handleTapDown(
                details: details, containerWidth: sliderWidth, theme: theme);
          },
          child: Container(
            height: theme.widgetHeight,
            decoration: BoxDecoration(
              color: context.colorScheme.secondary,
              borderRadius: theme.widgetRadius,
            ),
            padding:
                const EdgeInsets.only(left: 16, top: 11, right: 8, bottom: 11),
            child: _buildSliderWithIcon(
                availableWidth: availableWidth, theme: theme),
          ),
        );
      },
    );
  }
}
