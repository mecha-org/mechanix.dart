import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/bottom_bar/mechanix_bottom_bar_theme.dart';
import 'package:widgets/widgets/filled_button/mechanix_filled_button_theme.dart';
import 'package:widgets/widgets/floating_action_bar/mechanix_floating_action_bar_theme.dart';
import 'package:widgets/widgets/list_items/mechanix_simple_list_theme.dart';
import 'package:widgets/widgets/menu/mechanix_menu_theme.dart';
import 'package:widgets/widgets/navigation_bar/mechanix_navigation_bar_theme.dart';
import 'package:widgets/widgets/pressable_list/mechanix_pressable_list_theme.dart';
import 'package:widgets/widgets/search_bar/mechanix_search_bar_theme.dart';
import 'package:widgets/widgets/section_list/mechanix_section_list_theme.dart';
import 'package:widgets/widgets/slider/mechanix_slider_theme.dart';
import 'package:widgets/widgets/text_input/mechanix_text_input_theme.dart';
import 'package:widgets/widgets/wheel_scroll/mechanix_wheel_scroll_theme.dart';

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
  MechanixSimpleListThemeData merge(
      BuildContext context, MechanixSimpleListThemeData? other) {
    return copyWith(
      backgroundColor:
          other?.backgroundColor ?? backgroundColor ?? context.tertiary,
      dividerColor: other?.dividerColor ?? dividerColor,
      widgetRadius: other?.widgetRadius ?? widgetRadius,
      dividerThickness: other?.dividerThickness ?? dividerThickness,
      dividerHeight: other?.dividerHeight ?? dividerHeight,
      itemPadding: other?.itemPadding ?? itemPadding,
      widgetMargin: other?.widgetMargin ?? widgetMargin,
    );
  }
}

