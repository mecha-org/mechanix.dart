import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/pressable_list/mechanix_pressable_list_theme.dart';

class MechanixSelectableList extends StatelessWidget {
  final GestureTapCallback? onLongPress;
  final GestureTapCallback? onTap;
  final bool selectionMode;
  final bool isSelected;
  final Widget? leadingIcon;
  final Widget? trailingWidget;
  final String title;
  final ValueChanged<bool?>? onCheckboxClick;
  final MouseCursor mouseCursor;
  final MechanixSelectableListThemeData? theme;

  const MechanixSelectableList({
    super.key,
    this.onLongPress,
    this.onTap,
    this.selectionMode = false,
    this.isSelected = false,
    this.title = '',
    this.leadingIcon,
    this.onCheckboxClick,
    this.trailingWidget,
    this.theme,
    this.mouseCursor = SystemMouseCursors.click,
  });

  @override
  Widget build(BuildContext context) {
    final listTheme =
        MechanixSelectableListTheme.of(context).merge(theme, context);

    return Material(
      borderRadius: listTheme.borderRadius,
      color: listTheme.backgroundColor,
      child: MouseRegion(
          cursor: mouseCursor,
          child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onLongPress: onLongPress,
              onTap: onTap,
              child: Container(
                padding: listTheme.itemPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (selectionMode)
                          Container(
                              padding: listTheme.checkboxSpacing,
                              child: MechanixCircleCheckbox(
                                value: isSelected,
                                onChanged: onCheckboxClick,
                                activeColor: listTheme.checkboxColor ??
                                    context.colorScheme.primary,
                                autofocus: false,
                                tristate: false,
                                width: 20,
                              )),
                        if (leadingIcon != null)
                          Container(
                            padding: listTheme.leadingIconPadding,
                            child: leadingIcon,
                          ),
                        if (title.isNotEmpty)
                          Text(
                            title,
                            style: listTheme.titleTextStyle,
                          ),
                      ],
                    ),
                    if (trailingWidget != null)
                      Container(
                        padding: listTheme.trailingPadding,
                        child: trailingWidget,
                      )
                  ],
                ),
              ))),
    );
  }
}
