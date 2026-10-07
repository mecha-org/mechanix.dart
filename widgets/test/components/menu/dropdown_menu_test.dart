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

    testWidgets(
      'dropdown menu near bottom of screen flips above the field without overflow',
      (tester) async {
        tester.view.physicalSize = const Size(800, 600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: Stack(
                children: [
                  Positioned(
                    left: 50,
                    bottom: 20,
                    width: 300,
                    child: MechanixDropdownMenu<String>(
                      entries: const [
                        MechanixMenuItem(value: '1', labelText: 'Option 1'),
                        MechanixMenuItem(value: '2', labelText: 'Option 2'),
                        MechanixMenuItem(value: '3', labelText: 'Option 3'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        final fieldRect = tester.getRect(find.byType(TextField));

        // Tap text field to open dropdown
        await tester.tap(find.byType(TextField));
        await tester.pumpAndSettle();

        // Menu panel should be open
        final menuFinder = find.byType(SingleChildScrollView);
        expect(menuFinder, findsOneWidget);

        final menuRect = tester.getRect(menuFinder);
        // Popup should be flipped above the text field
        expect(menuRect.bottom, lessThanOrEqualTo(fieldRect.top));
        expect(menuRect.top, greaterThanOrEqualTo(8.0));
        expect(menuRect.left, greaterThanOrEqualTo(8.0));
        expect(menuRect.right, lessThanOrEqualTo(792.0));
      },
    );

    testWidgets('dropdown menu sizes to content width of items by default', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 500,
                child: MechanixDropdownMenu<String>(
                  entries: const [
                    MechanixMenuItem(value: '1', labelText: 'Short'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      final menuRect = tester.getRect(find.byType(SingleChildScrollView));
      // Content is short, so it clamps to minWidth (160) rather than stretching to field width (500)
      expect(menuRect.width, equals(160.0));
    });

    testWidgets('dropdown menu respects custom menuWidth', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 400,
                child: MechanixDropdownMenu<String>(
                  menuWidth: 245.0,
                  entries: const [
                    MechanixMenuItem(value: '1', labelText: 'Option 1'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      final menuRect = tester.getRect(find.byType(SingleChildScrollView));
      expect(menuRect.width, equals(245.0));
    });

    testWidgets('dropdown menu respects matchAnchorWidth: true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 320,
                child: MechanixDropdownMenu<String>(
                  matchAnchorWidth: true,
                  entries: const [
                    MechanixMenuItem(value: '1', labelText: 'Option 1'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      final fieldRect = tester.getRect(find.byType(TextField));
      final menuRect = tester.getRect(find.byType(SingleChildScrollView));
      expect(menuRect.width, equals(fieldRect.width));
      expect(menuRect.width, equals(320.0));
    });
  });
}

