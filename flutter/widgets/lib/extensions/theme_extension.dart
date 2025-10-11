import 'package:flutter/material.dart';
import 'package:widgets/extensions/build_context.dart';
import 'package:widgets/widgets/listItems/mechanix_simple_list_theme.dart';
import 'package:widgets/widgets/menu/mechanix_menu_theme.dart';
import 'package:widgets/widgets/navigation_bar/mechanix_navigation_bar_theme.dart';
import 'package:widgets/widgets/pressable_list/mechanix_pressable_list_theme.dart';
import 'package:widgets/widgets/searchbar/mechanix_search_bar_theme.dart';
import 'package:widgets/widgets/sectionList/mechanix_section_list_theme.dart';
import 'package:widgets/widgets/slider/mechanix_slider_theme.dart';
import 'package:widgets/widgets/textInput/mechanix_text_input_theme.dart';
import 'package:widgets/widgets/wheelScroll/mechanix_wheel_scroll_theme.dart';

extension MechanixWheelScrollThemeDataExtensions
    on MechanixWheelScrollThemeData {
  MechanixWheelScrollThemeData merge(MechanixWheelScrollThemeData? other) {
    if (other == null) return this;

    return copyWith(
      selectionPadding: other.selectionPadding,
      selectedTextStyle: other.selectedTextStyle,
      notSelectedTextStyle: other.notSelectedTextStyle,
      selectionColor: other.selectionColor,
      selectionBorderRadius: other.selectionBorderRadius,
    );
  }
}

extension MechanixSimpleListThemeDataExtensions on MechanixSimpleListThemeData {
  MechanixSimpleListThemeData merge(MechanixSimpleListThemeData? other) {
    if (other == null) return this;

    return copyWith(
      backgroundColor: other.backgroundColor,
      dividerColor: other.dividerColor,
      widgetRadius: other.widgetRadius,
      dividerThickness: other.dividerThickness,
      dividerHeight: other.dividerHeight,
      itemPadding: other.itemPadding,
      widgetMargin: other.widgetMargin,
    );
  }
}

extension MechanixTextInputThemeDataExtensions on MechanixTextInputThemeData {
  MechanixTextInputThemeData merge(MechanixTextInputThemeData? other) {
    if (other == null) return this;

    return copyWith(
      labelTextStyle: other.labelTextStyle,
      textStyle: other.textStyle,
      hintTextStyle: other.hintTextStyle,
      fillColor: other.fillColor,
      contentPadding: other.contentPadding,
      borderRadius: other.borderRadius,
      borderSide: other.borderSide,
      focusedBorderSide: other.focusedBorderSide,
      obscureTextIcon: other.obscureTextIcon,
      visibleTextIcon: other.visibleTextIcon,
      iconColor: other.iconColor,
      enabledBorderSide: other.enabledBorderSide,
    );
  }
}

extension MechanixSliderThemeDataExtensions on MechanixSliderThemeData {
  MechanixSliderThemeData merge(MechanixSliderThemeData? other) {
    if (other == null) return this;

    return copyWith(
      height: other.height,
      horizontalPadding: other.horizontalPadding,
      activeColor: other.activeColor,
      inactiveColor: other.inactiveColor,
      barHeight: other.barHeight,
      widgetRadius: other.widgetRadius,
      iconColor: other.iconColor,
      iconSize: other.iconSize,
      boxWidth: other.boxWidth,
      boxHeight: other.boxHeight,
      iconLeftPadding: other.iconLeftPadding,
      iconRightPadding: other.iconRightPadding,
      dotColor: other.dotColor,
      barBackgroundColor: other.barBackgroundColor,
      containerColor: other.containerColor,
    );
  }
}

extension MechanixSectionListThemeDataExtensions
    on MechanixSectionListThemeData {
  MechanixSectionListThemeData merge(MechanixSectionListThemeData? other) {
    if (other == null) return this;

    return copyWith(
      backgroundColor: other.backgroundColor,
      titleTextStyle: other.titleTextStyle,
      dividerThickness: other.dividerThickness,
      dividerHeight: other.dividerHeight,
      dividerColor: other.dividerColor,
      isDividerRequired: other.isDividerRequired,
      divider: other.divider,
      widgetPadding: other.widgetPadding,
      titlePadding: other.titlePadding,
      itemPadding: other.itemPadding,
      dividerPadding: other.dividerPadding,
      widgetRadius: other.widgetRadius,
      itemBorderRadius: other.itemBorderRadius,
    );
  }
}

