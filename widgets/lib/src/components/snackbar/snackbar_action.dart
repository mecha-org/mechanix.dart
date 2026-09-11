import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// An action button displayed within a [MechanixSnackbar].
@immutable
class MechanixSnackbarAction with Diagnosticable {
  /// Creates an action button configuration for a [MechanixSnackbar].
  const MechanixSnackbarAction({
    required this.label,
    this.onPressed,
    this.textColor,
    this.backgroundColor,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
  });

  /// The text label displayed on the action button.
  final String label;

  /// Callback executed when the action button is activated.
  final VoidCallback? onPressed;

  /// If null, defaults to [MechanixSnackbarThemeData.actionColor] or
  /// [ColorScheme.primary].
  final Color? textColor;

  /// Optional background fill color for this action button.
  final Color? backgroundColor;

  /// An optional focus node for keyboard navigation.
  final FocusNode? focusNode;

  /// Whether this action should automatically request focus when displayed.
  final bool autofocus;

  /// An optional accessibility description for screen readers.
  final String? semanticLabel;

  /// Whether this action button is enabled and interactable.
  bool get isEnabled => onPressed != null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixSnackbarAction &&
        other.label == label &&
        other.onPressed == onPressed &&
        other.textColor == textColor &&
        other.backgroundColor == backgroundColor &&
        other.focusNode == focusNode &&
        other.autofocus == autofocus &&
        other.semanticLabel == semanticLabel;
  }

  @override
  int get hashCode => Object.hash(
    label,
    onPressed,
    textColor,
    backgroundColor,
    focusNode,
    autofocus,
    semanticLabel,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('label', label));
    properties.add(ColorProperty('textColor', textColor));
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(
      FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'),
    );
    properties.add(
      FlagProperty('isEnabled', value: isEnabled, ifFalse: 'disabled'),
    );
    properties.add(StringProperty('semanticLabel', semanticLabel));
  }
}
