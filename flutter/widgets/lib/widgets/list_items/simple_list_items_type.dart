import 'package:flutter/material.dart';

class SimpleListItems {
  SimpleListItems({
    required this.title,
    this.leading,
    this.trailing,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onDoubleTap,
    this.titleTextStyle,
    this.disabled = false,
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
}
