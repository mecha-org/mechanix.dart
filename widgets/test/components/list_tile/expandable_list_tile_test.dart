import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixExpandableListTile Widget Tests', () {
    testWidgets('renders accordion button and toggles expansion on tap', (
      WidgetTester tester,
    ) async {
      bool? expansionState;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixExpandableListTile(
              labelText: 'Expandable Title',
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

    testWidgets('respects initiallyExpanded property', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MechanixExpandableListTile(
              labelText: 'Already Expanded',
              initiallyExpanded: true,
              children: [Text('Visible child')],
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

    testWidgets('supports custom icon widgets (+ when collapsed, - when expanded)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: MechanixExpandableListTile(
              labelText: 'Plus Minus Expandable',
              accordionIcon: Icon(Icons.add_rounded),
              accordionExpandedIcon: Icon(Icons.remove_rounded),
              children: [Text('Child')],
            ),
          ),
        ),
      );

      // Collapsed: shows add icon (+)
      expect(find.byIcon(Icons.add_rounded), findsOneWidget);
      expect(find.byIcon(Icons.remove_rounded), findsNothing);

      // Tap to expand
      await tester.tap(find.text('Plus Minus Expandable'));
      await tester.pumpAndSettle();

      // Expanded: shows remove icon (-)
      expect(find.byIcon(Icons.remove_rounded), findsOneWidget);
      expect(find.byIcon(Icons.add_rounded), findsNothing);
    });

    testWidgets('hides accordion button when showAccordionButton is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: MechanixExpandableListTile(
              labelText: 'No Button Expandable',
              showAccordionButton: false,
              children: [Text('Hidden Button Child')],
            ),
          ),
        ),
      );

      expect(find.byType(MechanixAccordionButton), findsNothing);
      expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsNothing);
      expect(find.byIcon(Icons.add_rounded), findsNothing);

      // Header tap still expands
      await tester.tap(find.text('No Button Expandable'));
      await tester.pumpAndSettle();

      final align = tester.widget<Align>(
        find.descendant(
          of: find.byType(ClipRect),
          matching: find.byType(Align),
        ),
      );
      expect(align.heightFactor, equals(1.0));
      expect(find.text('Hidden Button Child'), findsOneWidget);
    });

    testWidgets('manages background color directly through backgroundColor and expandedBackgroundColor', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: MechanixExpandableListTile(
              labelText: 'Direct Bg Expandable',
              backgroundColor: Colors.red,
              children: [Text('Child')],
            ),
          ),
        ),
      );

      // Initially collapsed: background color is red
      MechanixListTile listTile = tester.widget<MechanixListTile>(
        find.byType(MechanixListTile),
      );
      expect(listTile.backgroundColor, equals(Colors.red));

      // Expand: background color remains red when expandedBackgroundColor is not passed
      await tester.tap(find.text('Direct Bg Expandable'));
      await tester.pumpAndSettle();

      listTile = tester.widget<MechanixListTile>(
        find.byType(MechanixListTile),
      );
      expect(listTile.backgroundColor, equals(Colors.red));
    });

    testWidgets('supports accordionButtonBuilder with isExpanded and toggle callback', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixExpandableListTile(
              labelText: 'Builder Expandable',
              accordionButtonBuilder: (context, isExpanded, toggleExpansion) {
                return IconButton(
                  key: const ValueKey('builder_btn'),
                  icon: Icon(isExpanded ? Icons.close : Icons.expand_more),
                  onPressed: toggleExpansion,
                );
              },
              children: const [Text('Builder Child')],
            ),
          ),
        ),
      );

      // Collapsed: builder receives isExpanded = false
      expect(find.byIcon(Icons.expand_more), findsOneWidget);
      expect(find.byIcon(Icons.close), findsNothing);

      // Tap builder button
      await tester.tap(find.byKey(const ValueKey('builder_btn')));
      await tester.pumpAndSettle();

      // Expanded: builder receives isExpanded = true and displays close icon
      expect(find.byIcon(Icons.close), findsOneWidget);
      expect(find.byIcon(Icons.expand_more), findsNothing);
      expect(find.text('Builder Child'), findsOneWidget);
    });

    testWidgets('passes overlineLabelGap and labelSupportingGap to header MechanixListTile', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: MechanixExpandableListTile(
              labelText: 'Expandable Title',
              overline: 'Expandable Overline',
              supportingText: 'Expandable Supporting',
              overlineLabelGap: 8.0,
              labelSupportingGap: 14.0,
              children: [Text('Child')],
            ),
          ),
        ),
      );

      final listTile = tester.widget<MechanixListTile>(
        find.byType(MechanixListTile),
      );
      expect(listTile.overlineLabelGap, equals(8.0));
      expect(listTile.labelSupportingGap, equals(14.0));
    });
  });
}





