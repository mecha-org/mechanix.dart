import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    this.boxHeight = 24,
    this.boxWidth = 24,
    this.iconHeight = 24,
    this.iconWidth = 24,
    this.iconColor,
    this.activeIconColor,
    this.isActive = false,
    required this.iconPath,
  })  : icon = null,
        package = null;

  const IconWidget.fromMechanix({
    super.key,
    this.boxHeight = 24,
    this.boxWidth = 24,
    this.iconHeight = 24,
    this.iconWidth = 24,
    this.iconColor,
    this.activeIconColor,
    this.isActive = false,
    this.package = 'widgets',
    required this.iconPath,
  }) : icon = null;

  const IconWidget.fromIconData({
    super.key,
    this.boxHeight = 24,
    this.boxWidth = 24,
    this.iconHeight = 24,
    this.iconWidth = 24,
    this.iconColor,
    this.activeIconColor,
    this.isActive = false,
    required this.icon,
  })  : iconPath = '',
        package = null;

  final double boxHeight;
  final double boxWidth;
  final double iconHeight;
  final double iconWidth;
  final String iconPath;
  final bool isActive;
  final Icon? icon;
  final String? package;
  final Color? iconColor;
  final Color? activeIconColor;

  IconWidget copyWith({
    double? boxHeight,
    double? boxWidth,
    double? iconHeight,
    double? iconWidth,
    String? iconPath,
    bool? isActive,
    Icon? icon,
    String? package,
    Color? iconColor,
    Color? activeIconColor,
  }) {
    if (this.icon != null) {
      return IconWidget.fromIconData(
        boxHeight: boxHeight ?? this.boxHeight,
        boxWidth: boxWidth ?? this.boxWidth,
        iconHeight: iconHeight ?? this.iconHeight,
        iconWidth: iconWidth ?? this.iconWidth,
        icon: icon ?? this.icon,
        isActive: isActive ?? this.isActive,
        iconColor: iconColor ?? this.iconColor,
        activeIconColor: activeIconColor ?? this.activeIconColor,
      );
    }

    // Case 2: Mechanix asset widget
    if (this.package != null) {
      return IconWidget.fromMechanix(
        boxHeight: boxHeight ?? this.boxHeight,
        boxWidth: boxWidth ?? this.boxWidth,
        iconHeight: iconHeight ?? this.iconHeight,
        iconWidth: iconWidth ?? this.iconWidth,
        iconPath: iconPath ?? this.iconPath,
        package: package ?? this.package,
        isActive: isActive ?? this.isActive,
        iconColor: iconColor ?? this.iconColor,
        activeIconColor: activeIconColor ?? this.activeIconColor,
      );
    }

    // Case 3: Normal asset widget
    return IconWidget(
      boxHeight: boxHeight ?? this.boxHeight,
      boxWidth: boxWidth ?? this.boxWidth,
      iconHeight: iconHeight ?? this.iconHeight,
      iconWidth: iconWidth ?? this.iconWidth,
      iconPath: iconPath ?? this.iconPath,
      isActive: isActive ?? this.isActive,
      iconColor: iconColor ?? this.iconColor,
      activeIconColor: activeIconColor ?? this.activeIconColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return SizedBox(
        height: boxHeight,
        width: boxWidth,
        child: FittedBox(
          fit: BoxFit.none,
          child: SizedBox(
            height: iconHeight,
            width: iconWidth,
            child: Icon(
              icon?.icon,
              color: isActive
                  ? activeIconColor ?? context.primary
                  : iconColor ?? context.onSurface,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: boxHeight,
      width: boxWidth,
      child: FittedBox(
        fit: BoxFit.none,
        child: SizedBox(
          height: iconHeight,
          width: iconWidth,
          child: package != null
              ? Image.asset(
                  iconPath,
                  color: isActive
                      ? activeIconColor ?? context.primary
                      : iconColor ?? context.onSurface,
                  package: package,
                )
              : Image.asset(
                  iconPath,
                  color: isActive
                      ? activeIconColor ?? context.primary
                      : iconColor ?? context.onSurface,
                ),
        ),
      ),
    );
  }
}
