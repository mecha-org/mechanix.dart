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

    // Adjust for icon width if present
    final iconOffset = widget.leftIcon != null
        ? theme.iconLeftPadding + theme.iconRightPadding + theme.boxWidth
        : 0.0;

    _updateValue(localPosition.dx - iconOffset, containerWidth);
  }

  void _handleDragEnd(DragEndDetails details) {
    widget.onChangeEnd?.call(_currentValue);
  }

  void _handleTapDown({
    required TapDownDetails details,
    required double containerWidth,
    required MechanixSliderThemeData theme,
  }) {
    // Adjust for icon width if present
    final iconOffset = widget.leftIcon != null
        ? theme.iconLeftPadding + theme.iconRightPadding + theme.boxWidth
        : 0.0;

    _updateValue(details.localPosition.dx - iconOffset, containerWidth);
    widget.onChangeEnd?.call(_currentValue);
  }

  // DOT PATTERN SLIDER
  Widget _buildDotPatternSlider({
    required double containerWidth,
    required MechanixSliderThemeData theme,
  }) {
    return SizedBox(
      height: theme.height,
      width: containerWidth,
      child: Stack(
        children: [
          // Background track
          Container(
            decoration: BoxDecoration(
              // color: theme.inactiveColor,
              borderRadius: theme.widgetRadius,
            ),
          ),

          // Dot pattern
          _buildDotPattern(containerWidth),

          // Active track
          Container(
            width: containerWidth * _currentValue,
            decoration: BoxDecoration(
              color: theme.activeColor,
              borderRadius: theme.widgetRadius,
            ),
          ),
        ],
      ).padVertical(6),
    );
  }

  Widget _buildDotPattern(double containerWidth) {
    const double dotRadius = 1.0;
    const double dotSpacing = 12.0;

    final dotDiameter = dotRadius * 2;
    final dotsPerRow =
        ((containerWidth - dotSpacing) / (dotDiameter + dotSpacing)).floor();
    final rows = 4;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: dotsPerRow,
        mainAxisSpacing: dotSpacing,
        crossAxisSpacing: dotSpacing,
        childAspectRatio: 1.0,
      ),
      itemCount: dotsPerRow * rows,
      itemBuilder: (context, index) {
        return Container(
          width: dotDiameter,
          height: dotDiameter,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF5A5A5A),
          ),
        );
      },
    );
  }

  // BAR SLIDER
  Widget _buildBarSlider(
      {required double containerWidth,
      required MechanixSliderThemeData theme}) {
    if (!widget.showBars) return const SizedBox.shrink();

    const double barWidth = 4.0;
    const double barSpacing = 3.0;

    final totalBars = ((containerWidth) / (barWidth + barSpacing)).floor();
    final activeBars = (_currentValue * totalBars).round();

    return SizedBox(
      width: containerWidth,
      child: Wrap(
        spacing: barSpacing,
        children: List.generate(totalBars, (index) {
          final isActive = index < activeBars;
          return Container(
            width: barWidth,
            height: theme.barHeight,
            decoration: BoxDecoration(
              color: isActive ? theme.activeColor : theme.inactiveColor,
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
        // SizedBox(
        //   height: theme.boxHeight,
        //   width: theme.boxWidth,
        //   child: Icon(
        //     widget.leftIcon,
        //     size: theme.iconSize,
        //     color: theme.iconColor ?? theme.activeColor,
        //   ),
        // ).padOnly(left: theme.iconLeftPadding, right: theme.iconRightPadding),

        // Slider
        Expanded(
          child: widget.isDotSlider
              ? _buildDotPatternSlider(
                  containerWidth: sliderWidth, theme: theme)
              : Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B2B2B),
                    borderRadius: theme.widgetRadius,
                  ),
                  child: _buildBarSlider(
                      containerWidth: sliderWidth, theme: theme),
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = MechanixSliderTheme.of(context).merge(widget.theme);

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth =
            constraints.maxWidth - (theme.horizontalPadding * 2);

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
            color: context.colorScheme.secondary,
            padding: EdgeInsets.symmetric(horizontal: theme.horizontalPadding),
            child: _buildSliderWithIcon(
                availableWidth: availableWidth, theme: theme),
          ),
        );
      },
    );
  }
}
