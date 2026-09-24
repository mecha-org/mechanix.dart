import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixFloatingActionButton Tests', () {
    testWidgets('1. Small FAB renders at 56 x 56', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixFloatingActionButton(
                icon: Icons.add,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      final fabFinder = find.byType(MechanixFloatingActionButton);
      expect(fabFinder, findsOneWidget);

      final size = tester.getSize(fabFinder);
      expect(size.width, equals(56.0));
      expect(size.height, equals(56.0));
    });

    testWidgets('2. Medium FAB renders at 80 x 80', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixFloatingActionButton.medium(
                icon: Icons.add,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      final fabFinder = find.byType(MechanixFloatingActionButton);
      expect(fabFinder, findsOneWidget);

      final size = tester.getSize(fabFinder);
      expect(size.width, equals(80.0));
      expect(size.height, equals(80.0));
    });

    testWidgets('3. Large FAB renders at 96 x 96', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixFloatingActionButton.large(
                icon: Icons.add,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      final fabFinder = find.byType(MechanixFloatingActionButton);
      expect(fabFinder, findsOneWidget);

      final size = tester.getSize(fabFinder);
      expect(size.width, equals(96.0));
      expect(size.height, equals(96.0));
    });

    testWidgets('4. Icon is rendered with IconData and Widget', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Column(
              children: [
                MechanixFloatingActionButton(
                  icon: Icons.access_alarm,
                  onPressed: () {},
                ),
                MechanixFloatingActionButton(
                  icon: const Text('FAB'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.access_alarm), findsOneWidget);
      expect(find.text('FAB'), findsOneWidget);

      final iconWidget = tester.widget<Icon>(find.byIcon(Icons.access_alarm));
      expect(iconWidget.size, equals(24.0)); // Small default icon size
    });

    testWidgets('5. onPressed is triggered on tap', (
      WidgetTester tester,
    ) async {
      var pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixFloatingActionButton(
                icon: Icons.touch_app,
                onPressed: () => pressed = true,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(MechanixFloatingActionButton));
      expect(pressed, isTrue);
    });

    testWidgets(
      '6. onPressed: null produces disabled state and ignores gestures',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.light,
            home: const Scaffold(
              body: Center(
                child: MechanixFloatingActionButton(
                  icon: Icons.block,
                  onPressed: null,
                ),
              ),
            ),
          ),
        );

        final fabWidget = tester.widget<MechanixFloatingActionButton>(
          find.byType(MechanixFloatingActionButton),
        );
        expect(fabWidget.isEnabled, isFalse);

        final animatedContainer = tester.widget<AnimatedContainer>(
          find.descendant(
            of: find.byType(MechanixFloatingActionButton),
            matching: find.byType(AnimatedContainer),
          ),
        );
        final decoration = animatedContainer.decoration as BoxDecoration;
        final expectedDisabledBg = MechanixTheme.lightColorScheme.onSurface
            .withValues(alpha: 0.12);
        expect(decoration.color, equals(expectedDisabledBg));

        // Attempt to tap disabled FAB
        await tester.tap(find.byType(MechanixFloatingActionButton));
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      '7. Hover changes to hovered styling and 8. pointer exit returns to enabled',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.light,
            home: Scaffold(
              body: Center(
                child: MechanixFloatingActionButton(
                  icon: Icons.mouse,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        final animatedContainerFinder = find.descendant(
          of: find.byType(MechanixFloatingActionButton),
          matching: find.byType(AnimatedContainer),
        );

        // Initial Enabled Color
        var container = tester.widget<AnimatedContainer>(
          animatedContainerFinder,
        );
        var decoration = container.decoration as BoxDecoration;
        final baseColor = MechanixTheme.lightColorScheme.secondaryContainer;
        expect(decoration.color, equals(baseColor));

        // Pointer enter (hover)
        final gesture = await tester.createGesture(
          kind: PointerDeviceKind.mouse,
        );
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);

        await gesture.moveTo(
          tester.getCenter(find.byType(MechanixFloatingActionButton)),
        );
        await tester.pumpAndSettle();

        container = tester.widget<AnimatedContainer>(animatedContainerFinder);
        decoration = container.decoration as BoxDecoration;
        final expectedHoverColor =
            FloatingActionButtonStyleResolver.applyStateLayer(
              baseColor: baseColor,
              stateLayerColor:
                  MechanixTheme.lightColorScheme.onSecondaryContainer,
              opacity: 0.08,
            );
        expect(decoration.color, equals(expectedHoverColor));

        // Pointer exit
        await gesture.moveTo(const Offset(10, 10));
        await tester.pumpAndSettle();

        container = tester.widget<AnimatedContainer>(animatedContainerFinder);
        decoration = container.decoration as BoxDecoration;
        expect(decoration.color, equals(baseColor));
      },
    );

    testWidgets('9. Press changes to pressed styling for mouse and touch', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixFloatingActionButton(
                icon: Icons.touch_app,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      final animatedContainerFinder = find.descendant(
        of: find.byType(MechanixFloatingActionButton),
        matching: find.byType(AnimatedContainer),
      );

      final baseColor = MechanixTheme.lightColorScheme.secondaryContainer;
      final expectedPressedColor =
          FloatingActionButtonStyleResolver.applyStateLayer(
            baseColor: baseColor,
            stateLayerColor:
                MechanixTheme.lightColorScheme.onSecondaryContainer,
            opacity: 0.12,
          );

      // Mouse Press
      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(MechanixFloatingActionButton)),
      );
      await tester.pump(); // Advance to start press state
      await tester.pump(const Duration(milliseconds: 200)); // Advance animation

      var container = tester.widget<AnimatedContainer>(animatedContainerFinder);
      var decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(expectedPressedColor));

      await gesture.up();
      await tester.pumpAndSettle();

      container = tester.widget<AnimatedContainer>(animatedContainerFinder);
      decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(baseColor));
    });

    testWidgets(
      '10. Keyboard focus works and triggers onPressed on Enter/Space',
      (WidgetTester tester) async {
        var triggered = false;
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.light,
            home: Scaffold(
              body: Center(
                child: MechanixFloatingActionButton(
                  focusNode: focusNode,
                  autofocus: true,
                  icon: Icons.keyboard,
                  onPressed: () => triggered = true,
                ),
              ),
            ),
          ),
        );

        expect(focusNode.hasFocus, isTrue);

        // Trigger activation via enter key
        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        expect(triggered, isTrue);

        triggered = false;
        // Trigger activation via space key
        await tester.sendKeyEvent(LogicalKeyboardKey.space);
        expect(triggered, isTrue);

        focusNode.dispose();
      },
    );

    testWidgets('11. Focus indicator appears when enabled and focused', (
      WidgetTester tester,
    ) async {
      final focusNode = FocusNode();
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixFloatingActionButton(
                focusNode: focusNode,
                icon: Icons.visibility,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      // Initially unfocused: no MechanixFabFocusRing
      expect(find.byType(MechanixFabFocusRing), findsNothing);

      // Focus the FAB
      focusNode.requestFocus();
      await tester.pumpAndSettle();

      // Focus indicator ring should now be present
      expect(find.byType(MechanixFabFocusRing), findsOneWidget);

      focusNode.dispose();
    });

    testWidgets(
      '12. Focus indicator does not appear when showFocusIndicator is false',
      (WidgetTester tester) async {
        final focusNode = FocusNode();
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.light,
            home: Scaffold(
              body: Center(
                child: MechanixFloatingActionButton(
                  focusNode: focusNode,
                  showFocusIndicator: false,
                  icon: Icons.visibility_off,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        focusNode.requestFocus();
        await tester.pumpAndSettle();

        expect(find.byType(MechanixFabFocusRing), findsNothing);

        focusNode.dispose();
      },
    );

    testWidgets(
      '13. Focus ring uses the theme outline color and 14. preserves layout dimensions',
      (WidgetTester tester) async {
        final focusNode = FocusNode();
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: Center(
                child: MechanixFloatingActionButton(
                  focusNode: focusNode,
                  icon: Icons.filter_center_focus,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        final initialSize = tester.getSize(
          find.byType(MechanixFloatingActionButton),
        );
        expect(initialSize.width, equals(56.0));
        expect(initialSize.height, equals(56.0));

        focusNode.requestFocus();
        await tester.pumpAndSettle();

        final focusedSize = tester.getSize(
          find.byType(MechanixFloatingActionButton),
        );
        expect(focusedSize.width, equals(56.0));
        expect(focusedSize.height, equals(56.0));

        // Verify custom painter properties
        final focusRing = tester.widget<MechanixFabFocusRing>(
          find.byType(MechanixFabFocusRing),
        );
        expect(focusRing.color, equals(MechanixTheme.darkColorScheme.outline));
        expect(focusRing.strokeWidth, equals(3.0));

        focusNode.dispose();
      },
    );

    testWidgets(
      '15. Small, medium, and large preserve dimensions across interaction states',
      (WidgetTester tester) async {
        for (final size in MechanixFloatingActionButtonSize.values) {
          final expectedDimension = switch (size) {
            MechanixFloatingActionButtonSize.small => 56.0,
            MechanixFloatingActionButtonSize.medium => 80.0,
            MechanixFloatingActionButtonSize.large => 96.0,
          };

          final focusNode = FocusNode();
          await tester.pumpWidget(
            MaterialApp(
              theme: MechanixTheme.light,
              home: Scaffold(
                body: Center(
                  child: MechanixFloatingActionButton(
                    size: size,
                    focusNode: focusNode,
                    icon: Icons.star,
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          );

          final fabFinder = find.byType(MechanixFloatingActionButton);

          // 1. Default State
          expect(tester.getSize(fabFinder).width, equals(expectedDimension));
          expect(tester.getSize(fabFinder).height, equals(expectedDimension));

          // 2. Hovered State
          final gesture = await tester.createGesture(
            kind: PointerDeviceKind.mouse,
          );
          await gesture.addPointer(location: Offset.zero);
          await gesture.moveTo(tester.getCenter(fabFinder));
          await tester.pumpAndSettle();

          expect(tester.getSize(fabFinder).width, equals(expectedDimension));
          expect(tester.getSize(fabFinder).height, equals(expectedDimension));

          // 3. Focused State
          focusNode.requestFocus();
          await tester.pumpAndSettle();

          expect(tester.getSize(fabFinder).width, equals(expectedDimension));
          expect(tester.getSize(fabFinder).height, equals(expectedDimension));

          await gesture.removePointer();
          focusNode.dispose();
        }
      },
    );

    testWidgets(
      '16. Accessibility semantics expose button, enabled, label, and tooltip',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.light,
            home: Scaffold(
              body: Center(
                child: MechanixFloatingActionButton(
                  icon: Icons.add,
                  tooltip: 'Add item',
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        expect(
          tester.getSemantics(find.byType(MechanixFloatingActionButton)),
          matchesSemantics(
            isButton: true,
            isEnabled: true,
            isFocusable: true,
            hasEnabledState: true,
            label: 'Add item',
            tooltip: 'Add item',
            hasTapAction: true,
            hasFocusAction: true,
          ),
        );
      },
    );

    testWidgets('18. Factory constructors configure correct size variants', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Column(
              children: [
                MechanixFloatingActionButton(icon: Icons.add, onPressed: () {}),
                MechanixFloatingActionButton.medium(
                  icon: Icons.edit,
                  onPressed: () {},
                ),
                MechanixFloatingActionButton.large(
                  icon: Icons.delete,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      final smallFab = tester.widget<MechanixFloatingActionButton>(
        find.byType(MechanixFloatingActionButton).at(0),
      );
      final mediumFab = tester.widget<MechanixFloatingActionButton>(
        find.byType(MechanixFloatingActionButton).at(1),
      );
      final largeFab = tester.widget<MechanixFloatingActionButton>(
        find.byType(MechanixFloatingActionButton).at(2),
      );

      expect(smallFab.size, equals(MechanixFloatingActionButtonSize.small));
      expect(mediumFab.size, equals(MechanixFloatingActionButtonSize.medium));
      expect(largeFab.size, equals(MechanixFloatingActionButtonSize.large));
    });

    testWidgets('19. Custom color overrides are respected', (
      WidgetTester tester,
    ) async {
      const customBg = Color(0xFF123456);
      const customFg = Color(0xFF654321);

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixFloatingActionButton(
                backgroundColor: customBg,
                foregroundColor: customFg,
                icon: Icons.color_lens,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      final animatedContainer = tester.widget<AnimatedContainer>(
        find.descendant(
          of: find.byType(MechanixFloatingActionButton),
          matching: find.byType(AnimatedContainer),
        ),
      );
      final decoration = animatedContainer.decoration as BoxDecoration;
      expect(decoration.color, equals(customBg));

      final iconWidget = tester.widget<Icon>(find.byIcon(Icons.color_lens));
      expect(iconWidget.color, equals(customFg));
    });

    testWidgets(
      '20. Default icon foreground color resolves to colorScheme.primary',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.light,
            home: Scaffold(
              body: Center(
                child: MechanixFloatingActionButton(
                  icon: Icons.star,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        final iconWidget = tester.widget<Icon>(find.byIcon(Icons.star));
        expect(
          iconWidget.color,
          equals(MechanixTheme.lightColorScheme.primary),
        );
      },
    );
  });
}
