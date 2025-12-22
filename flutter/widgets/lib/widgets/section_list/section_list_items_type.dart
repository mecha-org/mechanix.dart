import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';

class SectionListItems {
  SectionListItems({
    required this.title,
    this.leading,
    this.trailing,
    this.titleTextStyle,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onDoubleTap,
    this.defaultTrailingIcon = true,
    this.backgroundColor,
    this.disabled = false,
  })  : iconContainerSize = const Size(24, 24),
        iconSize = const Size(18, 18),
        iconPath = '';

  SectionListItems.leadingIcon({
    required this.title,
    this.trailing,
    this.titleTextStyle,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onDoubleTap,
    this.defaultTrailingIcon = true,
    this.backgroundColor,
    this.disabled = false,
    this.iconContainerSize = const Size(24, 24),
    this.iconSize = const Size(18, 18),
    required this.iconPath,
  }) : leading = null;

  final Widget? leading;
  final Widget? trailing;
  final bool defaultTrailingIcon;
  final String title;
  final TextStyle? titleTextStyle;
  final GestureTapCallback? onTap;
  final GestureTapUpCallback? onTapUp;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCallback? onDoubleTap;
  final Color? backgroundColor;
  final bool disabled;
  final Size iconContainerSize;
  final Size iconSize;
  final String iconPath;

  Widget? buildLeadingIcon(BuildContext context) {
    if (iconPath != '') {
      return IconWidget(
        boxHeight: iconContainerSize.height,
        boxWidth: iconContainerSize.width,
        iconHeight: iconSize.height,
        iconWidth: iconSize.width,
        iconColor: context.primary,
        iconPath: iconPath,
      ).padRight();
    }

    return null;
  }
}
