import 'package:flutter/material.dart';

import './colors.dart';
import './theme_data.dart';

enum MechanixVariant implements Comparable<MechanixVariant> {
  viridian(MechanixColors.viridian),
  purple(MechanixColors.purple),
  red(MechanixColors.red),
  olive(MechanixColors.olive),
  blue(MechanixColors.blue),
  magenta(MechanixColors.magenta),
  green(MechanixColors.green),
  amber(MechanixColors.amber);

  const MechanixVariant(this.color);

  final Color color;

  ThemeData get theme => createLightTheme(primaryColor: color);

  ThemeData get darkTheme => createDarkTheme(primaryColor: color);

  @override
  int compareTo(MechanixVariant other) {
    throw UnimplementedError();
  }
}