extension MechanixTextInputThemeDataExtensions on MechanixTextInputThemeData {
  MechanixTextInputThemeData merge(MechanixTextInputThemeData? other) {
    return copyWith(
      labelTextStyle: other?.labelTextStyle ?? labelTextStyle,
      textStyle: other?.textStyle ?? textStyle,
      hintTextStyle: other?.hintTextStyle ?? hintTextStyle,
      fillColor: other?.fillColor ?? fillColor,
      contentPadding: other?.contentPadding ?? contentPadding,
      borderRadius: other?.borderRadius ?? borderRadius,
      borderSide: other?.borderSide ?? borderSide,
      focusedBorderSide: other?.focusedBorderSide ?? focusedBorderSide,
      obscureTextIcon: other?.obscureTextIcon ?? obscureTextIcon,
      visibleTextIcon: other?.visibleTextIcon ?? visibleTextIcon,
      iconColor: other?.iconColor ?? iconColor,
      enabledBorderSide: other?.enabledBorderSide ?? enabledBorderSide,
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
  MechanixSectionListThemeData merge(
      MechanixSectionListThemeData? other, BuildContext context) {
    return copyWith(
      backgroundColor: other?.backgroundColor ??
          backgroundColor ??
          WidgetStateProperty.all(context.tertiary),
      titleTextStyle: other?.titleTextStyle ??
          titleTextStyle?.copyWith(color: context.onSurfaceVariant),
      dividerThickness: other?.dividerThickness ?? dividerThickness,
      dividerHeight: other?.dividerHeight ?? dividerHeight,
      dividerColor: other?.dividerColor ?? dividerColor ?? context.outline,
      divider: other?.divider ?? divider,
      widgetPadding: other?.widgetPadding ?? widgetPadding,
      titlePadding: other?.titlePadding ?? titlePadding,
      itemPadding: other?.itemPadding ?? itemPadding,
      dividerPadding: other?.dividerPadding ?? dividerPadding,
      widgetRadius: other?.widgetRadius ?? widgetRadius,
      itemBorderRadius: other?.itemBorderRadius ?? itemBorderRadius,
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
    return copyWith(
      backgroundColor:
          other?.backgroundColor ?? backgroundColor ?? Colors.transparent,
      leadingWidth: other?.leadingWidth ?? leadingWidth,
      titleStyle: titleStyle?.merge(other?.titleStyle),
      foregroundColor: other?.foregroundColor ??
          foregroundColor ??
          context.colorScheme.surfaceContainer,
      elevation: other?.elevation ?? elevation,
      actionsIconTheme: other?.actionsIconTheme ?? actionsIconTheme,
      titleSpacing: other?.titleSpacing ?? titleSpacing,
      scrolledUnderElevation:
          other?.scrolledUnderElevation ?? scrolledUnderElevation,
      actionsPadding: other?.actionsPadding ?? actionsPadding,
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
    return copyWith(
      elevation: other?.elevation ?? elevation,
      borderRadius: other?.borderRadius ?? borderRadius,
      dropdownWidth: other?.dropdownWidth ?? dropdownWidth,
      dropdownHeight: other?.dropdownHeight ?? dropdownHeight,
      constraints: other?.constraints ?? constraints,
      itemBackgroundColor: other?.itemBackgroundColor ?? itemBackgroundColor,
      itemPadding: other?.itemPadding ?? itemPadding,
      itemBorderRadius: other?.itemBorderRadius ?? itemBorderRadius,
      itemHeight: other?.itemHeight ?? itemHeight,
      disabledTextStyle: other?.disabledTextStyle ??
          disabledTextStyle?.copyWith(color: context.surfaceContainerHigh),
      titleTextStyle: other?.titleTextStyle ?? titleTextStyle,
      margin: other?.margin ?? margin,
      transform: other?.transform ?? transform,
      transformAlignment: other?.transformAlignment ?? transformAlignment,
      alignment: other?.alignment ?? alignment,
      foregroundDecoration: other?.foregroundDecoration ?? foregroundDecoration,
      padding: other?.padding ?? padding,
      decoration:
          other?.decoration ?? decoration?.copyWith(color: context.secondary),
      disabledBackgroundColor:
          other?.disabledBackgroundColor ?? disabledBackgroundColor,
      activeButtonDecoration: other?.activeButtonDecoration ??
          activeButtonDecoration.copyWith(color: context.tertiary),
      buttonMargin: other?.buttonMargin ?? buttonMargin,
      buttonPadding: other?.buttonPadding ?? buttonPadding,
      buttonSize: other?.buttonSize ?? buttonSize,
      disableOpacity: other?.disableOpacity ?? disableOpacity,
      selectedBackgroundColor: other?.selectedBackgroundColor ??
          selectedBackgroundColor ??
          context.tertiary,
    );
  }
}

extension MechanixFloatingActionBarThemeDataExtensions
    on MechanixFloatingActionBarThemeData {
  MechanixFloatingActionBarThemeData merge(
      MechanixFloatingActionBarThemeData? other, BuildContext context) {
    return copyWith(
      height: other?.height ?? height,
      decoration: other?.decoration ??
          decoration ??
          BoxDecoration(
            color: context.secondary,
            borderRadius: BorderRadius.circular(8),
          ),
      padding: other?.padding ?? padding,
      width: other?.width ?? width,
      constraints: other?.constraints ?? constraints,
      margin: other?.margin ?? margin,
      transform: other?.transform ?? transform,
      transformAlignment: other?.transformAlignment ?? transformAlignment,
      alignment: other?.alignment ?? alignment,
      foregroundDecoration: other?.foregroundDecoration ?? foregroundDecoration,
      barMainAxisAlignment: other?.barMainAxisAlignment ?? barMainAxisAlignment,
      barMainAxisSize: other?.barMainAxisSize ?? barMainAxisSize,
      barCrossAxisAlignment:
          other?.barCrossAxisAlignment ?? barCrossAxisAlignment,
      barTextDirection: other?.barTextDirection ?? barTextDirection,
      barVerticalDirection: other?.barVerticalDirection ?? barVerticalDirection,
      barTextBaseline: other?.barTextBaseline ?? barTextBaseline,
      barSpacing: other?.barSpacing ?? barSpacing,
    );
  }
}

extension MechanixBottomBarThemeDataExtensions on MechanixBottomBarThemeData {
  MechanixBottomBarThemeData merge(
      MechanixBottomBarThemeData? other, BuildContext context) {
    return copyWith(
      decoration:
          other?.decoration ?? decoration?.copyWith(color: context.secondary),
      height: other?.height ?? height,
      width: other?.width ?? width,
      iconColor: other?.iconColor ?? context.colorScheme.primaryFixed,
      iconTheme: other?.iconTheme ?? iconTheme,
    );
  }
}

extension MechanixFilledButtonThemeDataExtensions
    on MechanixFilledButtonThemeData {
  MechanixFilledButtonThemeData merge(
      MechanixFilledButtonThemeData? other, BuildContext context) {
    return copyWith(
      decoration:
          other?.decoration ?? decoration?.copyWith(color: context.secondary),
      buttonSize: other?.buttonSize ?? buttonSize,
      labelText: other?.labelText ?? labelText,
      textStyle: other?.textStyle ?? textStyle,
      constraints: other?.constraints ?? constraints,
      margin: other?.margin ?? margin,
      padding: other?.padding ?? padding,
    );
  }
}
