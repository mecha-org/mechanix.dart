import 'package:flutter/material.dart';

class MechanixMenuItemsType {
  const MechanixMenuItemsType({
    required this.title,
    this.leading,
    this.trailing,
    this.titleTextStyle,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onDoubleTap,
    this.disabled = false,
    this.isSelected = false,
    this.value = '',
    this.leadingPadding = const EdgeInsets.only(right: 12),
    this.trailingPadding = const EdgeInsets.only(left: 12),
  });

  final Widget? leading;

  final Widget? trailing;

  final String title;

  final TextStyle? titleTextStyle;

  final GestureTapCallback? onTap;

  final GestureTapUpCallback? onTapUp;

  final GestureTapDownCallback? onTapDown;

  final GestureTapCallback? onDoubleTap;

  final bool disabled;

  final bool isSelected;

  final String value;

  final EdgeInsets leadingPadding;

  final EdgeInsets trailingPadding;
}
