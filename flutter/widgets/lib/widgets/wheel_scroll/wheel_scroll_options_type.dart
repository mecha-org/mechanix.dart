import 'package:flutter/material.dart';

@immutable
class WheelScrollOption<T> {
  const WheelScrollOption({
    required this.value,
    required this.label,
  });

  final T value;
  final String label;

  WheelScrollOption<T> copyWith({
    T? value,
    String? label,
  }) {
    return WheelScrollOption<T>(
      value: value ?? this.value,
      label: label ?? this.label,
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
