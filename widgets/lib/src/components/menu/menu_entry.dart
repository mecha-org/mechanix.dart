import 'package:flutter/widgets.dart';

/// Base sealed class for all entries that can appear inside a Mechanix menu.
sealed class MechanixMenuEntry<T> {
  const MechanixMenuEntry();
}

class MechanixMenuItem<T> extends MechanixMenuEntry<T> {
  /// Creates a [MechanixMenuItem].
  const MechanixMenuItem({
    required this.value,
    this.label,
    this.labelText,
    this.leading,
    this.leadingIcon,
    this.trailing,
    this.trailingIcon,
    this.trailingText,
    this.badge,
    this.supportingText,
    this.enabled = true,
    this.selected = false,
    this.onTap,
    this.semanticLabel,
  }) : assert(
         label != null || labelText != null,
         'Either label or labelText must be provided.',
       ),
       assert(
         leading == null || leadingIcon == null,
         'Cannot provide both leading and leadingIcon.',
       ),
       assert(
         trailing == null || trailingIcon == null,
         'Cannot provide both trailing and trailingIcon.',
       );

  /// The value represented by this menu item, returned via callbacks upon selection.
  final T value;

  /// Custom widget for primary label (overrides [labelText] if provided).
  final Widget? label;

  /// Primary label text string.
  final String? labelText;

  /// An optional leading widget, such as an icon or avatar.
  ///
  /// Cannot be provided if [leadingIcon] is specified.
  final Widget? leading;

  /// An optional leading [IconData] rendered at the standard icon size.
  ///
  /// Cannot be provided if [leading] is specified.
  final IconData? leadingIcon;

  /// An optional trailing widget, such as a status icon or switch.
  ///
  /// Cannot be provided if [trailingIcon] is specified.
  final Widget? trailing;

  /// An optional trailing [IconData] rendered at the standard icon size.
  ///
  /// Cannot be provided if [trailing] is specified.
  final IconData? trailingIcon;

  /// An optional trailing text string, commonly used for keyboard shortcuts (e.g. '⌘C').
  final String? trailingText;

  /// An optional badge widget displayed next to the label (e.g. a "New" badge).
  final Widget? badge;

  /// Optional supporting secondary text displayed below or beside the primary label.
  final String? supportingText;

  /// Whether this item is interactive.
  ///
  /// Disabled items are rendered with dimmed opacity, cannot be activated,
  /// and are skipped by keyboard navigation. Defaults to true.
  final bool enabled;

  /// Whether this item is currently selected in a selection model.
  ///
  /// Defaults to false.
  final bool selected;

  /// Optional item-specific callback invoked when the item is activated.
  ///
  /// Order of precedence on activation:
  /// 1. [onTap] is called.
  /// 2. The enclosing menu's `onSelected(value)` is called.
  /// 3. The menu closes if `closeOnSelect` is true.
  final VoidCallback? onTap;

  /// An optional accessibility semantic label. If null, [labelText] is used.
  final String? semanticLabel;
}

class MechanixMenuDivider extends MechanixMenuEntry<Never> {
  /// Creates a [MechanixMenuDivider].
  const MechanixMenuDivider({
    this.height,
    this.thickness,
    this.color,
    this.indent,
    this.endIndent,
  });

  /// The total vertical space occupied by the divider.
  final double? height;

  /// The thickness of the divider line itself.
  final double? thickness;

  /// The color of the divider line. Defaults to the menu theme's outline/divider color.
  final Color? color;

  /// The amount of empty space to the leading edge of the divider.
  final double? indent;

  /// The amount of empty space to the trailing edge of the divider.
  final double? endIndent;
}

class MechanixMenuGroup<T> extends MechanixMenuEntry<T> {
  /// Creates a [MechanixMenuGroup].
  const MechanixMenuGroup({
    required this.entries,
    this.header,
    this.headerText,
    this.backgroundColor,
    this.padding,
    this.showDivider = false,
  }) : assert(
         header == null || headerText == null,
         'Cannot provide both header and headerText.',
       );

  /// The list of menu entries contained within this group.
  final List<MechanixMenuEntry<T>> entries;

  /// An optional custom widget rendered as the header of this group.
  ///
  /// Cannot be provided if [headerText] is specified.
  final Widget? header;

  /// An optional text string rendered as the header of this group using
  /// the design system's section header typography.
  ///
  /// Cannot be provided if [header] is specified.
  final String? headerText;

  /// An optional background color for this group, allowing subtle shade variation
  /// across groups as shown in the design specifications.
  final Color? backgroundColor;

  /// Optional padding around this group's content.
  final EdgeInsetsGeometry? padding;

  /// Whether to draw a separator divider before or after this group when stacked.
  ///
  /// Defaults to false.
  final bool showDivider;
}

class MechanixMenuCustomEntry extends MechanixMenuEntry<Never> {
  /// Creates a [MechanixMenuCustomEntry].
  const MechanixMenuCustomEntry({required this.builder});

  /// The builder function providing the widget to display.
  final Widget Function(BuildContext context) builder;
}
