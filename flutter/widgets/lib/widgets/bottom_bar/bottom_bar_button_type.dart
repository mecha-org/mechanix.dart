import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/bottom_bar/mechanix_bottom_bar_theme.dart';
import 'package:widgets/widgets/floating_action_bar/mechanix_floating_action_bar_theme.dart';
import 'package:widgets/widgets/menu/constants/menu_positions.dart';

class BottomBarButton {
  const BottomBarButton({
    required this.onPressed,
    this.iconPath = '',
    this.iconWidget,
    this.isSelected = false,
    this.isDisabled = false,
    this.disabledColor = const Color(0xFF585858),
    this.onHover,
    this.onLongPress,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.enableFeedback,
    this.iconTheme,
    this.selectedIcon,
  })  : widget = null,
        extensionWidgets = const [],
        menuButton = null,
        floatingActionBarController = null,
        animationDuration = const Duration(milliseconds: 300),
        initiallyOpen = false,
        dropdownPosition = DropdownPosition.bottomCenter,
        floatingActionBarTheme = null,
        addAutomaticKeepAlives = true,
        addRepaintBoundaries = true,
        addSemanticIndexes = true,
        cacheExtent = null,
        controller = null,
        restorationId = null,
        findChildIndexCallback = null,
        clipBehavior = Clip.hardEdge,
        dragStartBehavior = DragStartBehavior.start,
        hitTestBehavior = HitTestBehavior.opaque,
        keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
        reverse = false,
        scrollDirection = Axis.vertical,
        shrinkWrap = true,
        offset = Offset.zero,
        isMenuButtonRequired = true,
        buttonIcon = null,
        outsideClickDisabled = false,
        onExtensionClose = null;

  const BottomBarButton.widget({
    required this.widget,
    this.disabledColor = const Color(0xFF585858),
    this.isDisabled = false,
    this.onHover,
    this.onLongPress,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.enableFeedback,
    this.selectedIcon,
  })  : iconPath = '',
        isSelected = false,
        iconTheme = null,
        iconWidget = null,
        onPressed = null,
        extensionWidgets = const [],
        menuButton = null,
        floatingActionBarController = null,
        animationDuration = const Duration(milliseconds: 300),
        initiallyOpen = false,
        dropdownPosition = DropdownPosition.bottomCenter,
        floatingActionBarTheme = null,
        addAutomaticKeepAlives = true,
        addRepaintBoundaries = true,
        addSemanticIndexes = true,
        cacheExtent = null,
        controller = null,
        restorationId = null,
        findChildIndexCallback = null,
        clipBehavior = Clip.hardEdge,
        dragStartBehavior = DragStartBehavior.start,
        hitTestBehavior = HitTestBehavior.opaque,
        keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
        reverse = false,
        scrollDirection = Axis.vertical,
        shrinkWrap = true,
        offset = Offset.zero,
        isMenuButtonRequired = true,
        buttonIcon = null,
        outsideClickDisabled = false,
        onExtensionClose = null;

  const BottomBarButton.extension({
    required this.extensionWidgets,
    this.iconPath = '',
    this.iconWidget,
    this.floatingActionBarController,
    this.animationDuration = const Duration(milliseconds: 300),
    this.initiallyOpen = false,
    this.dropdownPosition = DropdownPosition.topCenter,
    this.floatingActionBarTheme,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.controller,
    this.restorationId,
    this.findChildIndexCallback,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = true,
    this.offset = const Offset(0, -10),
    this.isMenuButtonRequired = true,
    this.buttonIcon,
    this.outsideClickDisabled = false,
    this.iconTheme,
    this.onPressed,
    this.onExtensionClose,
    this.isSelected = false,
    this.isDisabled = false,
  })  : disabledColor = const Color(0xFF585858),
        widget = null,
        onHover = null,
        onLongPress = null,
        mouseCursor = null,
        focusNode = null,
        autofocus = false,
        tooltip = null,
        menuButton = null,
        enableFeedback = null,
        selectedIcon = null;

  final String iconPath;
  final void Function()? onPressed;
  final VoidCallback? onExtensionClose;
  final IconWidget? iconWidget;
  final Widget? widget;
  final bool isSelected;
  final bool isDisabled;
  final Color disabledColor;

