import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixListTile Widget Tests', () {
    testWidgets('renders standard and segmented variants correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Column(
              children: [
                MechanixListTile(
                  key: Key('standard_tile'),
                  label: 'Standard Tile',
                ),
                MechanixListTile.segmented(
                  key: Key('segmented_tile'),
                  label: 'Segmented Tile',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Standard Tile'), findsOneWidget);
      expect(find.text('Segmented Tile'), findsOneWidget);

      final standardTile = tester.widget<MechanixListTile>(
        find.byKey(const Key('standard_tile')),
      );
      final segmentedTile = tester.widget<MechanixListTile>(
        find.byKey(const Key('segmented_tile')),
      );

      expect(standardTile.variant, equals(ListTileVariant.standard));
      expect(segmentedTile.variant, equals(ListTileVariant.segmented));
    });

    testWidgets(
      'renders overline in uppercase and supporting text with ellipsis',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: MechanixListTile(
                label: 'Main Title',
                overline: 'Overline text',
                showOverline: true,
                supportingText: 'Supporting line text, lorem ipsum dolor',
                showSupportingText: true,
              ),
            ),
          ),
        );

        // Overline is rendered uppercase
        expect(find.text('OVERLINE TEXT'), findsOneWidget);
        expect(find.text('Main Title'), findsOneWidget);
        expect(
          find.text('Supporting line text, lorem ipsum dolor'),
          findsOneWidget,
        );

        final supportingTextFinder = find.text(
          'Supporting line text, lorem ipsum dolor',
        );
        final textWidget = tester.widget<Text>(supportingTextFinder);
        expect(textWidget.overflow, equals(TextOverflow.ellipsis));
      },
    );

    testWidgets('renders leading and trailing elements', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixListTile(
              label: 'Tile with icons',
              leading: Icon(Icons.star_outline),
              trailingText: '⌘C',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star_outline), findsOneWidget);
      expect(find.text('⌘C'), findsOneWidget);
    });

    testWidgets(
      'hides leading and trailing when showLeading and showTrailing are false',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: MechanixListTile(
                label: 'Tile without icons',
                leading: Icon(Icons.star_outline),
                showLeading: false,
                trailingText: '⌘C',
                showTrailing: false,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.star_outline), findsNothing);
        expect(find.text('⌘C'), findsNothing);
      },
    );

    testWidgets('handles tap events when enabled and ignores when disabled', (
      WidgetTester tester,
    ) async {
      var taps = 0;
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Column(
              children: [
                MechanixListTile(
                  key: const Key('enabled_tile'),
                  label: 'Enabled',
                  onTap: () => taps++,
                ),
                MechanixListTile(
                  key: const Key('disabled_tile'),
                  label: 'Disabled',
                  enabled: false,
                  onTap: () => taps++,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('enabled_tile')));
      expect(taps, equals(1));

      await tester.tap(find.byKey(const Key('disabled_tile')));
      expect(taps, equals(1));
    });

    testWidgets('respects scoped MechanixListTileTheme configuration', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixListTileTheme(
              data: const ListTileThemeDataConfig(
                gap: 16.0,
                minHeight: 48.0,
                backgroundColor: Colors.purple,
              ),
              child: MechanixListTile(label: 'Themed Tile'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(MechanixListTile),
              matching: find.byType(Container),
            )
            .first,
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.purple));
      expect(container.constraints?.minHeight, equals(48.0));
    });

    testWidgets(
      'resolves ListTileThemeDataConfig from MechanixTheme extension',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(body: MechanixListTile(label: 'Theme Config Tile')),
          ),
        );

        final tileContext = tester.element(find.byType(MechanixListTile));
        final config = Theme.of(tileContext)
            .extension<ListTileThemeDataConfig>();
        expect(config, isNotNull);
        expect(
          config?.focusBorderColor,
          equals(MechanixTheme.darkColorScheme.outline),
        );
        expect(config?.focusBorderWidth, equals(3.0));
        expect(config?.showFocusIndicator, isTrue);
      },
    );

    testWidgets('MechanixSegmentedList separates tiles with default 2px gap', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixSegmentedList(
              gap: 2.0,
              children: [
                MechanixListTile.segmented(label: 'Item 1'),
                MechanixListTile.segmented(label: 'Item 2'),
                MechanixListTile.segmented(label: 'Item 3'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);

      // Between 3 items, there are 2 gap SizedBox widgets with height 2.0
      final sizedBoxes = tester
          .widgetList<SizedBox>(
            find.descendant(
              of: find.byType(MechanixSegmentedList),
              matching: find.byType(SizedBox),
            ),
          )
          .where((sb) => sb.height == 2.0);

      expect(sizedBoxes.length, equals(2));
    });
  });
}
