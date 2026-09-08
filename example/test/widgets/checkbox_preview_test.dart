import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/features/components/checkbox_preview.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('CheckboxPreview Widget Tests', () {
    testWidgets('renders CheckboxPreview header and sections', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: CheckboxPreview(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('Checkboxes'), findsOneWidget);
      expect(
        find.textContaining('Checkboxes allow users to select one or more items'),
        findsOneWidget,
      );

      // Section Titles
      expect(find.text('Interactive Playground'), findsOneWidget);
      expect(
        find.text('Labeled Checkboxes & Selection Lists'),
        findsOneWidget,
      );
    });

    testWidgets('renders playground items and labeled options', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: CheckboxPreview(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Playground items
      expect(find.text('Standard Checkbox'), findsOneWidget);
      expect(find.text('Tristate (Indeterminate)'), findsOneWidget);
      expect(find.text('Error State'), findsOneWidget);
      expect(find.text('Disabled Checked'), findsOneWidget);
      expect(find.text('Disabled Unchecked'), findsOneWidget);

      // Section and items in labeled selection
      expect(find.text('Notification Preferences'), findsOneWidget);
      expect(
        find.text('Push notifications for important account updates'),
        findsOneWidget,
      );
      expect(
        find.text('Weekly digest and system announcements'),
        findsOneWidget,
      );

      // Checkboxes rendered
      expect(find.byType(MechanixCheckbox), findsWidgets);
    });

    testWidgets('playground allows toggling checkboxes and labels', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: CheckboxPreview(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Check labeled checkbox tap
      final termsFinder = find.text('I agree to the Terms of Service and Privacy Policy');
      expect(termsFinder, findsOneWidget);

      await tester.scrollUntilVisible(termsFinder, 500);
      await tester.tap(termsFinder);
      await tester.pumpAndSettle();

      // Tap on standard checkbox in playground
      final standardItem = find.text('Standard Checkbox');
      expect(standardItem, findsOneWidget);
    });
  });
}
