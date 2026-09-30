import 'package:flutter/material.dart';

import '../text-field/text_field.dart';
import 'menu.dart';
import 'menu_controller.dart';
import 'menu_entry.dart';
import 'menu_enums.dart';
import 'menu_theme.dart';

/// A text-field dropdown menu following Mechanix design specifications.
///
/// Built on the existing [MechanixTextField], featuring a floating label,
/// underline accent indicator, optional leading search icon, clear button,
/// type-to-filter capability, matching anchor width, and combobox accessibility semantics.
///
/// Example:
/// ```dart
/// MechanixDropdownMenu<String>(
///   labelText: 'COUNTRY',
///   hintText: 'Select country',
///   leadingIcon: Icons.search_rounded,
///   entries: const [
///     MechanixMenuItem(value: 'us', label: 'United States'),
///     MechanixMenuItem(value: 'ca', label: 'Canada'),
///     MechanixMenuItem(value: 'mx', label: 'Mexico'),
///   ],
///   onSelected: (val) => print('Selected: $val'),
/// )
/// ```
class MechanixDropdownMenu<T> extends StatefulWidget {
  /// Creates a [MechanixDropdownMenu].
  const MechanixDropdownMenu({
    super.key,
    required this.entries,
    this.selectedValue,
    this.onSelected,
    this.labelText,
    this.hintText,
    this.leadingIcon,
    this.size = MechanixMenuSize.regular,
    this.maxHeight = 300.0,
    this.enabled = true,
    this.showClearButton = true,
    this.filter,
    this.emptyStateMessage = 'No results found',
    this.emptyStateBuilder,
    this.focusNode,
    this.textEditingController,
    this.menuController,
    this.style,
  });

  /// The list of items to display in the dropdown menu.
  final List<MechanixMenuItem<T>> entries;

  /// The currently selected value.
  final T? selectedValue;

  /// Callback when a value is selected or cleared (null).
  final ValueChanged<T?>? onSelected;

  /// Floating label text displayed above the input.
  final String? labelText;

  /// Hint text displayed inside the field when empty.
  final String? hintText;

  /// Optional leading icon (e.g. search icon).
  final IconData? leadingIcon;

  /// Sizing variant for the menu items.
  final MechanixMenuSize size;

  /// Maximum height of the dropdown popup before scrolling.
  final double maxHeight;

  /// Whether the dropdown is interactive.
  final bool enabled;

  /// Whether to display a trailing clear (X) button when text is present.
  final bool showClearButton;

  /// Optional custom filter predicate.
  ///
  /// Defaults to case-insensitive substring matching against [MechanixMenuItem.labelText].
  final bool Function(MechanixMenuItem<T> item, String query)? filter;

  /// Text displayed when the filtered item list is empty.
  final String emptyStateMessage;

  /// Custom builder for the empty state when no results match the filter query.
  final WidgetBuilder? emptyStateBuilder;

  /// Focus node for the text field.
  final FocusNode? focusNode;

  /// Optional external controller for the input text.
  final TextEditingController? textEditingController;

  /// Optional external controller for programmatically driving menu open/closed state.
  final MechanixMenuController? menuController;

  /// Optional style override configuration for the menu popup.
  final MenuThemeDataConfig? style;

  @override
  State<MechanixDropdownMenu<T>> createState() =>
      _MechanixDropdownMenuState<T>();
}

class _MechanixDropdownMenuState<T> extends State<MechanixDropdownMenu<T>> {
  late final TextEditingController _textController;
  late final FocusNode _effectiveFocusNode;
  late final MechanixMenuController _effectiveMenuController;

  String _filterQuery = '';

  @override
  void initState() {
    super.initState();
    _textController = widget.textEditingController ?? TextEditingController();
    _effectiveFocusNode = widget.focusNode ?? FocusNode();
    _effectiveMenuController =
        widget.menuController ?? MechanixMenuController();

    _updateTextFromSelectedValue();

    _effectiveFocusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant MechanixDropdownMenu<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedValue != oldWidget.selectedValue) {
      _updateTextFromSelectedValue();
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) _effectiveFocusNode.dispose();
    if (widget.textEditingController == null) _textController.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_effectiveFocusNode.hasFocus && !_effectiveMenuController.isOpen) {
      _effectiveMenuController.open();
    }
  }

  void _updateTextFromSelectedValue() {
    if (widget.selectedValue != null) {
      for (final item in widget.entries) {
        if (item.value == widget.selectedValue) {
          _textController.text = item.labelText ?? item.semanticLabel ?? '';
          return;
        }
      }
    }
  }

  List<MechanixMenuEntry<T>> _buildFilteredEntries() {
    final defaultFilter =
        widget.filter ??
        (item, query) {
          final text = item.labelText ?? item.semanticLabel ?? '';
          return text.toLowerCase().contains(query.toLowerCase());
        };

    final filtered = widget.entries
        .where((item) => defaultFilter(item, _filterQuery))
        .map((item) {
          final isSelected = item.value == widget.selectedValue;
          return MechanixMenuItem<T>(
            value: item.value,
            label: item.label,
            labelText: item.labelText,
            leading: item.leading,
            leadingIcon: item.leadingIcon,
            trailing: item.trailing,
            trailingIcon: item.trailingIcon,
            trailingText: item.trailingText,
            badge: item.badge,
            supportingText: item.supportingText,
            enabled: item.enabled,
            selected: isSelected,
            onTap: item.onTap,
            semanticLabel: item.semanticLabel,
          );
        })
        .toList();

    if (filtered.isEmpty) {
      return [
        MechanixMenuCustomEntry(
          builder: (context) {
            if (widget.emptyStateBuilder != null) {
              return widget.emptyStateBuilder!(context);
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  widget.emptyStateMessage,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            );
          },
        ),
      ];
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filteredEntries = _buildFilteredEntries();

    return MechanixMenu<T>(
      controller: _effectiveMenuController,
      entries: filteredEntries,
      matchAnchorWidth: true,
      maxHeight: widget.maxHeight,
      size: widget.size,
      style: widget.style,
      onSelected: (val) {
        for (final item in widget.entries) {
          if (item.value == val) {
            _textController.text = item.labelText ?? item.semanticLabel ?? '';
            _filterQuery = '';
            break;
          }
        }
        widget.onSelected?.call(val);
      },
      anchorBuilder: (context, controller, _) {
        final showClear =
            widget.showClearButton &&
            _textController.text.isNotEmpty &&
            widget.enabled;

        return Semantics(
          expanded: controller.isOpen,
          textField: true,
          label: widget.labelText,
          value: _textController.text,
          child: MechanixTextField.filled(
            controller: _textController,
            focusNode: _effectiveFocusNode,
            enabled: widget.enabled,
            labelText: widget.labelText,
            hintText: widget.hintText,
            prefixIcon: widget.leadingIcon != null
                ? Icon(widget.leadingIcon, size: 20)
                : null,
            suffixIcon: showClear
                ? IconButton(
                    icon: const Icon(Icons.close_rounded, size: 18),
                    onPressed: () {
                      _textController.clear();
                      setState(() {
                        _filterQuery = '';
                      });
                      widget.onSelected?.call(null);
                    },
                  )
                : null,
            onTap: () {
              if (!controller.isOpen) {
                controller.open();
              }
            },
            onChanged: (text) {
              setState(() {
                _filterQuery = text;
              });
              if (!controller.isOpen) {
                controller.open();
              }
            },
          ),
        );
      },
    );
  }
}
