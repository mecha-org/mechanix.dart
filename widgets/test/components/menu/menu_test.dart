import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixMenu Widget Tests', () {
    testWidgets('renders anchor and opens menu when triggered', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: MechanixMenu<String>(
                anchorBuilder: (context, controller, _) {
                  return FilledButton(
                    onPressed: controller.toggle,
                    child: const Text('Open Menu'),
                  );
                },
                entries: const [
                  MechanixMenuItem(value: '1', labelText: 'Item 1'),
                  MechanixMenuItem(value: '2', labelText: 'Item 2'),
                  MechanixMenuDivider(),
                  MechanixMenuItem(value: '3', labelText: 'Item 3'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Open Menu'), findsOneWidget);
      expect(find.text('Item 1'), findsNothing);

      // Tap to open
      await tester.tap(find.text('Open Menu'));
      await tester.pumpAndSettle();

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets(
      'selection callback precedence: onTap -> onSelected -> closeOnSelect',
      (tester) async {
        final events = <String>[];
        final controller = MechanixMenuController();

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: MechanixMenu<String>(
                controller: controller,
                closeOnSelect: true,
                onSelected: (val) {
                  events.add('onSelected: $val');
                },
                anchorBuilder: (context, ctrl, _) {
                  return ElevatedButton(
                    onPressed: ctrl.toggle,
                    child: const Text('Anchor'),
                  );
                },
                entries: [
                  MechanixMenuItem<String>(
                    value: 'save',
                    labelText: 'Save',
                    onTap: () {
                      events.add('onTap');
                    },
                  ),
                ],
              ),
            ),
          ),
        );

        // Open
        await tester.tap(find.text('Anchor'));
        await tester.pumpAndSettle();
        expect(controller.isOpen, isTrue);

        // Select item
        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();

        expect(events, equals(['onTap', 'onSelected: save']));
        expect(controller.isOpen, isFalse);
      },
    );

    testWidgets('disabled items do not fire callbacks and cannot be selected', (
      tester,
    ) async {
      bool tapped = false;
      String? selected;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixMenu<String>(
              onSelected: (val) => selected = val,
              anchorBuilder: (context, controller, _) {
                return ElevatedButton(
                  onPressed: controller.toggle,
                  child: const Text('Anchor'),
                );
              },
              entries: [
                MechanixMenuItem<String>(
                  value: 'disabled_item',
                  labelText: 'Disabled Item',
                  enabled: false,
                  onTap: () => tapped = true,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Anchor'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Disabled Item'));
      await tester.pumpAndSettle();

      expect(tapped, isFalse);
      expect(selected, isNull);
    });

    testWidgets('respects closeOnSelect: false', (tester) async {
      final controller = MechanixMenuController();
      String? selected;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixMenu<String>(
              controller: controller,
              closeOnSelect: false,
              onSelected: (val) => selected = val,
              anchorBuilder: (context, ctrl, _) {
                return ElevatedButton(
                  onPressed: ctrl.toggle,
                  child: const Text('Anchor'),
                );
              },
              entries: const [
                MechanixMenuItem<String>(
                  value: 'keep_open',
                  labelText: 'Keep Open',
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Anchor'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Keep Open'));
      await tester.pumpAndSettle();

      expect(selected, equals('keep_open'));
      expect(controller.isOpen, isTrue);
    });

    testWidgets('enforces >= 48dp touch target on Android', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      try {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: MechanixMenu<String>(
                size: MechanixMenuSize.small,
                anchorBuilder: (context, ctrl, _) {
                  return ElevatedButton(
                    onPressed: ctrl.toggle,
                    child: const Text('Anchor'),
                  );
                },
                entries: const [
                  MechanixMenuItem<String>(value: '1', labelText: 'Small Item'),
                ],
              ),
            ),
          ),
        );

        await tester.tap(find.text('Anchor'));
        await tester.pumpAndSettle();

        final itemFinder = find.text('Small Item');
        expect(itemFinder, findsOneWidget);

        // The ancestor container should be at least 48dp high
        final size = tester.getSize(find.byType(MouseRegion).first);
        expect(size.height, greaterThanOrEqualTo(48.0));
      } finally {
        debugDefaultTargetPlatformOverride = null;
      }
    });

    testWidgets(
      'keyboard navigation: arrow keys skip disabled, enter activates, escape closes',
      (tester) async {
        final controller = MechanixMenuController();
        String? activated;

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: MechanixMenu<String>(
                controller: controller,
                onSelected: (val) => activated = val,
                anchorBuilder: (context, ctrl, _) {
                  return ElevatedButton(
                    onPressed: ctrl.toggle,
                    child: const Text('Anchor'),
                  );
                },
                entries: const [
                  MechanixMenuItem<String>(value: '1', labelText: 'Item 1'),
                  MechanixMenuItem<String>(
                    value: '2',
                    labelText: 'Item 2 Disabled',
                    enabled: false,
                  ),
                  MechanixMenuItem<String>(value: '3', labelText: 'Item 3'),
                ],
              ),
            ),
          ),
        );

        await tester.tap(find.text('Anchor'));
        await tester.pumpAndSettle();
        expect(controller.isOpen, isTrue);

        // Initially on Item 1. Press ArrowDown -> should skip Item 2 and focus Item 3
        await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
        await tester.pumpAndSettle();

        // Press Enter to activate Item 3
        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        await tester.pumpAndSettle();

        expect(activated, equals('3'));
        expect(controller.isOpen, isFalse);
      },
    );

    testWidgets('keyboard navigation: Escape key closes menu', (tester) async {
      final controller = MechanixMenuController();

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixMenu<String>(
              controller: controller,
              anchorBuilder: (context, ctrl, _) {
                return ElevatedButton(
                  onPressed: ctrl.toggle,
                  child: const Text('Anchor'),
                );
              },
              entries: const [
                MechanixMenuItem<String>(value: '1', labelText: 'Item 1'),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Anchor'));
      await tester.pumpAndSettle();
      expect(controller.isOpen, isTrue);

      // Press Escape
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();
      expect(controller.isOpen, isFalse);
    });

    testWidgets('keyboard navigation: typeahead focuses by first character', (
      tester,
    ) async {
      String? selected;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixMenu<String>(
              onSelected: (val) => selected = val,
              anchorBuilder: (context, ctrl, _) {
                return ElevatedButton(
                  onPressed: ctrl.toggle,
                  child: const Text('Anchor'),
                );
              },
              entries: const [
                MechanixMenuItem<String>(value: 'apple', labelText: 'Apple'),
                MechanixMenuItem<String>(value: 'banana', labelText: 'Banana'),
                MechanixMenuItem<String>(value: 'cherry', labelText: 'Cherry'),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Anchor'));
      await tester.pumpAndSettle();

      // Press 'b' to jump to Banana
      await tester.sendKeyDownEvent(LogicalKeyboardKey.keyB, character: 'b');
      await tester.sendKeyUpEvent(LogicalKeyboardKey.keyB);
      await tester.pumpAndSettle();

      // Press Enter to activate
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(selected, equals('banana'));
    });

    testWidgets('renders groups with headers and dividers', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixMenu<String>(
              anchorBuilder: (context, ctrl, _) {
                return ElevatedButton(
                  onPressed: ctrl.toggle,
                  child: const Text('Anchor'),
                );
              },
              entries: const [
                MechanixMenuGroup(
                  headerText: 'GROUP 1',
                  entries: [MechanixMenuItem(value: '1', labelText: 'Item 1')],
                ),
                MechanixMenuGroup(
                  headerText: 'GROUP 2',
                  showDivider: true,
                  entries: [MechanixMenuItem(value: '2', labelText: 'Item 2')],
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Anchor'));
      await tester.pumpAndSettle();

      expect(find.text('GROUP 1'), findsOneWidget);
      expect(find.text('GROUP 2'), findsOneWidget);
      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets('supports RTL layout and custom entries', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: MechanixMenu<String>(
                anchorBuilder: (context, ctrl, _) {
                  return ElevatedButton(
                    onPressed: ctrl.toggle,
                    child: const Text('RTL Anchor'),
                  );
                },
                entries: [
                  const MechanixMenuItem(value: '1', labelText: 'RTL Item'),
                  MechanixMenuCustomEntry(
                    builder: (context) => const Text('Custom RTL Widget'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('RTL Anchor'));
      await tester.pumpAndSettle();

      expect(find.text('RTL Item'), findsOneWidget);
      expect(find.text('Custom RTL Widget'), findsOneWidget);
    });

    testWidgets(
      'does not show keyboard focus highlight on items when opened via pointer',
      (tester) async {
        final controller = MechanixMenuController();

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: MechanixMenu<String>(
                controller: controller,
                anchorBuilder: (context, ctrl, _) {
                  return ElevatedButton(
                    onPressed: ctrl.toggle,
                    child: const Text('Anchor'),
                  );
                },
                entries: const [
                  MechanixMenuItem(value: '1', labelText: 'Item 1'),
                  MechanixMenuItem(value: '2', labelText: 'Item 2'),
                ],
              ),
            ),
          ),
        );

        await tester.tap(find.text('Anchor'));
        await tester.pumpAndSettle();

        expect(controller.isOpen, isTrue);

        // Verify that MenuItemTile widgets do not have focus border
        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.widgetWithText(Semantics, 'Item 1'),
                matching: find.byType(Container),
              )
              .first,
        );
        final decoration = container.decoration as BoxDecoration?;
        expect(decoration?.border, isNull);
      },
    );

    testWidgets('closing menu restores focus back to the previous focus node', (
      tester,
    ) async {
      final controller = MechanixMenuController();
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Column(
              children: [
                TextField(focusNode: focusNode),
                MechanixMenu<String>(
                  controller: controller,
                  anchorBuilder: (context, ctrl, _) {
                    return ElevatedButton(
                      onPressed: ctrl.toggle,
                      child: const Text('Anchor'),
                    );
                  },
                  entries: const [
                    MechanixMenuItem(value: '1', labelText: 'Item 1'),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      // Focus the text field
      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(focusNode.hasFocus, isTrue);

      // Open menu via anchor
      await tester.tap(find.text('Anchor'));
      await tester.pumpAndSettle();
      expect(controller.isOpen, isTrue);

      // Close menu
      controller.close();
      await tester.pumpAndSettle();
      expect(controller.isOpen, isFalse);

      // Previous focus node should have regained focus
      expect(focusNode.hasFocus, isTrue);
      focusNode.dispose();
    });

    testWidgets('updating controller in didUpdateWidget does not throw', (
      tester,
    ) async {
      final controller1 = MechanixMenuController();
      final controller2 = MechanixMenuController();

      Widget buildMenu(MechanixMenuController ctrl) {
        return MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixMenu<String>(
              controller: ctrl,
              anchorBuilder: (context, c, _) {
                return ElevatedButton(
                  onPressed: c.toggle,
                  child: const Text('Anchor'),
                );
              },
              entries: const [
                MechanixMenuItem(value: '1', labelText: 'Item 1'),
              ],
            ),
          ),
        );
      }

      await tester.pumpWidget(buildMenu(controller1));
      expect(controller1.isOpen, isFalse);

      // Rebuilding with a new controller triggers didUpdateWidget and reassigns _effectiveController
      await tester.pumpWidget(buildMenu(controller2));
      expect(tester.takeException(), isNull);

      // Verify the new controller works
      controller2.open();
      await tester.pumpAndSettle();
      expect(controller2.isOpen, isTrue);
      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets(
      'keyboard typeahead with empty entries does not throw modulo-by-zero',
      (tester) async {
        final controller = MechanixMenuController();

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: MechanixMenu<String>(
                controller: controller,
                anchorBuilder: (context, ctrl, _) {
                  return ElevatedButton(
                    onPressed: ctrl.toggle,
                    child: const Text('Anchor'),
                  );
                },
                entries: const [],
              ),
            ),
          ),
        );

        await tester.tap(find.text('Anchor'));
        await tester.pumpAndSettle();
        expect(controller.isOpen, isTrue);

        // Send typeahead character to trigger keyboard helper with empty flattenedItems
        await tester.sendKeyDownEvent(LogicalKeyboardKey.keyA, character: 'a');
        await tester.sendKeyUpEvent(LogicalKeyboardKey.keyA);
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
      },
    );
  });
}
