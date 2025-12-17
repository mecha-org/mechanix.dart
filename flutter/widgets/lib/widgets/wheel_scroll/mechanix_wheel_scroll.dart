import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/wheel_scroll/mechanix_wheel_scroll_theme.dart';
import 'package:widgets/widgets/wheel_scroll/wheel_scroll_options_type.dart';

class MechanixWheelScroll<T> extends StatefulWidget {
  const MechanixWheelScroll({
    super.key,
    this.width,
    this.height = 200,
    this.selectionHeight = 50,
    this.selectionWidth = 80,
    this.useMagnifier = true,
    this.offAxisFraction = 0,
    this.itemExtent = 40,
    this.squeeze = 1,
    this.theme,
    this.isLoop = true,
    this.showLeading = true,
    this.showTrailing = true,
    this.scrollBehavior,
    this.physics = const FixedExtentScrollPhysics(),
    required this.value,
    required this.options,
    required this.onSelectedItemChanged,
  });

  final double? width;
  final double? height;
  final double? selectionHeight;
  final double? selectionWidth;
  final bool useMagnifier;
  final bool isLoop;
  final bool showLeading;
  final bool showTrailing;
  final double squeeze;
  final double itemExtent;
  final double offAxisFraction;
  final MechanixWheelScrollThemeData? theme;
  final List<WheelScrollOption<T>> options;
  final ScrollBehavior? scrollBehavior;
  final T value;
  final ScrollPhysics physics;
  final void Function(T value)? onSelectedItemChanged;

  @override
  State<MechanixWheelScroll<T>> createState() => _MechanixWheelScrollState<T>();
}

class _MechanixWheelScrollState<T> extends State<MechanixWheelScroll<T>> {
  final FixedExtentScrollController _controller = FixedExtentScrollController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = _findIndexByValue(widget.value);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.jumpToItem(_currentIndex);
      }
    });
  }

  @override
  void didUpdateWidget(MechanixWheelScroll<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update index if value changed
    if (oldWidget.value != widget.value) {
      final newIndex = _findIndexByValue(widget.value);
      if (newIndex != _currentIndex) {
        _currentIndex = newIndex;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_controller.hasClients) {
            _controller.jumpToItem(_currentIndex);
          }
        });
      }
    }
  }

  int _findIndexByValue(T value) {
    return widget.options.indexWhere((option) => option.value == value);
  }

  Widget _buildItem(
      BuildContext context, WheelScrollOption<T> option, bool isSelected) {
    final itemTheme = MechanixWheelScrollTheme.of(context).merge(widget.theme);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              option.label,
              textAlign: TextAlign.center,
              style: isSelected
                  ? itemTheme.selectedTextStyle
                      ?.copyWith(color: itemTheme.selectionTextColor)
                  : itemTheme.notSelectedTextStyle
                      ?.copyWith(color: context.colorScheme.secondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _handleSelectedItemChanged(int index) {
    if (index >= 0 && index < widget.options.length) {
      final selectedOption = widget.options[index];
      _currentIndex = index;
      widget.onSelectedItemChanged?.call(selectedOption.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    var wheelTheme = MechanixWheelScrollTheme.of(context).merge(widget.theme);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: wheelTheme.selectionPadding,
              child: Container(
                height: widget.selectionHeight,
                width: widget.selectionWidth,
                decoration: BoxDecoration(
                  color: wheelTheme.selectionColor ??
                      context.colorScheme.secondary,
                  borderRadius: wheelTheme.selectionBorderRadius,
                ),
              ),
            ),
          ),
          ListWheelScrollView.useDelegate(
            controller: _controller,
            itemExtent: widget.itemExtent,
            squeeze: widget.squeeze,
            useMagnifier: widget.useMagnifier,
            offAxisFraction: widget.offAxisFraction,
            scrollBehavior: widget.scrollBehavior,
            physics: widget.physics,
            onSelectedItemChanged: _handleSelectedItemChanged,
            childDelegate: widget.isLoop
                ? ListWheelChildLoopingListDelegate(
                    children: List.generate(widget.options.length, (index) {
                      final option = widget.options[index];
                      final isSelected = option.value == widget.value;
                      return _buildItem(context, option, isSelected);
                    }),
                  )
                : ListWheelChildListDelegate(
                    children: List.generate(widget.options.length, (index) {
                      final option = widget.options[index];
                      final isSelected = option.value == widget.value;
                      return _buildItem(context, option, isSelected);
                    }),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
