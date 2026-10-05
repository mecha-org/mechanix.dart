import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixDropdownMenu Widget Tests', () {
    testWidgets('renders dropdown with labelText, hintText, and leadingIcon', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Center(
              child: MechanixDropdownMenu<String>(
                labelText: 'LANGUAGE',
                hintText: 'Select language',
                leadingIcon: Icons.search_rounded,
                entries: [
                  MechanixMenuItem(value: 'dart', labelText: 'Dart'),
                  MechanixMenuItem(value: 'rust', labelText: 'Rust'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('LANGUAGE'), findsOneWidget);
      expect(find.text('Select language'), findsOneWidget);
      expect(find.byIcon(Icons.search_rounded), findsOneWidget);
    });

    testWidgets('initial selectedValue displays matching label in field', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Center(
              child: MechanixDropdownMenu<String>(
                selectedValue: 'rust',
                entries: [
                  MechanixMenuItem(value: 'dart', labelText: 'Dart'),
                  MechanixMenuItem(value: 'rust', labelText: 'Rust'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Rust'), findsOneWidget);
    });

    testWidgets('typing filters the entries list and shows matching results', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Center(
              child: MechanixDropdownMenu<String>(
                entries: [
                  MechanixMenuItem(value: 'apple', labelText: 'Apple'),
                  MechanixMenuItem(value: 'banana', labelText: 'Banana'),
                  MechanixMenuItem(value: 'cherry', labelText: 'Cherry'),
                ],
              ),
            ),
          ),
        ),
      );

      // Enter 'ban' in the text field
      await tester.enterText(find.byType(TextField), 'ban');
      await tester.pumpAndSettle();

      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('Apple'), findsNothing);
      expect(find.text('Cherry'), findsNothing);
    });

    testWidgets('shows empty state when no items match the filter', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Center(
              child: MechanixDropdownMenu<String>(
                emptyStateMessage: 'Nothing matches',
                entries: [MechanixMenuItem(value: 'apple', labelText: 'Apple')],
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'xyz');
      await tester.pumpAndSettle();

      expect(find.text('Nothing matches'), findsOneWidget);
    });

    testWidgets(
      'clear button clears input text and notifies onSelected with null',
      (tester) async {
        String? selectedValue = 'dart';

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: Center(
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return MechanixDropdownMenu<String>(
                      selectedValue: selectedValue,
                      onSelected: (val) {
                        setState(() => selectedValue = val);
                      },
                      entries: const [
                        MechanixMenuItem(value: 'dart', labelText: 'Dart'),
                        MechanixMenuItem(value: 'rust', labelText: 'Rust'),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );

        expect(find.text('Dart'), findsOneWidget);

        // Tap the clear button
        final clearButton = find.byIcon(Icons.close_rounded);
        expect(clearButton, findsOneWidget);

        await tester.tap(clearButton);
        await tester.pumpAndSettle();

        expect(selectedValue, isNull);
        expect(find.text('Dart'), findsNothing);
      },
    );

    testWidgets('selecting an item updates field and calls onSelected', (
      tester,
    ) async {
      String? selected;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: MechanixDropdownMenu<String>(
                onSelected: (val) => selected = val,
                entries: const [
                  MechanixMenuItem(value: 'opt1', labelText: 'Option 1'),
                  MechanixMenuItem(value: 'opt2', labelText: 'Option 2'),
                ],
              ),
            ),
          ),
        ),
      );

      // Tap text field to open menu
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      // Tap Option 2
      await tester.tap(find.text('Option 2'));
      await tester.pumpAndSettle();

      expect(selected, equals('opt2'));
      expect(find.text('Option 2'), findsOneWidget);
    });
  });
}
