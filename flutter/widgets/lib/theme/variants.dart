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
  static const List<MechanixVariant> values = [
    yellow,
    amber,
    orange,
    coral,
    magenta,
    purple,
    blue,
    mint,
  ];

  static const yellow = MechanixVariant._("Yellow", MechanixColors.yellow);
  static const amber = MechanixVariant._("Amber", MechanixColors.amber);
  static const orange = MechanixVariant._("Orange", MechanixColors.orange);
  static const coral = MechanixVariant._("Coral", MechanixColors.coral);
  static const magenta = MechanixVariant._("Magenta", MechanixColors.magenta);
  static const purple = MechanixVariant._("Purple", MechanixColors.purple);
  static const blue = MechanixVariant._("Blue", MechanixColors.blue);
  static const mint = MechanixVariant._("Mint", MechanixColors.mint);

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
