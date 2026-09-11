import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixSwitch Widget Tests', () {
    testWidgets('renders MechanixSwitch in OFF and ON states with labels', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Column(
              children: [
                MechanixSwitch(value: false, onChanged: (val) {}),
                MechanixSwitch(value: true, onChanged: (val) {}),
              ],
            ),
          ),
        ),
      );

      expect(find.text('OFF'), findsOneWidget);
      expect(find.text('ON'), findsOneWidget);
    });

    testWidgets('fires onChanged callback when tapped', (
      WidgetTester tester,
    ) async {
      bool currentValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MechanixSwitch(
                  value: currentValue,
                  onChanged: (val) {
                    setState(() {
                      currentValue = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('OFF'), findsOneWidget);

      await tester.tap(find.byType(MechanixSwitch));
      await tester.pumpAndSettle();

      expect(currentValue, isTrue);
      expect(find.text('ON'), findsOneWidget);
    });

    testWidgets('does not toggle when disabled (onChanged is null)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: MechanixSwitch(value: false, onChanged: null)),
        ),
      );

      expect(find.text('OFF'), findsOneWidget);

      await tester.tap(find.byType(MechanixSwitch));
      await tester.pumpAndSettle();

      expect(find.text('OFF'), findsOneWidget);
    });

    testWidgets('swiping right toggles switch from OFF to ON', (
      WidgetTester tester,
    ) async {
      bool currentValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MechanixSwitch(
                  value: currentValue,
                  onChanged: (val) {
                    setState(() {
                      currentValue = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      expect(currentValue, isFalse);
      expect(find.text('OFF'), findsOneWidget);

      await tester.fling(
        find.byType(MechanixSwitch),
        const Offset(60.0, 0.0),
        800.0,
      );
      await tester.pumpAndSettle();

      expect(currentValue, isTrue);
      expect(find.text('ON'), findsOneWidget);
    });

    testWidgets('swiping left toggles switch from ON to OFF', (
      WidgetTester tester,
    ) async {
      bool currentValue = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MechanixSwitch(
                  value: currentValue,
                  onChanged: (val) {
                    setState(() {
                      currentValue = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      expect(currentValue, isTrue);
      expect(find.text('ON'), findsOneWidget);

      await tester.fling(
        find.byType(MechanixSwitch),
        const Offset(-60.0, 0.0),
        800.0,
      );
      await tester.pumpAndSettle();

      expect(currentValue, isFalse);
      expect(find.text('OFF'), findsOneWidget);
    });

    testWidgets('dragging past halfway mark toggles switch from OFF to ON', (
      WidgetTester tester,
    ) async {
      bool currentValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MechanixSwitch(
                  value: currentValue,
                  onChanged: (val) {
                    setState(() {
                      currentValue = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      expect(currentValue, isFalse);

      await tester.drag(find.byType(MechanixSwitch), const Offset(50.0, 0.0));
      await tester.pumpAndSettle();

      expect(currentValue, isTrue);
    });

    testWidgets('dragging less than halfway snaps back without toggling', (
      WidgetTester tester,
    ) async {
      bool currentValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MechanixSwitch(
                  value: currentValue,
                  onChanged: (val) {
                    setState(() {
                      currentValue = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      expect(currentValue, isFalse);

      await tester.drag(find.byType(MechanixSwitch), const Offset(20.0, 0.0));
      await tester.pumpAndSettle();

      expect(currentValue, isFalse);
    });

    testWidgets('does not swipe or drag when disabled', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: MechanixSwitch(value: false, onChanged: null)),
        ),
      );

      await tester.fling(
        find.byType(MechanixSwitch),
        const Offset(60.0, 0.0),
        800.0,
      );
      await tester.pumpAndSettle();

      expect(find.text('OFF'), findsOneWidget);
    });

    testWidgets('has a minimum touch target area of 96x48', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixSwitch(value: false, onChanged: (val) {}),
          ),
        ),
      );

      final renderBox = tester.renderObject<RenderBox>(
        find.byType(MechanixSwitch),
      );
      expect(renderBox.size.width, greaterThanOrEqualTo(96.0));
      expect(renderBox.size.height, greaterThanOrEqualTo(48.0));
    });

    testWidgets('toggles when focused and Space key is pressed', (
      WidgetTester tester,
    ) async {
      bool currentValue = false;
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MechanixSwitch(
                  value: currentValue,
                  focusNode: focusNode,
                  onChanged: (val) {
                    setState(() {
                      currentValue = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      focusNode.requestFocus();
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pumpAndSettle();

      expect(currentValue, isTrue);
    });

    testWidgets('hugs 96x48 dimensions in unconstrained layout', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: MechanixSwitch(value: false, onChanged: (val) {}),
          ),
        ),
      );

      final renderBox = tester.renderObject<RenderBox>(
        find.byType(MechanixSwitch),
      );
      expect(renderBox.size, equals(const Size(96.0, 48.0)));
    });

    testWidgets(
      'renders 96x48 focused border on outer container when focused, without border on visual track',
      (WidgetTester tester) async {
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.light,
            home: Scaffold(
              body: Center(
                child: MechanixSwitch(
                  value: false,
                  focusNode: focusNode,
                  onChanged: (val) {},
                ),
              ),
            ),
          ),
        );

        AnimatedContainer getOuterBox() {
          return tester.widget<AnimatedContainer>(
            find.byWidgetPredicate(
              (w) =>
                  w is AnimatedContainer &&
                  w.constraints?.minWidth == 96.0 &&
                  w.constraints?.minHeight == 48.0,
            ),
          );
        }

        AnimatedContainer getVisualTrack() {
          return tester.widget<AnimatedContainer>(
            find.byWidgetPredicate(
              (w) =>
                  w is AnimatedContainer &&
                  w.constraints?.minWidth == 88.0 &&
                  w.constraints?.minHeight == 40.0,
            ),
          );
        }

        // 1. Unfocused state
        var outerBox = getOuterBox();
        var track = getVisualTrack();
        var outerDecoration = outerBox.decoration as BoxDecoration;
        var trackDecoration = track.decoration as BoxDecoration;

        expect(outerDecoration.border?.top.color, equals(Colors.transparent));
        expect(outerDecoration.border?.top.width, equals(1.0));
        expect(trackDecoration.border, isNull);

        // 2. Focused state
        focusNode.requestFocus();
        await tester.pumpAndSettle();

        outerBox = getOuterBox();
        track = getVisualTrack();
        outerDecoration = outerBox.decoration as BoxDecoration;
        trackDecoration = track.decoration as BoxDecoration;

        expect(
          outerDecoration.border?.top.color,
          equals(MechanixColors.lightColorScheme.outline),
        );

        /// Whether this switch is on or off.
        expect(outerDecoration.border?.top.width, equals(1.0));
        expect(trackDecoration.border, isNull);
      },
    );

    testWidgets('does not show focus border while swiping or tapping', (
      WidgetTester tester,
    ) async {
      bool switchVal = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: StatefulBuilder(
                builder: (context, setState) {
                  return MechanixSwitch(
                    value: switchVal,
                    onChanged: (val) => setState(() => switchVal = val),
                  );
                },
              ),
            ),
          ),
        ),
      );

      AnimatedContainer getOuterBox() {
        return tester.widget<AnimatedContainer>(
          find.byWidgetPredicate(
            (w) =>
                w is AnimatedContainer &&
                w.constraints?.minWidth == 96.0 &&
                w.constraints?.minHeight == 48.0,
          ),
        );
      }

      // 1. Initial state (unfocused) -> border is transparent
      var outerBox = getOuterBox();
      var outerDecoration = outerBox.decoration as BoxDecoration;
      expect(outerDecoration.border?.top.color, equals(Colors.transparent));

      // 2. Tap to toggle -> border remains transparent
      await tester.tap(find.byType(MechanixSwitch));
      await tester.pumpAndSettle();
      expect(switchVal, isTrue);

      outerBox = getOuterBox();
      outerDecoration = outerBox.decoration as BoxDecoration;
      expect(outerDecoration.border?.top.color, equals(Colors.transparent));

      // 3. Swipe to toggle -> border remains transparent
      await tester.fling(
        find.byType(MechanixSwitch),
        const Offset(-60.0, 0.0),
        800.0,
      );
      await tester.pumpAndSettle();
      expect(switchVal, isFalse);

      outerBox = getOuterBox();
      outerDecoration = outerBox.decoration as BoxDecoration;
      expect(outerDecoration.border?.top.color, equals(Colors.transparent));
    });

    testWidgets('does not show focus border when switch is disabled', (
      WidgetTester tester,
    ) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixSwitch(
                value: false,
                focusNode: focusNode,
                onChanged: null,
              ),
            ),
          ),
        ),
      );

      focusNode.requestFocus();
      await tester.pumpAndSettle();

      final outerBox = tester.widget<AnimatedContainer>(
        find.byWidgetPredicate(
          (w) =>
              w is AnimatedContainer &&
              w.constraints?.minWidth == 96.0 &&
              w.constraints?.minHeight == 48.0,
        ),
      );
      final outerDecoration = outerBox.decoration as BoxDecoration;
      expect(outerDecoration.border?.top.color, equals(Colors.transparent));
    });

    testWidgets(
      'respects custom focusBorderColor and focusBorderWidth in theme',
      (WidgetTester tester) async {
        final focusNode = FocusNode();
        const customColor = Color(0xFFFF00FF);
        const customWidth = 4.0;

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.light,
            home: Scaffold(
              body: Center(
                child: MechanixSwitch(
                  value: true,
                  focusNode: focusNode,
                  theme: const SwitchThemeDataConfig(
                    focusBorderColor: WidgetStatePropertyAll(customColor),
                    focusBorderWidth: customWidth,
                  ),
                  onChanged: (val) {},
                ),
              ),
            ),
          ),
        );

        focusNode.requestFocus();
        await tester.pumpAndSettle();

        final outerBox = tester.widget<AnimatedContainer>(
          find.byWidgetPredicate(
            (w) =>
                w is AnimatedContainer &&
                w.constraints?.minWidth == 96.0 &&
                w.constraints?.minHeight == 48.0,
          ),
        );
        final outerDecoration = outerBox.decoration as BoxDecoration;
        expect(outerDecoration.border?.top.color, equals(customColor));
        expect(outerDecoration.border?.top.width, equals(customWidth));
      },
    );

    testWidgets('resolves handleColor and trackColor via WidgetStateProperty', (
      WidgetTester tester,
    ) async {
      const activeColor = Color(0xFF00FF00);
      const customTrack = Color(0xFF112233);

      final theme = SwitchThemeDataConfig(
        trackColor: const WidgetStatePropertyAll(customTrack),
        handleColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return activeColor;
          }
          return const Color(0xFFFF0000);
        }),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixSwitch(
                value: true,
                theme: theme,
                onChanged: (val) {},
              ),
            ),
          ),
        ),
      );

      // The handle is the Container inside AnimatedPositioned.
      final handle = tester.widget<Container>(
        find.descendant(
          of: find.byType(AnimatedPositioned),
          matching: find.byType(Container),
        ),
      );

      final handleDecoration = handle.decoration as BoxDecoration;
      expect(handleDecoration.color, equals(activeColor));

      // The track is the AnimatedContainer with 88x40 dimensions.
      final track = tester.widget<AnimatedContainer>(
        find.byWidgetPredicate(
          (widget) =>
              widget is AnimatedContainer &&
              widget.constraints?.minWidth == 88.0 &&
              widget.constraints?.minHeight == 40.0,
        ),
      );

      final trackDecoration = track.decoration as BoxDecoration;
      expect(trackDecoration.color, equals(customTrack));
    });

    testWidgets(
      'disabled switch sets canRequestFocus to false and skipTraversal to true',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: MechanixSwitch(value: false, onChanged: null)),
          ),
        );

        final focusFinder = find.descendant(
          of: find.byType(MechanixSwitch),
          matching: find.byType(Focus),
        );
        final focusWidget = tester.widget<Focus>(focusFinder.first);
        expect(focusWidget.canRequestFocus, isFalse);
        expect(focusWidget.skipTraversal, isTrue);
      },
    );

    testWidgets(
      'tap with minor finger jitter (<10px drag) still toggles switch',
      (WidgetTester tester) async {
        bool currentValue = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return MechanixSwitch(
                    value: currentValue,
                    onChanged: (val) => setState(() => currentValue = val),
                  );
                },
              ),
            ),
          ),
        );

        // Simulate a tap gesture where the finger moved 5px horizontally
        await tester.drag(find.byType(MechanixSwitch), const Offset(5.0, 0.0));
        await tester.pumpAndSettle();

        expect(currentValue, isTrue);
      },
    );

    testWidgets('renders long labels like CLOSED without overflow', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: MechanixSwitch(
              value: false,
              labelOff: 'CLOSED',
              labelOn: 'OPEN',
              onChanged: (val) {},
            ),
          ),
        ),
      );

      expect(find.text('CLOSED'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('parent rebuild replacing FocusNode does not leak or throw', (
      WidgetTester tester,
    ) async {
      final customNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixSwitch(
              value: false,
              focusNode: null, // initially internal
              onChanged: (val) {},
            ),
          ),
        ),
      );

      // Rebuild with custom focusNode
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixSwitch(
              value: false,
              focusNode: customNode,
              onChanged: (val) {},
            ),
          ),
        ),
      );

      // Rebuild back to null
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixSwitch(
              value: false,
              focusNode: null,
              onChanged: (val) {},
            ),
          ),
        ),
      );

      customNode.dispose();
      expect(tester.takeException(), isNull);
    });

    testWidgets(
      'renders inside height-constrained container without overflow',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                height: 36.0,
                child: MechanixSwitch(value: false, onChanged: (val) {}),
              ),
            ),
          ),
        );

        expect(tester.takeException(), isNull);
        final renderBox = tester.renderObject<RenderBox>(
          find.byType(MechanixSwitch),
        );
        expect(renderBox.size.height, equals(36.0));
      },
    );

    testWidgets(
      'supports MaterialTapTargetSize.shrinkWrap (88x40 dimensions)',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MechanixSwitch(
                value: false,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (val) {},
              ),
            ),
          ),
        );

        final renderBox = tester.renderObject<RenderBox>(
          find.byType(MechanixSwitch),
        );
        expect(renderBox.size, equals(const Size(88.0, 40.0)));
      },
    );
  });

  group('SwitchThemeDataConfig Unit Tests', () {
    test('supports equality and hashCode comparison', () {
      const config1 = SwitchThemeDataConfig(
        trackColor: WidgetStatePropertyAll(Color(0xFF111111)),
        handleColor: WidgetStatePropertyAll(Color(0xFF222222)),
        focusBorderWidth: 3.0,
      );
      const config2 = SwitchThemeDataConfig(
        trackColor: WidgetStatePropertyAll(Color(0xFF111111)),
        handleColor: WidgetStatePropertyAll(Color(0xFF222222)),
        focusBorderWidth: 3.0,
      );
      const config3 = SwitchThemeDataConfig(
        trackColor: WidgetStatePropertyAll(Color(0xFF333333)),
        focusBorderWidth: 4.0,
      );

      expect(config1, equals(config2));
      expect(config1.hashCode, equals(config2.hashCode));
      expect(config1, isNot(equals(config3)));
    });

    test('copyWith properly overrides specified fields', () {
      const original = SwitchThemeDataConfig(
        focusBorderWidth: 3.0,
        trackColor: WidgetStatePropertyAll(Color(0xFF111111)),
      );
      final updated = original.copyWith(focusBorderWidth: 5.0);

      expect(updated.focusBorderWidth, equals(5.0));
      expect(updated.trackColor, equals(original.trackColor));
    });

    test('merge properly overlays new values', () {
      const base = SwitchThemeDataConfig(
        trackColor: WidgetStatePropertyAll(Color(0xFF111111)),
        focusBorderWidth: 3.0,
      );
      const overlay = SwitchThemeDataConfig(
        handleColor: WidgetStatePropertyAll(Color(0xFF222222)),
        focusBorderWidth: 4.0,
      );

      final merged = base.merge(overlay);
      expect(merged.trackColor, equals(base.trackColor));
      expect(merged.handleColor, equals(overlay.handleColor));
      expect(merged.focusBorderWidth, equals(4.0));
    });

    test('lerp interpolates numeric and color properties', () {
      const a = SwitchThemeDataConfig(focusBorderWidth: 2.0);
      const b = SwitchThemeDataConfig(focusBorderWidth: 4.0);

      final lerped = a.lerp(b, 0.5);
      expect(lerped.focusBorderWidth, equals(3.0));
    });
  });
}
