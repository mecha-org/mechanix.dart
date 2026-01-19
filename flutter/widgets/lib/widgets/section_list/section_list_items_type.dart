import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';

class SectionListItems {
  SectionListItems({
    this.title = '',
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
    this.titleWidget,
    this.height,
  })  : iconContainerSize = const Size(24, 24),
        iconSize = const Size(18, 18),
        activeIconColor = null,
        isActive = false,
        iconPath = '',
        iconColor = null;

  SectionListItems.leadingIcon({
    this.title = '',
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
    this.activeIconColor,
    this.isActive = false,
    this.iconColor,
    this.titleWidget,
    this.height,
    required this.iconPath,
  }) : leading = null;

  final Widget? leading;
  final Widget? trailing;
  final bool defaultTrailingIcon;
  final String title;
  final TextStyle? titleTextStyle;
  final Widget? titleWidget;
  final GestureTapCallback? onTap;
  final GestureTapUpCallback? onTapUp;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCallback? onDoubleTap;
  final Color? backgroundColor;
  final bool disabled;
  final Size iconContainerSize;
  final Size iconSize;
  final String iconPath;
  final Color? activeIconColor;
  final Color? iconColor;
  final bool isActive;
  final double? height;

  Widget? buildLeadingIcon(BuildContext context) {
    if (iconPath.isNotEmpty) {
      return IconWidget(
        activeIconColor: activeIconColor,
        isActive: isActive,
        boxHeight: iconContainerSize.height,
        boxWidth: iconContainerSize.width,
        iconHeight: iconSize.height,
        iconWidth: iconSize.width,
        iconColor: iconColor ?? context.onSurfaceVariant,
        iconPath: iconPath,
      ).padRight();
    }
    return null;
  }
}
