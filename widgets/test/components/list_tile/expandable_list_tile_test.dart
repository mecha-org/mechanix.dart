import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixExpandableListTile Widget Tests', () {
    testWidgets('renders accordion button and toggles expansion on tap', (WidgetTester tester) async {
      bool? expansionState;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixExpandableListTile(
              label: 'Expandable Title',
              leading: const Icon(Icons.star_outline),
              onExpansionChanged: (val) => expansionState = val,
              children: const [
                Text('Expanded Content Item 1'),
                Text('Expanded Content Item 2'),
              ],
            ),
          ),
        ),
      );

      // Accordion button exists
      expect(find.byType(MechanixAccordionButton), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsOneWidget);

      // Initially collapsed: children have 0 height factor
      final align = tester.widget<Align>(
        find.descendant(
          of: find.byType(ClipRect),
          matching: find.byType(Align),
        ),
      );
      expect(align.heightFactor, equals(0.0));

      // Tap header to expand
      await tester.tap(find.text('Expandable Title'));
      await tester.pumpAndSettle();

      expect(expansionState, isTrue);

      // Now expanded
      final expandedAlign = tester.widget<Align>(
        find.descendant(
          of: find.byType(ClipRect),
          matching: find.byType(Align),
        ),
      );
      expect(expandedAlign.heightFactor, equals(1.0));
      expect(find.text('Expanded Content Item 1'), findsOneWidget);

      // Tap accordion button to collapse
      await tester.tap(find.byType(MechanixAccordionButton));
      await tester.pumpAndSettle();

      expect(expansionState, isFalse);
      final collapsedAlign = tester.widget<Align>(
        find.descendant(
          of: find.byType(ClipRect),
          matching: find.byType(Align),
        ),
      );
      expect(collapsedAlign.heightFactor, equals(0.0));
    });

    testWidgets('respects initiallyExpanded property', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MechanixExpandableListTile(
              label: 'Already Expanded',
              initiallyExpanded: true,
              children: [
                Text('Visible child'),
              ],
            ),
          ),
        ),
      );

      final align = tester.widget<Align>(
        find.descendant(
          of: find.byType(ClipRect),
          matching: find.byType(Align),
        ),
      );
      expect(align.heightFactor, equals(1.0));
      expect(find.text('Visible child'), findsOneWidget);
    });
  });
}
