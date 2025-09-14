import 'package:flutter/material.dart';

@immutable
class WheelScrollOption<T> {
  const WheelScrollOption({
    required this.value,
    required this.label,
    this.leading,
    this.trailing,
    this.metadata,
  });

  final T value;
  final String label;
  final Widget? leading;
  final Widget? trailing;
  final Map<String, dynamic>? metadata;

  WheelScrollOption<T> copyWith({
    T? value,
    String? label,
    Widget? leading,
    Widget? trailing,
    Map<String, dynamic>? metadata,
  }) {
    return WheelScrollOption<T>(
      value: value ?? this.value,
      label: label ?? this.label,
      leading: leading ?? this.leading,
      trailing: trailing ?? this.trailing,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WheelScrollOption<T> &&
        other.value == value &&
        other.label == label;
  }

  @override
  int get hashCode => Object.hash(value, label);

  @override
  String toString() => 'WheelScrollOption(value: $value, label: $label)';
}
