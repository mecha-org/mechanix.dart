import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixRadio Widget Tests', () {
    testWidgets('renders native Radio wrapped inside MechanixRadio', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixRadio<int>(
              value: 1,
              groupValue: 1,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(MechanixRadio<int>), findsOneWidget);
      expect(find.byType(Radio<int>), findsOneWidget);
      final radio = tester.widget<Radio<int>>(find.byType(Radio<int>));
      expect(radio.value, equals(1));
      expect(find.byType(RadioGroup<int>), findsOneWidget);
      final radioGroup =
          tester.widget<RadioGroup<int>>(find.byType(RadioGroup<int>));
      expect(radioGroup.groupValue, equals(1));
    });

    testWidgets('handles tap events and updates groupValue via onChanged', (
      WidgetTester tester,
    ) async {
      int? selectedValue = 1;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MechanixRadio<int>(
                  value: 2,
                  groupValue: selectedValue,
                  onChanged: (val) {
                    setState(() {
                      selectedValue = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      expect(selectedValue, equals(1));
      await tester.tap(find.byType(Radio<int>));
      await tester.pumpAndSettle();

      expect(selectedValue, equals(2));
    });

    testWidgets('mutual exclusion in a radio group of multiple radios', (
      WidgetTester tester,
    ) async {
      int? selectedValue = 1;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    MechanixRadio<int>(
                      value: 1,
                      groupValue: selectedValue,
                      onChanged: (v) => setState(() => selectedValue = v),
                    ),
                    MechanixRadio<int>(
                      value: 2,
                      groupValue: selectedValue,
                      onChanged: (v) => setState(() => selectedValue = v),
                    ),
                    MechanixRadio<int>(
                      value: 3,
                      groupValue: selectedValue,
                      onChanged: (v) => setState(() => selectedValue = v),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      expect(selectedValue, equals(1));

      // Tap the second radio
      await tester.tap(find.byType(Radio<int>).at(1));
      await tester.pumpAndSettle();
      expect(selectedValue, equals(2));

      // Tap the third radio
      await tester.tap(find.byType(Radio<int>).at(2));
      await tester.pumpAndSettle();
      expect(selectedValue, equals(3));
    });

    testWidgets('respects disabled state when onChanged is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: MechanixRadio<int>(
              value: 1,
              groupValue: 1,
              onChanged: null,
            ),
          ),
        ),
      );

      final radio = tester.widget<Radio<int>>(find.byType(Radio<int>));
      // ignore: deprecated_member_use
      expect(radio.onChanged, isNull);

      final rawRadio = tester.widget<RawRadio<int>>(find.byType(RawRadio<int>));
      expect(rawRadio.enabled, isFalse);

      // Tapping does nothing
      await tester.tap(find.byType(Radio<int>));
      await tester.pumpAndSettle();
    });

    testWidgets('supports toggleable: true to deselect to null', (
      WidgetTester tester,
    ) async {
      int? selectedValue = 1;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MechanixRadio<int>(
                  value: 1,
                  groupValue: selectedValue,
                  toggleable: true,
                  onChanged: (v) => setState(() => selectedValue = v),
                );
              },
            ),
          ),
        ),
      );

      expect(selectedValue, equals(1));

      // Tap on the already selected radio -> should become null
      await tester.tap(find.byType(Radio<int>));
      await tester.pumpAndSettle();
      expect(selectedValue, isNull);

      // Tap again -> should become 1
      await tester.tap(find.byType(Radio<int>));
      await tester.pumpAndSettle();
      expect(selectedValue, equals(1));
    });

    testWidgets('works seamlessly inside native RadioGroup<T>', (
      WidgetTester tester,
    ) async {
      int? selectedValue = 1;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return RadioGroup<int>(
                  groupValue: selectedValue,
                  onChanged: (v) => setState(() => selectedValue = v),
                  child: const Column(
                    children: [
                      MechanixRadio<int>(value: 1),
                      MechanixRadio<int>(value: 2),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );

      expect(selectedValue, equals(1));

      // Tap second radio
      await tester.tap(find.byType(Radio<int>).last);
      await tester.pumpAndSettle();
      expect(selectedValue, equals(2));
    });

    testWidgets('respects explicit enabled: false inside RadioGroup<T>', (
      WidgetTester tester,
    ) async {
      int? selectedValue = 1;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return RadioGroup<int>(
                  groupValue: selectedValue,
                  onChanged: (v) => setState(() => selectedValue = v),
                  child: const Column(
                    children: [
                      MechanixRadio<int>(value: 1),
                      MechanixRadio<int>(value: 2, enabled: false),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );

      expect(selectedValue, equals(1));

      final rawRadios = tester.widgetList<RawRadio<int>>(find.byType(RawRadio<int>)).toList();
      expect(rawRadios[0].enabled, isTrue);
      expect(rawRadios[1].enabled, isFalse);

      // Tap disabled second radio -> should not change selection
      await tester.tap(find.byType(Radio<int>).last);
      await tester.pumpAndSettle();
      expect(selectedValue, equals(1));
    });

    testWidgets('local groupValue and onChanged shadow ancestor RadioGroup cleanly', (
      WidgetTester tester,
    ) async {
      int? parentSelected = 1;
      int? localSelected = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return RadioGroup<int>(
                  groupValue: parentSelected,
                  onChanged: (v) => setState(() => parentSelected = v),
                  child: Column(
                    children: [
                      const MechanixRadio<int>(value: 1),
                      MechanixRadio<int>.labeled(
                        value: 2,
                        groupValue: localSelected,
                        labelText: 'Local Option',
                        onChanged: (v) => setState(() => localSelected = v),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );

      expect(parentSelected, equals(1));
      expect(localSelected, equals(0));

      // Tap the local labeled radio's circle -> updates localSelected, NOT parentSelected
      await tester.tap(find.byType(Radio<int>).last);
      await tester.pumpAndSettle();

      expect(localSelected, equals(2));
      expect(parentSelected, equals(1));

      // Reset and tap the label text of local radio -> also updates localSelected
      localSelected = 0;
      await tester.pump();
      await tester.tap(find.text('Local Option'));
      await tester.pumpAndSettle();

      expect(localSelected, equals(2));
      expect(parentSelected, equals(1));
    });

    testWidgets('renders label and selects radio when label is tapped', (
      WidgetTester tester,
    ) async {
      int? selectedValue = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MechanixRadio<int>.labeled(
                  value: 1,
                  groupValue: selectedValue,
                  labelText: 'Accept Notifications',
                  onChanged: (val) {
                    setState(() {
                      selectedValue = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Accept Notifications'), findsOneWidget);
      expect(selectedValue, equals(0));

      // Tap the label text directly
      await tester.tap(find.text('Accept Notifications'));
      await tester.pumpAndSettle();
      expect(selectedValue, equals(1));

      // Tapping the radio directly also works cleanly
      await tester.tap(find.byType(Radio<int>));
      await tester.pumpAndSettle();
      expect(selectedValue, equals(1));
    });

    testWidgets('labeled radio preserves radio role and checked state in semantics', (
      WidgetTester tester,
    ) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixRadio<int>.labeled(
              value: 1,
              groupValue: 1,
              labelText: 'Option 1',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      final node = tester.getSemantics(find.byType(MergeSemantics));
      expect(node.hasFlag(SemanticsFlag.hasCheckedState), isTrue);
      expect(node.hasFlag(SemanticsFlag.isChecked), isTrue);
      expect(node.hasFlag(SemanticsFlag.isInMutuallyExclusiveGroup), isTrue);
      expect(node.label, equals('Option 1'));

      handle.dispose();
    });

    testWidgets('label tap requests focus on focusNode', (
      WidgetTester tester,
    ) async {
      final focusNode = FocusNode();
      int? selectedValue = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixRadio<int>.labeled(
              value: 1,
              groupValue: selectedValue,
              focusNode: focusNode,
              labelText: 'Focus Label Test',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(focusNode.hasFocus, isFalse);

      await tester.tap(find.text('Focus Label Test'));
      await tester.pumpAndSettle();

      expect(focusNode.hasFocus, isTrue);
      focusNode.dispose();
    });

    testWidgets('custom rich label inherits disabled and error text style via DefaultTextStyle', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Column(
              children: [
                MechanixRadio<int>.labeled(
                  value: 1,
                  groupValue: 1,
                  onChanged: null,
                  label: Text('Disabled Rich Label'),
                ),
                MechanixRadio<int>.labeled(
                  value: 2,
                  groupValue: 1,
                  isError: true,
                  onChanged: null,
                  label: Text('Error Rich Label'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Disabled Rich Label'), findsOneWidget);
      expect(find.text('Error Rich Label'), findsOneWidget);
    });

    testWidgets('asserts if semanticLabel is provided alongside visible label', (
      WidgetTester tester,
    ) async {
      expect(
        () => MechanixRadio<int>.labeled(
          value: 1,
          groupValue: 1,
          labelText: 'Visible Label',
          semanticLabel: 'Duplicate Label',
          onChanged: (_) {},
        ),
        throwsAssertionError,
      );

      expect(
        () => MechanixRadio<int>(
          value: 1,
          groupValue: 1,
          labelText: 'Visible Label',
          semanticLabel: 'Duplicate Label',
          onChanged: (_) {},
        ),
        throwsAssertionError,
      );

      expect(
        () => MechanixRadio<int>(
          value: 1,
          groupValue: 1,
          label: const Text('Custom Label'),
          semanticLabel: 'Duplicate Label',
          onChanged: (_) {},
        ),
        throwsAssertionError,
      );
    });

    testWidgets('passes semanticLabel to native Radio when no label is present', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixRadio<int>(
              value: 1,
              groupValue: 1,
              semanticLabel: 'Standalone Semantic Radio',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(Semantics), findsWidgets);
    });

    testWidgets('toggles on keyboard Space press when focused', (
      WidgetTester tester,
    ) async {
      final focusNode = FocusNode();
      int? selectedValue = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MechanixRadio<int>(
                  value: 1,
                  groupValue: selectedValue,
                  focusNode: focusNode,
                  onChanged: (val) {
                    setState(() {
                      selectedValue = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      expect(selectedValue, equals(0));

      focusNode.requestFocus();
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pumpAndSettle();

      expect(selectedValue, equals(1));
      focusNode.dispose();
    });

    testWidgets('respects scoped MechanixRadioTheme overrides', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixRadioTheme(
              data: const RadioThemeDataConfig(
                labelSpacing: 16.0,
                labelStyle: TextStyle(fontSize: 18.0),
              ),
              child: MechanixRadio<int>.labeled(
                value: 1,
                groupValue: 1,
                labelText: 'Themed Label',
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Themed Label'));
      expect(text.style?.fontSize, equals(18.0));
    });

    testWidgets('MechanixTheme provides configured RadioThemeData', (
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

      expect(theme.radioTheme, isNotNull);
      final radioTheme = theme.radioTheme;

      // Check colors resolve as expected
      final selectedColor =
          radioTheme.fillColor?.resolve({WidgetState.selected});
      expect(selectedColor, equals(theme.colorScheme.primary));

      final disabledColor = radioTheme.fillColor?.resolve({
        WidgetState.selected,
        WidgetState.disabled,
      });
      expect(
        disabledColor,
        equals(theme.colorScheme.onSurface.withValues(alpha: 0.38)),
      );

      final unselectedColor = radioTheme.fillColor?.resolve({});
      expect(unselectedColor, equals(theme.colorScheme.onSurfaceVariant));

      final hoveredColor = radioTheme.fillColor?.resolve({WidgetState.hovered});
      expect(hoveredColor, equals(theme.colorScheme.onSurface));

      final pressedColor = radioTheme.fillColor?.resolve({WidgetState.pressed});
      expect(pressedColor, equals(theme.colorScheme.onSurface));
    });

    testWidgets('RadioThemeData provides state layer overlays on hover, focus, and press', (
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

      final overlayColor = theme.radioTheme.overlayColor;

      // Normal unselected -> transparent
      expect(overlayColor?.resolve({}), equals(Colors.transparent));

      // Hovered unselected -> 8% onSurface
      expect(
        overlayColor?.resolve({WidgetState.hovered}),
        equals(theme.colorScheme.onSurface.withValues(alpha: 0.08)),
      );

      // Focused selected -> 12% primary
      expect(
        overlayColor?.resolve({WidgetState.selected, WidgetState.focused}),
        equals(theme.colorScheme.primary.withValues(alpha: 0.12)),
      );

      // Pressed selected -> 12% primary
      expect(
        overlayColor?.resolve({WidgetState.selected, WidgetState.pressed}),
        equals(theme.colorScheme.primary.withValues(alpha: 0.12)),
      );
    });

    testWidgets('label tap requests focus when no external focusNode is provided', (
      WidgetTester tester,
    ) async {
      int? selectedValue = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MechanixRadio<int>.labeled(
                  value: 1,
                  groupValue: selectedValue,
                  labelText: 'Implicit Focus Test',
                  onChanged: (val) {
                    setState(() {
                      selectedValue = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      final radioFocusNode =
          Focus.of(tester.element(find.byType(Radio<int>)));
      expect(radioFocusNode.hasFocus, isFalse);

      await tester.tap(find.text('Implicit Focus Test'));
      await tester.pumpAndSettle();

      expect(radioFocusNode.hasFocus, isTrue);
      expect(selectedValue, equals(1));
    });

    test('RadioThemeDataConfig.merge non-destructively merges TextStyle attributes', () {
      const base = RadioThemeDataConfig(
        labelStyle: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
        labelSpacing: 8.0,
      );
      const override = RadioThemeDataConfig(
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
      );

      final merged = base.merge(override);
      expect(merged.labelSpacing, equals(8.0));
      expect(merged.labelStyle?.fontSize, equals(16.0));
      expect(merged.labelStyle?.fontFamily, equals('Roboto'));
      expect(merged.labelStyle?.fontWeight, equals(FontWeight.bold));
    });
  });
}