  final ValueChanged<bool>? onHover;
  final VoidCallback? onLongPress;
  final MouseCursor? mouseCursor;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? tooltip;
  final bool? enableFeedback;
  final Widget? selectedIcon;

  final MechanixBottomBarIconThemeData? iconTheme;

  final List<BottomBarButton> extensionWidgets;
  final Widget? menuButton;
  final FloatingActionBarController? floatingActionBarController;
  final Duration animationDuration;
  final bool initiallyOpen;
  final DropdownPosition dropdownPosition;
  final MechanixFloatingActionBarThemeData? floatingActionBarTheme;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final Clip clipBehavior;
  final ScrollController? controller;
  final DragStartBehavior dragStartBehavior;
  final HitTestBehavior hitTestBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final bool reverse;
  final Axis scrollDirection;
  final int? Function(Key key)? findChildIndexCallback;
  final bool shrinkWrap;
  final Offset offset;
  final bool isMenuButtonRequired;
  final bool outsideClickDisabled;
  final IconWidget? buttonIcon;

  Widget build(BuildContext context, MechanixBottomBarThemeData barTheme) {
    final theme = iconTheme ?? barTheme.iconTheme;

    if (widget != null) return widget!;

    if (extensionWidgets.isNotEmpty) {
      return MechanixFloatingActionBar(
        menus: extensionWidgets.map((e) => e.build(context, barTheme)).toList(),
        dropdownPosition: dropdownPosition,
        offset: offset,
        theme: floatingActionBarTheme ??
            MechanixFloatingActionBarThemeData(
              decoration: BoxDecoration(color: context.tertiary),
              width: double.infinity,
            ),
        onOpen: onPressed,
        onClose: onExtensionClose,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        animationDuration: animationDuration,
        cacheExtent: cacheExtent,
        clipBehavior: clipBehavior,
        controller: controller,
        dragStartBehavior: dragStartBehavior,
        findChildIndexCallback: findChildIndexCallback,
        floatingActionBarController: floatingActionBarController,
        hitTestBehavior: hitTestBehavior,
        initiallyOpen: initiallyOpen,
        isMenuButtonRequired: isMenuButtonRequired,
        keyboardDismissBehavior: keyboardDismissBehavior,
        menuButton: Container(
          width: theme?.buttonSize.width,
          height: theme?.buttonSize.height,
          decoration: isSelected ? theme?.activeButtonDecoration : null,
          margin: theme?.buttonMargin,
          padding: theme?.buttonPadding,
          child: iconWidget?.copyWith(isActive: isSelected) ??
              IconWidget(
                iconPath: iconPath,
                isActive: isSelected,
                iconColor: isDisabled ? disabledColor : context.onSurface,
              ),
        ),
        outsideClickDisabled: outsideClickDisabled,
        restorationId: restorationId,
        reverse: reverse,
        scrollDirection: scrollDirection,
        shrinkWrap: shrinkWrap,
      );
    }

    return Container(
      width: theme?.buttonSize.width,
      height: theme?.buttonSize.height,
      decoration: isSelected ? theme?.activeButtonDecoration : null,
      margin: theme?.buttonMargin,
      padding: theme?.buttonPadding,
      child: IconButton(
        isSelected: isSelected,
        disabledColor: disabledColor,
        iconSize: theme?.iconButtonSize,
        visualDensity: theme?.visualDensity,
        padding: theme?.padding,
        alignment: theme?.alignment,
        onHover: onHover,
        onLongPress: onLongPress,
        mouseCursor: mouseCursor,
        focusNode: focusNode,
        autofocus: autofocus,
        tooltip: tooltip,
        enableFeedback: enableFeedback,
        constraints: theme?.constraints,
        style: theme?.buttonStyle,
        selectedIcon: selectedIcon,
        color: theme?.iconColor ?? barTheme.iconColor,
        onPressed: isDisabled ? null : onPressed,
        icon: iconWidget?.copyWith(isActive: isSelected) ??
            IconWidget(
              iconPath: iconPath,
              isActive: isSelected,
              iconColor: theme?.iconColor ?? context.onSurface,
              boxHeight: theme?.iconBoxSize.height ?? 24,
              boxWidth: theme?.iconBoxSize.width ?? 24,
              iconHeight: theme?.iconSize.height ?? 24,
              iconWidth: theme?.iconSize.width ?? 24,
            ),
      ),
    );
  }
}
