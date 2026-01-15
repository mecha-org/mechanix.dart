import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgets/constants.dart';
import 'package:widgets/mechanix.dart';

class MechanixTheme extends StatefulWidget {
  const MechanixTheme(
      {super.key,
      this.builder,
      this.child,
      this.data = const MechanixThemeData()})
      : assert(
          builder != null || child != null,
          'Either builder or child must be provided',
        );

  final ValueWidgetBuilder<MechanixThemeData>? builder;

  final Widget? child;

  final MechanixThemeData data;

  static MechanixThemeData of(BuildContext context) => maybeOf(context)!;

  static MechanixThemeData? maybeOf(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<_MechanixInheritedTheme>();
    return theme?.data;
  }

  @override
  State<MechanixTheme> createState() => _MechanixThemeState();
}

class _MechanixThemeState extends State<MechanixTheme> {
  MechanixVariant? _mechanixVariant;

  @override
  void initState() {
    super.initState();
    _mechanixVariant = widget.data.mechanixVariant;
  }

  @override
  void dispose() {
    super.dispose();
  }

  ThemeMode resolveMode() {
    final mode = widget.data.themeMode ?? ThemeMode.system;
    if (mode == ThemeMode.system) {
      return MediaQuery.platformBrightnessOf(context) == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;
    }
    return mode;
  }

  MechanixThemeData resolveData() {
    return widget.data.copyWith(
      mechanixVariant: widget.data.mechanixVariant ?? _mechanixVariant,
      themeMode: resolveMode(),
    );
  }

  ThemeData resolveTheme(MechanixThemeData data) {
    final dark = data.themeMode == ThemeMode.dark;
    final variant = data.mechanixVariant ?? MechanixVariant.blue;
    return (dark ? variant.darkThemeFrom(data) : variant.themeFrom(data))
        .overrideWith(data);
  }

  @override
  Widget build(BuildContext context) {
    final data = resolveData();

    return _MechanixInheritedTheme(
      data: data,
      child: widget.builder?.call(context, data, widget.child) ??
          AnimatedTheme(
            data: resolveTheme(data),
            child: widget.child!,
          ),
    );
  }
}

@immutable
class MechanixThemeData with Diagnosticable {
  const MechanixThemeData({
    this.mechanixVariant,
    this.mechanixBackgroundVariant,
    this.mechanixForegroundVariant,
    this.themeMode = ThemeMode.dark,
    this.extensions,
    this.useMaterial3,
  });

  final MechanixVariant? mechanixVariant;
  final MechanixVariant? mechanixBackgroundVariant;
  final MechanixVariant? mechanixForegroundVariant;

  final ThemeMode? themeMode;

  final Iterable<ThemeExtension<dynamic>>? extensions;

  final bool? useMaterial3;

  Color get backgroundColor {
    return mechanixBackgroundVariant?.color ?? defaultBackgroundColor;
  }

  Color get foregroundColor {
    return mechanixForegroundVariant?.color ?? defaultForegroundColor;
  }

  ThemeData get lightTheme {
    final variant = mechanixVariant ?? MechanixVariant.blue;
    return variant.themeFrom(this).overrideWith(this);
  }

  ThemeData get darkTheme {
    final variant = mechanixVariant ?? MechanixVariant.blue;
    return variant.darkThemeFrom(this).overrideWith(this);
  }

  MechanixThemeData copyWith({
    MechanixVariant? mechanixVariant,
    MechanixVariant? mechanixBackgroundVariant,
    MechanixVariant? mechanixForegroundVariant,
    ThemeMode? themeMode,
    Iterable<ThemeExtension<dynamic>>? extensions,
    bool? useMaterial3,
  }) {
    return MechanixThemeData(
      mechanixVariant: mechanixVariant ?? this.mechanixVariant,
      mechanixBackgroundVariant:
          mechanixBackgroundVariant ?? this.mechanixBackgroundVariant,
      mechanixForegroundVariant:
          mechanixForegroundVariant ?? this.mechanixForegroundVariant,
      themeMode: themeMode ?? this.themeMode,
      extensions: extensions ?? this.extensions,
      useMaterial3: useMaterial3 ?? this.useMaterial3,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<MechanixVariant>(
        'mechanixVariant', mechanixVariant));
    properties.add(DiagnosticsProperty<ThemeMode>('themeMode', themeMode));
    properties.add(DiagnosticsProperty<MechanixVariant>(
        'mechanixBackgroundVariant', mechanixBackgroundVariant));
    properties.add(DiagnosticsProperty<MechanixVariant>(
        'mechanixForegroundVariant', mechanixForegroundVariant));
    properties.add(IterableProperty('extensions', extensions));
    properties.add(DiagnosticsProperty('useMaterial3', useMaterial3));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final iterableEquals = const IterableEquality().equals;
    return other is MechanixThemeData &&
        other.mechanixVariant == mechanixVariant &&
        other.mechanixBackgroundVariant == mechanixBackgroundVariant &&
        other.mechanixForegroundVariant == mechanixForegroundVariant &&
        other.themeMode == themeMode &&
        iterableEquals(other.extensions, extensions) &&
        other.useMaterial3 == useMaterial3;
  }

  @override
  int get hashCode {
    return Object.hash(
      mechanixVariant,
      mechanixBackgroundVariant,
      mechanixForegroundVariant,
      themeMode,
      extensions,
      useMaterial3,
    );
  }
}

class _MechanixInheritedTheme extends InheritedTheme {
  const _MechanixInheritedTheme({required this.data, required super.child});

  final MechanixThemeData? data;

  @override
  bool updateShouldNotify(covariant _MechanixInheritedTheme oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return _MechanixInheritedTheme(data: data, child: child);
  }
}

extension _MechanixThemeData on ThemeData {
  ThemeData overrideWith(MechanixThemeData data) {
    return copyWith(extensions: data.extensions);
  }
}
