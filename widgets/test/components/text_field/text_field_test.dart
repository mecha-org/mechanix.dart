import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixTextField Widget Tests', () {
    testWidgets('renders filled and outlined text field variants',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Column(
              children: [
                MechanixTextField.filled(
                  labelText: 'Filled Field',
                ),
                MechanixTextField.outlined(
                  labelText: 'Outlined Field',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Filled Field'), findsOneWidget);
      expect(find.text('Outlined Field'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
    });

    testWidgets('renders label, hintText, and supportingText',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: MechanixTextField(
              labelText: 'Username',
              hintText: 'Enter your username',
              supportingText: 'Must be unique',
            ),
          ),
        ),
      );

      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Enter your username'), findsOneWidget);
      expect(find.text('Must be unique'), findsOneWidget);
    });

    testWidgets('renders prefix and suffix icons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: MechanixTextField(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search, key: Key('prefix_search')),
              suffixIcon: Icon(Icons.clear, key: Key('suffix_clear')),
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('prefix_search')), findsOneWidget);
      expect(find.byKey(const Key('suffix_clear')), findsOneWidget);
    });

    testWidgets('displays errorText and enters error state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: MechanixTextField(
              labelText: 'Email',
              errorText: 'Invalid email address',
            ),
          ),
        ),
      );

      expect(find.text('Invalid email address'), findsOneWidget);
    });

    testWidgets('handles disabled state properly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: MechanixTextField(
              labelText: 'Disabled Field',
              enabled: false,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('updates controller text and triggers onChanged',
        (WidgetTester tester) async {
      final controller = TextEditingController();
      String changedValue = '';

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixTextField(
              controller: controller,
              labelText: 'Input',
              onChanged: (val) => changedValue = val,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Hello Mechanix');
      expect(controller.text, 'Hello Mechanix');
      expect(changedValue, 'Hello Mechanix');
    });

    testWidgets('MechanixTextFormField validates correctly within a Form',
        (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  MechanixTextFormField(
                    labelText: 'Required Field',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field cannot be empty';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Trigger validation on empty form
      final isValid = formKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(isValid, isFalse);
      expect(find.text('Field cannot be empty'), findsOneWidget);

      // Enter valid text and re-validate
      await tester.enterText(find.byType(TextField), 'Valid text');
      final isNowValid = formKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(isNowValid, isTrue);
      expect(find.text('Field cannot be empty'), findsNothing);
    });

    testWidgets('respects scoped MechanixTextFieldTheme overrides',
        (WidgetTester tester) async {
      const customFill = Color(0xFF112233);

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: MechanixTextFieldTheme(
              data: TextFieldThemeDataConfig(
                fillColor: const WidgetStatePropertyAll(customFill),
              ),
              child: MechanixTextField.filled(
                labelText: 'Themed Field',
              ),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.decoration?.filled, isTrue);
      final resolvedColor =
          WidgetStateProperty.resolveAs(textField.decoration?.fillColor, <WidgetState>{});
      expect(resolvedColor, customFill);
    });

    testWidgets('respects WidgetStateProperty border overrides', (
      WidgetTester tester,
    ) async {
      const restingBorderColor = Color(0xFF112233);
      const focusedBorderColor = Color(0xFF445566);

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixTextField(
              variant: MechanixTextFieldVariant.outlined,
              theme: TextFieldThemeDataConfig(
                borderColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.focused)) {
                    return focusedBorderColor;
                  }
                  return restingBorderColor;
                }),
              ),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      final border = textField.decoration?.border as WidgetStateInputBorder;

      final restingBorder = border.resolve(<WidgetState>{});
      expect(restingBorder.borderSide.color, restingBorderColor);

      final focusedBorder = border.resolve({WidgetState.focused});
      expect(focusedBorder.borderSide.color, focusedBorderColor);
    });
  });
}

