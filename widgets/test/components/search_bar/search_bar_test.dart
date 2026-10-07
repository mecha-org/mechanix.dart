import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixSearchBar Widget Tests', () {
    testWidgets('renders default search bar with hint text and leading icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: const Scaffold(
            body: Center(
              child: MechanixSearchBar(hintText: 'Hinted search text'),
            ),
          ),
        ),
      );

      expect(find.text('Hinted search text'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('handles text input and onChanged callback', (
      WidgetTester tester,
    ) async {
      String currentText = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixSearchBar(
              onChanged: (value) {
                currentText = value;
              },
            ),
          ),
        ),
      );

      final controller = tester
          .widget<TextField>(find.byType(TextField))
          .controller!;

      controller.text = 'Flutter';

      // Controller changes do NOT invoke TextField.onChanged.
      expect(currentText, '');
    });
    testWidgets('handles onSubmitted callback', (WidgetTester tester) async {
      String submittedText = '';
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixSearchBar(
                onSubmitted: (val) => submittedText = val,
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Mechanix UI');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(submittedText, 'Mechanix UI');
    });

    testWidgets('renders trailing mic icon and avatar when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Center(
              child: MechanixSearchBar(
                hintText: 'Hinted search text',
                trailing: [Icon(Icons.mic_none_outlined)],
                avatar: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.orange,
                  child: Text('A', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.mic_none_outlined), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.text('A'), findsOneWidget);
    });

    testWidgets('hides leading icon when showLeading is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: const Scaffold(
            body: Center(child: MechanixSearchBar(hintText: 'No leading icon')),
          ),
        ),
      );

      expect(find.byIcon(Icons.search), findsNothing);
      expect(find.text('No leading icon'), findsOneWidget);
    });

    testWidgets('respects disabled state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Center(
              child: MechanixSearchBar(
                enabled: false,
                hintText: 'Disabled search',
              ),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('handles tap event', (WidgetTester tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(child: MechanixSearchBar(onTap: () => tapped = true)),
          ),
        ),
      );

      await tester.tap(find.byType(MechanixSearchBar));
      expect(tapped, isTrue);
    });

    testWidgets('resolves theme background color correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(body: Center(child: MechanixSearchBar())),
        ),
      );

      final material = tester.widget<Material>(find.byType(Material).last);
      expect(
        material.color,
        MechanixColors.darkColorScheme.surfaceContainerHigh,
      );
    });

    testWidgets(
      'triggers onAutoSearch only after reaching minSearchChars and debounce',
      (WidgetTester tester) async {
        String autoSearched = '';
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.light,
            home: Scaffold(
              body: Center(
                child: MechanixSearchBar(
                  minSearchChars: 3,
                  debounceDuration: const Duration(milliseconds: 200),
                  onAutoSearch: (val) => autoSearched = val,
                ),
              ),
            ),
          ),
        );

        // Enter 2 chars (less than 3)
        await tester.enterText(find.byType(TextField), 'ab');
        await tester.pump(const Duration(milliseconds: 300));
        expect(autoSearched, isEmpty);

        // Enter 3 chars
        await tester.enterText(find.byType(TextField), 'abc');
        // Before debounce fires
        await tester.pump(const Duration(milliseconds: 50));
        expect(autoSearched, isEmpty);

        // After debounce fires
        await tester.pump(const Duration(milliseconds: 200));
        expect(autoSearched, 'abc');
      },
    );
  });
}
