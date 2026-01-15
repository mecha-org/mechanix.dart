import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';

import './theme_data.dart';
// TODO: Revisit this code later

// enum MechanixVariant implements Comparable<MechanixVariant> {
//   viridian(MechanixColors.viridian),
//   purple(MechanixColors.purple),
//   red(MechanixColors.red),
//   olive(MechanixColors.olive),
//   blue(MechanixColors.blue),
//   magenta(MechanixColors.magenta),
//   green(MechanixColors.green),
//   amber(MechanixColors.amber);

//   const MechanixVariant(this.color);

//   final Color color;

//   ThemeData get theme => createLightTheme(primaryColor: color);

//   ThemeData get darkTheme => createDarkTheme(primaryColor: color);

//   @override
//   int compareTo(MechanixVariant other) {
//     throw UnimplementedError();
//   }
// }

class MechanixVariant implements Comparable<MechanixVariant> {
  static final List<MechanixVariant> values = [
    viridian,
    purple,
    red,
    olive,
    blue,
    magenta,
    green,
    amber,
  ];

  // Predefined variants
  static final viridian =
      MechanixVariant._('viridian', MechanixColors.viridian);
  static final purple = MechanixVariant._('purple', MechanixColors.purple);
  static final red = MechanixVariant._('red', MechanixColors.red);
  static final olive = MechanixVariant._('olive', MechanixColors.olive);
  static final blue = MechanixVariant._('blue', MechanixColors.blue);
  static final magenta = MechanixVariant._('magenta', MechanixColors.magenta);
  static final green = MechanixVariant._('green', MechanixColors.green);
  static final amber = MechanixVariant._('amber', MechanixColors.amber);

  // Factory for custom variants with optional name
  factory MechanixVariant.custom(Color color, {String? name}) {
    final variantName = name ?? _generateNameFromColor(color);
    return MechanixVariant._(variantName, color);
  }

  // Private constructor
  const MechanixVariant._(this.name, this.color);

  final String name;
  final Color color;

  // Generate a name from color value
  static String _generateNameFromColor(Color color) {
    return 'color_${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  // Rest of your existing methods remain the same...
  bool get isPredefined => values.contains(this);
  bool get isCustom => !isPredefined;

  ThemeData themeFrom(MechanixThemeData data) {
    return createLightTheme(
      primaryColor: color,
      backgroundColor: data.backgroundColor,
      foregroundColor: data.foregroundColor,
    );
  }

  ThemeData darkThemeFrom(MechanixThemeData data) {
    return createDarkTheme(
      primaryColor: color,
      backgroundColor: data.backgroundColor,
      foregroundColor: data.foregroundColor,
    );
  }

  @override
  String toString() => 'MechanixVariant.$name';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MechanixVariant &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          color.value == other.color.value;

  @override
  int get hashCode => name.hashCode ^ color.value.hashCode;

  @override
  int compareTo(MechanixVariant other) => name.compareTo(other.name);

  Map<String, dynamic> toJson() => {'name': name, 'color': color.value};

  MechanixVariant copyWith({String? name, Color? color}) {
    return MechanixVariant._(
      name ?? this.name,
      color ?? this.color,
    );
  }

  static MechanixVariant? findByName(String name) {
    for (final variant in values) {
      if (variant.name == name) return variant;
    }
    return null;
  }

  static List<MechanixVariant> getAllVariants({
    List<MechanixVariant> customVariants = const [],
  }) =>
      [...values, ...customVariants];
}
