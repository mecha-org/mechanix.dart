import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixTheme Static API', () {
    test(
      'MechanixTheme.light has correct Material 3, color scheme and typography',
      () {
        final theme = MechanixTheme.light;

        expect(theme.useMaterial3, isTrue);
        expect(theme.brightness, equals(Brightness.light));
        expect(theme.colorScheme.brightness, equals(Brightness.light));
        expect(theme.colorScheme, equals(MechanixColors.lightColorScheme));
        expect(theme.colorScheme.primary, equals(const Color(0xFFFF7230)));
        expect(theme.colorScheme.onPrimary, equals(const Color(0xFF050505)));
        expect(theme.colorScheme.surface, equals(const Color(0xFFDBDBDC)));
        expect(theme.colorScheme.onSurface, equals(const Color(0xFF414144)));

        // Check text theme composition
        final textTheme = theme.textTheme;
        expect(textTheme.displayLarge, isNotNull);
        expect(textTheme.displayLarge?.fontFamily, equals(mechanixFontFamily));
        expect(textTheme.displayLarge?.fontSize, equals(52.0));
        expect(textTheme.headlineLarge, isNotNull);
        expect(textTheme.titleLarge, isNotNull);
        expect(textTheme.bodyLarge, isNotNull);
        expect(textTheme.labelLarge, isNotNull);

        // Verify text colors match colorScheme.onSurface
        expect(
          textTheme.displayLarge?.color,
          equals(theme.colorScheme.onSurface),
        );
        expect(textTheme.bodyLarge?.color, equals(theme.colorScheme.onSurface));
        expect(
          textTheme.titleMedium?.color,
          equals(theme.colorScheme.onSurface),
        );
      },
    );

    test(
      'MechanixTheme.dark has correct Material 3, color scheme and typography',
      () {
        final theme = MechanixTheme.dark;

        expect(theme.useMaterial3, isTrue);
        expect(theme.brightness, equals(Brightness.dark));
        expect(theme.colorScheme.brightness, equals(Brightness.dark));
        expect(theme.colorScheme, equals(MechanixColors.darkColorScheme));
        expect(theme.colorScheme.primary, equals(const Color(0xFFF9640D)));
        expect(theme.colorScheme.onPrimary, equals(const Color(0xFFFFFFFF)));
        expect(theme.colorScheme.surface, equals(const Color(0xFF1A1A1B)));
        expect(theme.colorScheme.onSurface, equals(const Color(0xFFF5F5F5)));

        // Check text theme composition
        final textTheme = theme.textTheme;
        expect(textTheme.displayLarge, isNotNull);
        expect(textTheme.displayLarge?.fontFamily, equals(mechanixFontFamily));
        expect(textTheme.displayLarge?.fontSize, equals(52.0));
        expect(textTheme.headlineLarge, isNotNull);
        expect(textTheme.titleLarge, isNotNull);
        expect(textTheme.bodyLarge, isNotNull);
        expect(textTheme.labelLarge, isNotNull);

        // Verify text colors match colorScheme.onSurface
        expect(
          textTheme.displayLarge?.color,
          equals(theme.colorScheme.onSurface),
        );
        expect(textTheme.bodyLarge?.color, equals(theme.colorScheme.onSurface));
        expect(
          textTheme.titleMedium?.color,
          equals(theme.colorScheme.onSurface),
        );
      },
    );

    test('MechanixTheme.createTheme creates theme from custom colorScheme', () {
      const customColorScheme = ColorScheme.light(
        primary: Colors.indigo,
        onSurface: Color(0xFF123456),
      );

      final theme = MechanixTheme.createTheme(colorScheme: customColorScheme);

      expect(theme.useMaterial3, isTrue);
      expect(theme.colorScheme, equals(customColorScheme));
      expect(theme.textTheme.bodyLarge?.color, equals(const Color(0xFF123456)));
    });
  });

  group('Reactive MechanixTheme Widget', () {
    testWidgets(
      'MechanixTheme.of(context) provides MechanixThemeData and reflects changes via builder',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MechanixTheme(
            themeMode: ThemeMode.light,
            builder: (context, theme, child) {
              return MaterialApp(
                theme: theme.light,
                darkTheme: theme.dark,
                themeMode: theme.mode,
                home: Scaffold(
                  body: Builder(
                    builder: (innerContext) {
                      final mechanix = MechanixTheme.of(innerContext);
                      final materialTheme = Theme.of(innerContext);
                      return Column(
                        children: [
                          Text(
                            'Primary: ${materialTheme.colorScheme.primary.toARGB32().toRadixString(16)}',
                          ),
                          Text('Mode: ${mechanix.mode.name}'),
                          ElevatedButton(
                            onPressed: () =>
                                mechanix.setThemeMode(ThemeMode.dark),
                            child: const Text('Go Dark'),
                          ),
                          ElevatedButton(
                            onPressed: () =>
                                mechanix.setThemeMode(ThemeMode.light),
                            child: const Text('Go Light'),
                          ),
                          ElevatedButton(
                            onPressed: () =>
                                mechanix.setAccentColor(Colors.blue),
                            child: const Text('Set Blue Accent'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );

        expect(find.text('Mode: light'), findsOneWidget);
        // Default orange accent in light mode
        expect(find.textContaining('Primary: ffff7230'), findsOneWidget);

        // Tap 'Go Dark'
        await tester.tap(find.text('Go Dark'));
        await tester.pumpAndSettle();

        expect(find.text('Mode: dark'), findsOneWidget);
        // Dark mode default orange
        expect(find.textContaining('Primary: fff9640d'), findsOneWidget);

        // Tap 'Go Light'
        await tester.tap(find.text('Go Light'));
        await tester.pumpAndSettle();

        expect(find.text('Mode: light'), findsOneWidget);
        expect(find.textContaining('Primary: ffff7230'), findsOneWidget);

        // Tap 'Set Blue Accent'
        await tester.tap(find.text('Set Blue Accent'));
        await tester.pumpAndSettle();

        // Accent color is now Colors.blue
        expect(find.textContaining('Primary: ffff7230'), findsNothing);
        expect(find.textContaining('Primary: ff2196f3'), findsOneWidget);
      },
    );

    testWidgets(
      'Direct child usage wraps in AnimatedTheme and provides theme data to descendants',
      (WidgetTester tester) async {
        Color? observedPrimary;
        Brightness? observedBrightness;

        await tester.pumpWidget(
          MaterialApp(
            home: MechanixTheme(
              accentColor: Colors.purple,
              themeMode: ThemeMode.dark,
              child: Scaffold(
                body: Builder(
                  builder: (context) {
                    final data = MechanixTheme.of(context);
                    final theme = Theme.of(context);
                    observedPrimary = theme.colorScheme.primary;
                    observedBrightness = theme.brightness;
                    return Text(
                      'Active: ${data.mode.name}',
                      style: TextStyle(color: theme.colorScheme.primary),
                    );
                  },
                ),
              ),
            ),
          ),
        );

        expect(observedBrightness, equals(Brightness.dark));
        expect(observedPrimary, equals(Colors.purple));
        expect(find.text('Active: dark'), findsOneWidget);
      },
    );

    testWidgets(
      'Declarative property updates on MechanixTheme rebuild descendants',
      (WidgetTester tester) async {
        Widget buildApp({required Color accent, required ThemeMode mode}) {
          return MechanixTheme(
            accentColor: accent,
            themeMode: mode,
            builder: (context, theme, child) {
              return MaterialApp(
                theme: theme.light,
                darkTheme: theme.dark,
                themeMode: theme.mode,
                home: Scaffold(
                  body: Builder(
                    builder: (innerContext) {
                      final currentTheme = Theme.of(innerContext);
                      return Text(
                        'Color: ${currentTheme.colorScheme.primary.toARGB32().toRadixString(16)}',
                      );
                    },
                  ),
                ),
              );
            },
          );
        }

        await tester.pumpWidget(
          buildApp(accent: Colors.teal, mode: ThemeMode.light),
        );
        expect(find.textContaining('ff009688'), findsOneWidget);

        await tester.pumpWidget(
          buildApp(accent: Colors.red, mode: ThemeMode.light),
        );
        await tester.pumpAndSettle();
        expect(find.textContaining('fff44336'), findsOneWidget);
      },
    );

    testWidgets(
      'Multiple MechanixTheme instances are scoped and do not share global mutable state',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Row(
              children: [
                Expanded(
                  child: MechanixTheme(
                    accentColor: Colors.red,
                    themeMode: ThemeMode.light,
                    child: Builder(
                      builder: (context) {
                        final theme = Theme.of(context);
                        return Text(
                          'Left: ${theme.colorScheme.primary.toARGB32().toRadixString(16)}',
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: MechanixTheme(
                    accentColor: Colors.green,
                    themeMode: ThemeMode.light,
                    child: Builder(
                      builder: (context) {
                        final theme = Theme.of(context);
                        return Text(
                          'Right: ${theme.colorScheme.primary.toARGB32().toRadixString(16)}',
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

        // Left is red, Right is green - completely independent
        expect(find.textContaining('Left: fff44336'), findsOneWidget);
        expect(find.textContaining('Right: ff4caf50'), findsOneWidget);
      },
    );

    testWidgets(
      'MechanixTheme.maybeOf returns null when outside MechanixTheme',
      (WidgetTester tester) async {
        MechanixThemeData? data;
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                data = MechanixTheme.maybeOf(context);
                return const SizedBox();
              },
            ),
          ),
        );

        expect(data, isNull);
      },
    );

    testWidgets(
      'Static helper methods MechanixTheme.setThemeMode and setAccentColor update theme',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MechanixTheme(
            themeMode: ThemeMode.light,
            builder: (context, theme, child) {
              return MaterialApp(
                theme: theme.light,
                darkTheme: theme.dark,
                themeMode: theme.mode,
                home: Scaffold(
                  body: Builder(
                    builder: (innerContext) {
                      final data = MechanixTheme.of(innerContext);
                      return Column(
                        children: [
                          Text('Mode: ${data.mode.name}'),
                          Text(
                            'Primary: ${data.colorScheme.primary.toARGB32().toRadixString(16)}',
                          ),
                          ElevatedButton(
                            onPressed: () => MechanixTheme.setThemeMode(
                              innerContext,
                              ThemeMode.dark,
                            ),
                            child: const Text('Toggle Mode'),
                          ),
                          ElevatedButton(
                            onPressed: () => MechanixTheme.setAccentColor(
                              innerContext,
                              Colors.amber,
                            ),
                            child: const Text('Toggle Accent'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );

        expect(find.text('Mode: light'), findsOneWidget);

        await tester.tap(find.text('Toggle Mode'));
        await tester.pumpAndSettle();
        expect(find.text('Mode: dark'), findsOneWidget);

        await tester.tap(find.text('Toggle Accent'));
        await tester.pumpAndSettle();
        expect(find.textContaining('ffffc107'), findsOneWidget);
      },
    );

    testWidgets(
      'ThemeMode.system resolves to dark when platform brightness is dark',
      (WidgetTester tester) async {
        tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;

        await tester.pumpWidget(
          MaterialApp(
            home: MechanixTheme(
              themeMode: ThemeMode.system,
              child: Builder(
                builder: (context) {
                  final data = MechanixTheme.of(context);
                  return Text('Resolved: ${data.activeBrightness.name}');
                },
              ),
            ),
          ),
        );

        expect(find.text('Resolved: dark'), findsOneWidget);

        tester.platformDispatcher.platformBrightnessTestValue =
            Brightness.light;
        await tester.pumpWidget(
          MaterialApp(
            home: MechanixTheme(
              themeMode: ThemeMode.system,
              child: Builder(
                builder: (context) {
                  final data = MechanixTheme.of(context);
                  return Text('Resolved: ${data.activeBrightness.name}');
                },
              ),
            ),
          ),
        );

        expect(find.text('Resolved: light'), findsOneWidget);
        tester.platformDispatcher.clearPlatformBrightnessTestValue();
      },
    );
  });

  group('MechanixColors Dynamic Scheme Generation', () {
    test(
      'createLightColorScheme returns lightColorScheme when accent is null or default',
      () {
        final scheme1 = MechanixColors.createLightColorScheme();
        final scheme2 = MechanixColors.createLightColorScheme(
          accentColor: MechanixColors.defaultAccentColor,
        );

        expect(scheme1, equals(MechanixColors.lightColorScheme));
        expect(scheme2, equals(MechanixColors.lightColorScheme));
      },
    );

    test(
      'createDarkColorScheme returns darkColorScheme when accent is null or default',
      () {
        final scheme1 = MechanixColors.createDarkColorScheme();
        final scheme2 = MechanixColors.createDarkColorScheme(
          accentColor: MechanixColors.defaultAccentColor,
        );

        expect(scheme1, equals(MechanixColors.darkColorScheme));
        expect(scheme2, equals(MechanixColors.darkColorScheme));
      },
    );

    test(
      'createLightColorScheme generates custom accent roles while preserving surfaces',
      () {
        final scheme = MechanixColors.createLightColorScheme(
          accentColor: Colors.cyan,
        );

        expect(scheme.primary, equals(Colors.cyan));
        expect(scheme.surface, equals(MechanixColors.lightColorScheme.surface));
        expect(
          scheme.surfaceContainer,
          equals(MechanixColors.lightColorScheme.surfaceContainer),
        );
        expect(scheme.error, equals(MechanixColors.lightColorScheme.error));
      },
    );

    test(
      'createDarkColorScheme generates custom accent roles while preserving surfaces',
      () {
        final scheme = MechanixColors.createDarkColorScheme(
          accentColor: Colors.cyan,
        );

        expect(scheme.primary, equals(Colors.cyan));
        expect(scheme.surface, equals(MechanixColors.darkColorScheme.surface));
        expect(
          scheme.surfaceContainer,
          equals(MechanixColors.darkColorScheme.surfaceContainer),
        );
        expect(scheme.error, equals(MechanixColors.darkColorScheme.error));
      },
    );
  });
}
