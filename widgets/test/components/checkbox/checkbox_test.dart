import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixCheckbox Widget Tests', () {
    testWidgets('renders native Checkbox wrapped inside MechanixCheckbox', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixCheckbox(
              value: true,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(MechanixCheckbox), findsOneWidget);
      expect(find.byType(Checkbox), findsOneWidget);
      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, isTrue);
    });

    testWidgets('handles tap events and updates value via onChanged', (
      WidgetTester tester,
    ) async {
      bool? checked = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MechanixCheckbox(
                  value: checked,
                  onChanged: (val) {
                    setState(() {
                      checked = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      expect(checked, isFalse);
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(checked, isTrue);
    });

    testWidgets('respects disabled state when onChanged is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: MechanixCheckbox(
              value: true,
              onChanged: null,
            ),
          ),
        ),
      );

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.onChanged, isNull);
    });

    testWidgets('supports tristate and indeterminate state', (
      WidgetTester tester,
    ) async {
      bool? value;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MechanixCheckbox(
                  tristate: true,
                  value: value,
                  onChanged: (val) {
                    setState(() {
                      value = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.tristate, isTrue);
      expect(checkbox.value, isNull);

      // In Flutter native Checkbox tristate cycle: null -> false -> true -> null
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(value, isFalse);

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(value, isTrue);

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(value, isNull);
    });

    testWidgets('renders label and toggles checkbox when label is tapped', (
      WidgetTester tester,
    ) async {
      bool? checked = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MechanixCheckbox.labeled(
                  value: checked,
                  labelText: 'Accept Terms',
                  onChanged: (val) {
                    setState(() {
                      checked = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Accept Terms'), findsOneWidget);
      expect(find.byType(MergeSemantics), findsOneWidget);

      await tester.tap(find.text('Accept Terms'));
      await tester.pumpAndSettle();
      expect(checked, isTrue);

      // Tapping the checkbox directly toggles without arena conflict
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(checked, isFalse);
    });

    testWidgets('asserts if semanticLabel is provided alongside a visible label', (
      WidgetTester tester,
    ) async {
      expect(
        () => MechanixCheckbox.labeled(
          value: false,
          labelText: 'Visible Label',
          semanticLabel: 'Semantic Label',
          onChanged: (_) {},
        ),
        throwsAssertionError,
      );

      expect(
        () => MechanixCheckbox(
          value: false,
          labelText: 'Visible Label',
          semanticLabel: 'Semantic Label',
          onChanged: (_) {},
        ),
        throwsAssertionError,
      );

      expect(
        () => MechanixCheckbox(
          value: false,
          label: const Text('Custom Label'),
          semanticLabel: 'Semantic Label',
          onChanged: (_) {},
        ),
        throwsAssertionError,
      );
    });

    testWidgets('passes semanticLabel to native Checkbox when no label is present', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixCheckbox(
              value: false,
              semanticLabel: 'Standalone Label',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.semanticLabel, equals('Standalone Label'));
    });

    testWidgets('toggles on keyboard Space press when focused', (
      WidgetTester tester,
    ) async {
      bool? checked = false;
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MechanixCheckbox(
                  focusNode: focusNode,
                  autofocus: true,
                  value: checked,
                  onChanged: (val) {
                    setState(() {
                      checked = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(focusNode.hasFocus, isTrue);

      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pumpAndSettle();
      expect(checked, isTrue);

      focusNode.dispose();
    });

    testWidgets('renders focus ring indicator when focused and enabled', (
      WidgetTester tester,
    ) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixCheckbox(
              focusNode: focusNode,
              showFocusIndicator: true,
              value: false,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(focusNode.hasFocus, isFalse);
      expect(find.byType(MechanixFocusRing), findsNothing);

      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(focusNode.hasFocus, isTrue);
      expect(find.byType(MechanixFocusRing), findsOneWidget);

      focusNode.dispose();
    });

    testWidgets('does not render focus ring when showFocusIndicator is false', (
      WidgetTester tester,
    ) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixCheckbox(
              focusNode: focusNode,
              showFocusIndicator: false,
              value: false,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(focusNode.hasFocus, isTrue);
      expect(find.byType(MechanixFocusRing), findsNothing);

      focusNode.dispose();
    });

    testWidgets('does not allocate internal focus node when showFocusIndicator is false and focusNode is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixCheckbox(
              showFocusIndicator: false,
              value: false,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.focusNode, isNull);
    });

    testWidgets('passes isError correctly to native Checkbox', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixCheckbox(
              isError: true,
              value: true,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.isError, isTrue);
    });

    testWidgets('respects scoped MechanixCheckboxTheme overrides', (
      WidgetTester tester,
    ) async {
      final focusNode = FocusNode();
      const customRingColor = Color(0xFFFF0000);
      const customLabelStyle = TextStyle(fontSize: 18.0, color: Color(0xFF00FF00));

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixCheckboxTheme(
              data: const CheckboxThemeDataConfig(
                focusRingColor: customRingColor,
                focusRingRadius: 25.0,
                labelStyle: customLabelStyle,
              ),
              child: MechanixCheckbox.labeled(
                focusNode: focusNode,
                value: true,
                labelText: 'Themed Label',
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      focusNode.requestFocus();
      await tester.pumpAndSettle();

      final focusRing =
          tester.widget<MechanixFocusRing>(find.byType(MechanixFocusRing));
      expect(focusRing.color, equals(customRingColor));
      expect(focusRing.radius, equals(25.0));

      final text = tester.widget<Text>(find.text('Themed Label'));
      expect(text.style?.fontSize, equals(18.0));

      focusNode.dispose();
    });

    testWidgets('MechanixTheme provides configured CheckboxThemeData', (
      WidgetTester tester,
    ) async {
      late ThemeData theme;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Builder(
            builder: (context) {
              theme = Theme.of(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(theme.checkboxTheme, isNotNull);
      final checkboxTheme = theme.checkboxTheme;

      // Check colors resolve as expected
      final activeColor = checkboxTheme.fillColor?.resolve({WidgetState.selected});
      expect(activeColor, equals(theme.colorScheme.primary));

      final disabledColor = checkboxTheme.fillColor?.resolve({
        WidgetState.selected,
        WidgetState.disabled,
      });
      expect(
        disabledColor,
        equals(theme.colorScheme.onSurface.withValues(alpha: 0.38)),
      );

      final errorColor = checkboxTheme.fillColor?.resolve({
        WidgetState.selected,
        WidgetState.error,
      });
      expect(errorColor, equals(theme.colorScheme.error));

      // Side resolves as expected
      final sideProp = checkboxTheme.side as WidgetStateBorderSide?;
      final restingSide = sideProp?.resolve({});
      expect(restingSide?.color, equals(theme.colorScheme.onSurfaceVariant));
      expect(restingSide?.width, equals(2.0));

      final hoveredSide = sideProp?.resolve({WidgetState.hovered});
      expect(hoveredSide?.color, equals(theme.colorScheme.onSurface));

      final errorSide = sideProp?.resolve({WidgetState.error});
      expect(errorSide?.color, equals(theme.colorScheme.error));
    });

    testWidgets('renders focus ring with default diameter of 48 (radius 24)', (
      WidgetTester tester,
    ) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixCheckbox(
              focusNode: focusNode,
              showFocusIndicator: true,
              value: false,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      focusNode.requestFocus();
      await tester.pumpAndSettle();

      final ring = tester.widget<MechanixFocusRing>(find.byType(MechanixFocusRing));
      expect(ring.radius, equals(24.0));
      expect(ring.diameter, equals(48.0));

      focusNode.dispose();
    });

    testWidgets('maintains consistent layout size between focused and unfocused states (Bug 06)', (
      WidgetTester tester,
    ) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixCheckbox.labeled(
              focusNode: focusNode,
              showFocusIndicator: true,
              value: false,
              labelText: 'Test Label',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      final labelFinder = find.text('Test Label');
      final unfocusedLabelOffset = tester.getTopLeft(labelFinder);
      final unfocusedSize = tester.getSize(find.byType(MechanixCheckbox));

      focusNode.requestFocus();
      await tester.pumpAndSettle();

      final focusedLabelOffset = tester.getTopLeft(labelFinder);
      final focusedSize = tester.getSize(find.byType(MechanixCheckbox));

      // Ensure no layout shift occurs on focus
      expect(focusedLabelOffset.dx, equals(unfocusedLabelOffset.dx));
      expect(focusedSize, equals(unfocusedSize));

      focusNode.dispose();
    });

    testWidgets('MechanixCheckbox.labeled works with custom label widget without labelText (Bug 07)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixCheckbox.labeled(
              value: true,
              label: const Text('Custom Rich Label'),
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Custom Rich Label'), findsOneWidget);

      // Assert that providing neither label nor labelText throws an AssertionError
      expect(
        () => MechanixCheckbox.labeled(
          value: true,
          onChanged: (_) {},
        ),
        throwsAssertionError,
      );
    });
  });
}
