import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/features/components/text_field_preview.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('TextFieldPreview Widget Tests', () {
    testWidgets('renders TextFieldPreview header and all sections', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1400, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(body: TextFieldPreview()),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('Text Fields'), findsOneWidget);
      expect(
        find.text(
          'Text fields allow users to enter text into a UI. They typically appear in forms and dialogs.',
        ),
        findsOneWidget,
      );

      // Section Titles
      expect(find.text('Interactive Playground'), findsOneWidget);
      expect(find.text('Component State Matrix'), findsOneWidget);
      expect(find.text('Form Integration & Validation'), findsOneWidget);
    });

    testWidgets('renders state matrix with filled and outlined headers', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1400, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(body: TextFieldPreview()),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('Filled Variant (Underline Active Indicator)'),
        findsOneWidget,
      );
      expect(
        find.text('Outlined Variant (4-Sided Outline Border)'),
        findsOneWidget,
      );
      expect(find.text('Default / Resting'), findsNWidgets(2));
      expect(find.text('Focused'), findsNWidgets(2));
      expect(find.text('Hovered'), findsNWidgets(2));
      expect(find.text('Error'), findsNWidgets(2));
      expect(find.text('Disabled'), findsNWidgets(2));
    });

    testWidgets('submits form validation and shows success status', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1400, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(body: TextFieldPreview()),
        ),
      );
      await tester.pumpAndSettle();

      // Submit empty form
      final submitButton = find.text('Submit Form');
      await tester.ensureVisible(submitButton);
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text('Email is required'), findsOneWidget);
      expect(
        find.text('Password must be at least 6 characters'),
        findsOneWidget,
      );

      // Enter valid email and password
      final emailField = find.widgetWithText(
        MechanixTextFormField,
        'Work Email',
      );
      await tester.enterText(emailField, 'test@mechanix.io');

      final passwordField = find.widgetWithText(
        MechanixTextFormField,
        'Password',
      );
      await tester.enterText(passwordField, 'secret123');

      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(
        find.text('Form successfully submitted for test@mechanix.io!'),
        findsOneWidget,
      );
    });
  });
}
