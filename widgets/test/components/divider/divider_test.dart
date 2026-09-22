import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixDivider Theme Tests', () {
    test('MechanixTheme.light and dark configure DividerThemeData correctly', () {
      for (final theme in [MechanixTheme.light, MechanixTheme.dark]) {
        final dividerTheme = theme.dividerTheme;
        final colorScheme = theme.colorScheme;

        expect(dividerTheme.color, colorScheme.outlineVariant);
        expect(dividerTheme.space, 16.0);
        expect(dividerTheme.thickness, 1.0);
        expect(dividerTheme.indent, 0.0);
        expect(dividerTheme.endIndent, 0.0);
      }
    });
  });

  group('MechanixDivider Horizontal Tests', () {
    testWidgets('renders default horizontal divider', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: const Scaffold(
            body: Column(
              children: [
                Text('Above'),
                MechanixDivider(),
                Text('Below'),
              ],
            ),
          ),
        ),
      );

      final dividerFinder = find.byType(Divider);
      expect(dividerFinder, findsOneWidget);

      final divider = tester.widget<Divider>(dividerFinder);
      expect(divider.height, isNull); // Falls back to theme space (16.0)
      expect(divider.thickness, isNull); // Falls back to theme thickness (1.0)
      expect(divider.indent, isNull);
      expect(divider.endIndent, isNull);
      expect(divider.color, isNull);
    });

    testWidgets('renders custom styled horizontal divider', (tester) async {
      const customRadius = BorderRadius.all(Radius.circular(4));
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Column(
              children: [
                MechanixDivider(
                  space: 24,
                  thickness: 2,
                  indent: 12,
                  endIndent: 16,
                  color: Colors.red,
                  radius: customRadius,
                ),
              ],
            ),
          ),
        ),
      );

      final divider = tester.widget<Divider>(find.byType(Divider));
      expect(divider.height, 24.0);
      expect(divider.thickness, 2.0);
      expect(divider.indent, 12.0);
      expect(divider.endIndent, 16.0);
      expect(divider.color, Colors.red);
      expect(divider.radius, customRadius);
    });

    testWidgets('renders inside ListView without overflow', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) => const MechanixDivider(),
              itemBuilder: (_, index) => ListTile(title: Text('Item $index')),
            ),
          ),
        ),
      );

      expect(find.byType(MechanixDivider), findsWidgets);
    });

    testWidgets('respects RTL text direction for insets', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: Column(
                children: [
                  MechanixDivider(indent: 20, endIndent: 10),
                ],
              ),
            ),
          ),
        ),
      );

      final divider = tester.widget<Divider>(find.byType(Divider));
      expect(divider.indent, 20.0);
      expect(divider.endIndent, 10.0);
    });
  });

  group('MechanixDivider Vertical Tests', () {
    testWidgets('MechanixDivider.vertical renders VerticalDivider inside IntrinsicHeight', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: const Scaffold(
            body: IntrinsicHeight(
              child: Row(
                children: [
                  Text('Left'),
                  MechanixDivider.vertical(),
                  Text('Right'),
                ],
              ),
            ),
          ),
        ),
      );

      final verticalDividerFinder = find.byType(VerticalDivider);
      expect(verticalDividerFinder, findsOneWidget);

      final verticalDivider = tester.widget<VerticalDivider>(verticalDividerFinder);
      expect(verticalDivider.width, isNull);
      expect(verticalDivider.thickness, isNull);
    });

    testWidgets('MechanixVerticalDivider alias renders with custom properties', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: SizedBox(
              height: 40,
              child: Row(
                children: [
                  Text('A'),
                  MechanixVerticalDivider(
                    space: 20,
                    thickness: 3,
                    indent: 4,
                    endIndent: 8,
                    color: Colors.blue,
                  ),
                  Text('B'),
                ],
              ),
            ),
          ),
        ),
      );

      final vDivider = tester.widget<VerticalDivider>(find.byType(VerticalDivider));
      expect(vDivider.width, 20.0);
      expect(vDivider.thickness, 3.0);
      expect(vDivider.indent, 4.0);
      expect(vDivider.endIndent, 8.0);
      expect(vDivider.color, Colors.blue);
    });
  });

  group('MechanixDivider Reactivity Tests', () {
    testWidgets('reactively updates color when theme changes', (tester) async {
      var isDark = false;
      late StateSetter stateSetter;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            stateSetter = setState;
            return MaterialApp(
              theme: isDark ? MechanixTheme.dark : MechanixTheme.light,
              home: const Scaffold(
                body: Column(
                  children: [MechanixDivider()],
                ),
              ),
            );
          },
        ),
      );

      // Verify light theme outlineVariant
      var theme = Theme.of(tester.element(find.byType(MechanixDivider)));
      expect(theme.dividerTheme.color, MechanixColors.lightColorScheme.outlineVariant);

      // Toggle to dark theme
      stateSetter(() {
        isDark = true;
      });
      await tester.pumpAndSettle();

      // Verify dark theme outlineVariant
      theme = Theme.of(tester.element(find.byType(MechanixDivider)));
      expect(theme.dividerTheme.color, MechanixColors.darkColorScheme.outlineVariant);
    });
  });

  group('MechanixDivider Constructor Assertions', () {
    test('throws AssertionError on negative values for horizontal divider', () {
      expect(() => MechanixDivider(space: -1), throwsAssertionError);
      expect(() => MechanixDivider(thickness: -1), throwsAssertionError);
      expect(() => MechanixDivider(indent: -1), throwsAssertionError);
      expect(() => MechanixDivider(endIndent: -1), throwsAssertionError);
    });

    test('throws AssertionError on negative values for vertical divider', () {
      expect(() => MechanixDivider.vertical(space: -1), throwsAssertionError);
      expect(() => MechanixDivider.vertical(thickness: -1), throwsAssertionError);
      expect(() => MechanixDivider.vertical(indent: -1), throwsAssertionError);
      expect(() => MechanixDivider.vertical(endIndent: -1), throwsAssertionError);
    });

    test('throws AssertionError on negative values for MechanixVerticalDivider', () {
      expect(() => MechanixVerticalDivider(space: -1), throwsAssertionError);
      expect(() => MechanixVerticalDivider(thickness: -1), throwsAssertionError);
      expect(() => MechanixVerticalDivider(indent: -1), throwsAssertionError);
      expect(() => MechanixVerticalDivider(endIndent: -1), throwsAssertionError);
    });
  });
}
