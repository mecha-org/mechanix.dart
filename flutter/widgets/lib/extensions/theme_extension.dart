import 'package:widgets/widgets/listItems/mechanix_simple_list_theme.dart';
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