extension MechanixSelectableListThemeDataExtensions
    on MechanixSelectableListThemeData {
  MechanixSelectableListThemeData merge(
      MechanixSelectableListThemeData? other, BuildContext context) {
    if (other == null) return this;

    return copyWith(
      backgroundColor: other.backgroundColor ??
          backgroundColor ??
          Theme.of(context).colorScheme.secondary,
      titleTextStyle: other.titleTextStyle ?? titleTextStyle,
      itemPadding: other.itemPadding ?? itemPadding,
      leadingIconPadding: other.leadingIconPadding ?? leadingIconPadding,
      trailingPadding: other.trailingPadding ?? trailingPadding,
      checkboxSpacing: other.checkboxSpacing ?? checkboxSpacing,
      checkboxColor: other.checkboxColor ?? checkboxColor,
      borderRadius: other.borderRadius ?? borderRadius,
    );
  }
}

extension MechanixNavigationBarThemeDataExtensions
    on MechanixNavigationBarThemeData {
  MechanixNavigationBarThemeData merge(
      MechanixNavigationBarThemeData? other, BuildContext context) {
    if (other == null) return this;

    return copyWith(
      backgroundColor:
          other.backgroundColor ?? backgroundColor ?? Colors.transparent,
      leadingWidth: other.leadingWidth ?? leadingWidth,
      titleStyle: other.titleStyle ?? titleStyle,
      foregroundColor: other.foregroundColor ??
          foregroundColor ??
          context.colorScheme.surfaceContainer,
      elevation: other.elevation ?? elevation,
      actionsIconTheme: other.actionsIconTheme ?? actionsIconTheme,
      titleSpacing: other.titleSpacing ?? titleSpacing,
      scrolledUnderElevation:
          other.scrolledUnderElevation ?? scrolledUnderElevation,
      actionsPadding: other.actionsPadding ?? actionsPadding,
    );
  }
}

extension MechanixSearchBarThemeDataExtensions on MechanixSearchBarThemeData {
  MechanixSearchBarThemeData merge(
      MechanixSearchBarThemeData? other, BuildContext context) {
    if (other == null) return this;

    return copyWith(
      borderSide: other.borderSide ?? borderSide,
      backgroundColor: other.backgroundColor ??
          backgroundColor ??
          WidgetStatePropertyAll(context.colorScheme.secondary),
      overlayColor: other.overlayColor ?? overlayColor,
      hintStyle: other.hintStyle ?? hintStyle,
      borderColor: other.borderColor ?? borderColor,
      defaultLeadingIconSize:
          other.defaultLeadingIconSize ?? defaultLeadingIconSize,
      searchIconSize: other.searchIconSize ?? searchIconSize,
      defaultTrailingIconSize:
          other.defaultTrailingIconSize ?? defaultTrailingIconSize,
      buttonSize: other.buttonSize ?? buttonSize,
      buttonBorderRadius: other.buttonBorderRadius ?? buttonBorderRadius,
      trailingContainerWidth:
          other.trailingContainerWidth ?? trailingContainerWidth,
    );
  }
}

extension MechanixMenuThemeDataExtensions on MechanixMenuThemeData {
  MechanixMenuThemeData merge(
      MechanixMenuThemeData? other, BuildContext context) {
    // if (other == null) return this;

    return copyWith(
      elevation: other?.elevation ?? elevation,
      borderRadius: other?.borderRadius ?? borderRadius,
      width: other?.width ?? width,
      maxHeight: other?.maxHeight ?? maxHeight,
      constraints: other?.constraints ?? constraints,
      itemBackgroundColor: other?.itemBackgroundColor ??
          itemBackgroundColor ??
          context.colorScheme.secondary,
      itemHoverColor: other?.itemHoverColor ??
          itemHoverColor ??
          context.colorScheme.outline,
      itemPadding: other?.itemPadding ?? itemPadding,
      itemBorderRadius: other?.itemBorderRadius ?? itemBorderRadius,
      itemHeight: other?.itemHeight ?? itemHeight,
      disabledTextStyle: other?.disabledTextStyle ?? disabledTextStyle,
      titleTextStyle: other?.titleTextStyle ?? titleTextStyle,
      iconColor: other?.iconColor ?? iconColor,
      disabledIconColor: other?.disabledIconColor ?? disabledIconColor,
    );
  }
}
