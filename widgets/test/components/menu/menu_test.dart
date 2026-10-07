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

  group('MechanixMenu Viewport-Aware Positioning Tests', () {
    testWidgets(
      'shifts left when anchor is near right edge to prevent horizontal overflow',
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
                    right: 0,
                    top: 100,
                    child: MechanixMenu<String>(
                      alignment: MechanixMenuAlignment.start,
                      anchorBuilder: (context, controller, _) {
                        return ElevatedButton(
                          onPressed: controller.toggle,
                          child: const Text('Right Anchor'),
                        );
                      },
                      entries: const [
                        MechanixMenuItem(
                          value: '1',
                          labelText: 'A Long Menu Item Label Text Here',
                        ),
                        MechanixMenuItem(
                          value: '2',
                          labelText: 'Another Long Menu Item Label',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.tap(find.text('Right Anchor'));
        await tester.pumpAndSettle();

        final menuFinder = find.byType(SingleChildScrollView);
        expect(menuFinder, findsOneWidget);

        final menuRect = tester.getRect(menuFinder);
        // The menu must not overflow the right edge of the screen (800 - 8 margin = 792)
        expect(menuRect.right, lessThanOrEqualTo(792.0));
        // And must not overflow the left edge
        expect(menuRect.left, greaterThanOrEqualTo(8.0));
      },
    );

    testWidgets(
      'shifts right when anchor is near left edge with end alignment',
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
                    left: 0,
                    top: 100,
                    child: MechanixMenu<String>(
                      alignment: MechanixMenuAlignment.end,
                      anchorBuilder: (context, controller, _) {
                        return ElevatedButton(
                          onPressed: controller.toggle,
                          child: const Text('Left Anchor'),
                        );
                      },
                      entries: const [
                        MechanixMenuItem(value: '1', labelText: 'Item 1'),
                        MechanixMenuItem(value: '2', labelText: 'Item 2'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.tap(find.text('Left Anchor'));
        await tester.pumpAndSettle();

        final menuFinder = find.byType(SingleChildScrollView);
        expect(menuFinder, findsOneWidget);

        final menuRect = tester.getRect(menuFinder);
        // The menu must not overflow left (< 8.0)
        expect(menuRect.left, greaterThanOrEqualTo(8.0));
        expect(menuRect.right, lessThanOrEqualTo(792.0));
      },
    );

    testWidgets(
      'repositions above anchor when bottom edge overflows and space exists above',
      (tester) async {
        tester.view.physicalSize = const Size(800, 600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final controller = MechanixMenuController();

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: Stack(
                children: [
                  Positioned(
                    left: 200,
                    bottom: 20,
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: MechanixMenu<String>(
                        controller: controller,
                        offset: const Offset(0, 4),
                        anchorBuilder: (context, ctrl, _) {
                          return ElevatedButton(
                            onPressed: ctrl.toggle,
                            child: const Text('Bottom Anchor'),
                          );
                        },
                        entries: const [
                          MechanixMenuItem(value: '1', labelText: 'Item 1'),
                          MechanixMenuItem(value: '2', labelText: 'Item 2'),
                          MechanixMenuItem(value: '3', labelText: 'Item 3'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        final anchorRect = tester.getRect(find.byType(ElevatedButton));

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        final menuFinder = find.byType(SingleChildScrollView);
        expect(menuFinder, findsOneWidget);

        final menuRect = tester.getRect(menuFinder);

        // Must be positioned ABOVE the anchor
        expect(menuRect.bottom, lessThanOrEqualTo(anchorRect.top));
        // Bottom of the menu should be placed adjacent to anchor top with offset.dy (4.0)
        expect(menuRect.bottom, closeTo(anchorRect.top - 4.0, 1.0));
        // Must not bleed outside top of screen
        expect(menuRect.top, greaterThanOrEqualTo(8.0));
      },
    );

    testWidgets(
      'stays below anchor when there is sufficient space below',
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
                    left: 200,
                    top: 20,
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: MechanixMenu<String>(
                        offset: const Offset(0, 4),
                        anchorBuilder: (context, ctrl, _) {
                          return ElevatedButton(
                            onPressed: ctrl.toggle,
                            child: const Text('Top Anchor'),
                          );
                        },
                        entries: const [
                          MechanixMenuItem(value: '1', labelText: 'Item 1'),
                          MechanixMenuItem(value: '2', labelText: 'Item 2'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        final anchorRect = tester.getRect(find.byType(ElevatedButton));

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        final menuFinder = find.byType(SingleChildScrollView);
        final menuRect = tester.getRect(menuFinder);

        // Must be positioned BELOW the anchor
        expect(menuRect.top, closeTo(anchorRect.bottom + 4.0, 1.0));
        expect(menuRect.bottom, lessThanOrEqualTo(592.0));
      },
    );

    testWidgets(
      'preserves exact alignment and offset when ample space exists in center',
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
                    left: 300,
                    top: 250,
                    child: SizedBox(
                      width: 150,
                      height: 40,
                      child: MechanixMenu<String>(
                        alignment: MechanixMenuAlignment.start,
                        offset: const Offset(10, 6),
                        anchorBuilder: (context, ctrl, _) {
                          return ElevatedButton(
                            onPressed: ctrl.toggle,
                            child: const Text('Center Anchor'),
                          );
                        },
                        entries: const [
                          MechanixMenuItem(value: '1', labelText: 'Item 1'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        final anchorRect = tester.getRect(find.byType(ElevatedButton));

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        final menuFinder = find.byType(SingleChildScrollView);
        final menuRect = tester.getRect(menuFinder);

        // In LTR start alignment, left should match anchor.left + offset.dx
        expect(menuRect.left, closeTo(anchorRect.left + 10.0, 0.5));
        // Top should match anchor.bottom + offset.dy
        expect(menuRect.top, closeTo(anchorRect.bottom + 6.0, 0.5));
      },
    );

    testWidgets(
      'constrains very large menu to available viewport height and enables scrolling',
      (tester) async {
        tester.view.physicalSize = const Size(600, 400);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final entries = List.generate(
          40,
          (i) => MechanixMenuItem(value: '$i', labelText: 'Item $i'),
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: Stack(
                children: [
                  Positioned(
                    left: 100,
                    top: 150,
                    child: MechanixMenu<String>(
                      maxHeight: 1000.0,
                      anchorBuilder: (context, ctrl, _) {
                        return ElevatedButton(
                          onPressed: ctrl.toggle,
                          child: const Text('Large Menu Anchor'),
                        );
                      },
                      entries: entries,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.tap(find.text('Large Menu Anchor'));
        await tester.pumpAndSettle();

        final menuFinder = find.byType(SingleChildScrollView);
        expect(menuFinder, findsOneWidget);

        final menuRect = tester.getRect(menuFinder);

        // Total height must fit inside the 400px viewport (leaving 8px margin)
        expect(menuRect.top, greaterThanOrEqualTo(8.0));
        expect(menuRect.bottom, lessThanOrEqualTo(392.0));
        expect(menuRect.height, lessThanOrEqualTo(400.0));
      },
    );

    testWidgets(
      'accounts for MediaQuery viewInsets (e.g. keyboard) by repositioning menu',
      (tester) async {
        tester.view.physicalSize = const Size(800, 600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
          tester.view.resetViewInsets();
        });

        final controller = MechanixMenuController();

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: Stack(
                children: [
                  Positioned(
                    left: 200,
                    top: 250,
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: MechanixMenu<String>(
                        controller: controller,
                        offset: const Offset(0, 4),
                        anchorBuilder: (context, ctrl, _) {
                          return ElevatedButton(
                            onPressed: ctrl.toggle,
                            child: const Text('Keyboard Anchor'),
                          );
                        },
                        entries: const [
                          MechanixMenuItem(value: '1', labelText: 'Item 1'),
                          MechanixMenuItem(value: '2', labelText: 'Item 2'),
                          MechanixMenuItem(value: '3', labelText: 'Item 3'),
                          MechanixMenuItem(value: '4', labelText: 'Item 4'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        // Open menu initially with no keyboard
        await tester.tap(find.text('Keyboard Anchor'));
        await tester.pumpAndSettle();

        final initialRect = tester.getRect(find.byType(SingleChildScrollView));
        // Initially positioned below anchor (top > 250 + 40)
        expect(initialRect.top, greaterThanOrEqualTo(290.0));

        // Close menu, simulate keyboard appearing with 300px viewInsets bottom
        controller.close();
        await tester.pumpAndSettle();

        tester.view.viewInsets = const FakeViewPadding(bottom: 300);
        await tester.pumpAndSettle();

        // Open menu with keyboard up
        controller.open();
        await tester.pumpAndSettle();

        final keyboardAwareRect = tester.getRect(
          find.byType(SingleChildScrollView),
        );
        // Usable bottom is 600 - 300 - 8 = 292
        // Anchor is at top: 250, bottom: 290. Space below is < 2px.
        // So menu MUST flip above the anchor!
        expect(keyboardAwareRect.bottom, lessThanOrEqualTo(250.0));
        expect(keyboardAwareRect.top, greaterThanOrEqualTo(8.0));
      },
    );

    testWidgets(
      'small 1-item menu when flipped above has zero gap and is adjacent to anchor',
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
                    left: 200,
                    bottom: 10,
                    child: SizedBox(
                      width: 120,
                      height: 40,
                      child: MechanixMenu<String>(
                        offset: const Offset(0, 4),
                        anchorBuilder: (context, ctrl, _) {
                          return ElevatedButton(
                            onPressed: ctrl.toggle,
                            child: const Text('Small Anchor'),
                          );
                        },
                        entries: const [
                          MechanixMenuItem(
                            value: '1',
                            labelText: 'Single Item',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        final anchorRect = tester.getRect(find.byType(ElevatedButton));

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        final menuFinder = find.byType(SingleChildScrollView);
        final menuRect = tester.getRect(menuFinder);

        // Menu is positioned above anchor
        expect(menuRect.bottom, lessThanOrEqualTo(anchorRect.top));
        // Gap between menu bottom and anchor top is EXACTLY offset.dy (4.0)
        expect(anchorRect.top - menuRect.bottom, closeTo(4.0, 1.0));
      },
    );

    testWidgets(
      'adapts to new window size when window is resized',
      (tester) async {
        tester.view.physicalSize = const Size(800, 600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final controller = MechanixMenuController();

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: Stack(
                children: [
                  Positioned(
                    right: 20,
                    top: 100,
                    child: MechanixMenu<String>(
                      controller: controller,
                      alignment: MechanixMenuAlignment.start,
                      anchorBuilder: (context, ctrl, _) {
                        return ElevatedButton(
                          onPressed: ctrl.toggle,
                          child: const Text('Resize Anchor'),
                        );
                      },
                      entries: const [
                        MechanixMenuItem(
                          value: '1',
                          labelText: 'Menu Item Content',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        final initialMenuRect = tester.getRect(
          find.byType(SingleChildScrollView),
        );
        expect(initialMenuRect.right, lessThanOrEqualTo(792.0));

        // Resize window narrower: from 800 to 400
        tester.view.physicalSize = const Size(400, 600);
        await tester.pumpAndSettle();

        // In Flutter, RawMenuAnchor closes on view metrics change.
        // Reopen on the resized window to verify placement adapts within the 400px bounds.
        controller.open();
        await tester.pumpAndSettle();

        final resizedMenuRect = tester.getRect(
          find.byType(SingleChildScrollView),
        );
        expect(resizedMenuRect.right, lessThanOrEqualTo(392.0));
        expect(resizedMenuRect.left, greaterThanOrEqualTo(8.0));
      },
    );

    testWidgets(
      'respects system safe area padding (e.g. status bar notch and side inset)',
      (tester) async {
        tester.view.physicalSize = const Size(800, 600);
        tester.view.devicePixelRatio = 1.0;
        tester.view.padding = const FakeViewPadding(top: 50, right: 40);
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
          tester.view.resetPadding();
        });

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: 0,
                    child: MechanixMenu<String>(
                      anchorBuilder: (context, ctrl, _) {
                        return ElevatedButton(
                          onPressed: ctrl.toggle,
                          child: const Text('Notch Anchor'),
                        );
                      },
                      entries: const [
                        MechanixMenuItem(value: '1', labelText: 'Safe Item'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        final menuRect = tester.getRect(find.byType(SingleChildScrollView));
        // Usable top must respect padding.top (50) + screen margin (8) = 58
        expect(menuRect.top, greaterThanOrEqualTo(58.0));
        // Usable right must respect padding.right (40) + screen margin (8) = 800 - 48 = 752
        expect(menuRect.right, lessThanOrEqualTo(752.0));
      },
    );

    testWidgets(
      'matchAnchorWidth near right edge clamps properly to viewport',
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
                    right: 0,
                    top: 100,
                    width: 250,
                    child: MechanixMenu<String>(
                      matchAnchorWidth: true,
                      anchorBuilder: (context, ctrl, _) {
                        return ElevatedButton(
                          onPressed: ctrl.toggle,
                          child: const Text('Match Width Anchor'),
                        );
                      },
                      entries: const [
                        MechanixMenuItem(value: '1', labelText: 'Item 1'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        final menuRect = tester.getRect(find.byType(SingleChildScrollView));
        // Right should not exceed viewport right (792)
        expect(menuRect.right, lessThanOrEqualTo(792.0));
        expect(menuRect.left, greaterThanOrEqualTo(8.0));
      },
    );

    testWidgets(
      'menu width hugs item content width clamped between minWidth and maxWidth',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: Center(
                child: MechanixMenu<String>(
                  anchorBuilder: (context, ctrl, _) => ElevatedButton(
                    onPressed: ctrl.toggle,
                    child: const Text('Open'),
                  ),
                  entries: const [
                    MechanixMenuItem(
                      value: '1',
                      labelText: 'Medium length label',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        final menuRect = tester.getRect(find.byType(SingleChildScrollView));
        expect(menuRect.width, greaterThan(160.0));
        expect(menuRect.width, lessThan(360.0));
      },
    );

    testWidgets('menu respects explicit width parameter', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: MechanixMenu<String>(
                width: 275.0,
                anchorBuilder: (context, ctrl, _) => ElevatedButton(
                  onPressed: ctrl.toggle,
                  child: const Text('Open'),
                ),
                entries: const [
                  MechanixMenuItem(value: '1', labelText: 'Item 1'),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      final menuRect = tester.getRect(find.byType(SingleChildScrollView));
      expect(menuRect.width, equals(275.0));
    });

    testWidgets('menu respects custom minWidth and maxWidth parameters', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: MechanixMenu<String>(
                minWidth: 200.0,
                maxWidth: 400.0,
                anchorBuilder: (context, ctrl, _) => ElevatedButton(
                  onPressed: ctrl.toggle,
                  child: const Text('Open'),
                ),
                entries: const [
                  MechanixMenuItem(value: '1', labelText: 'Short'),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      final menuRect = tester.getRect(find.byType(SingleChildScrollView));
      expect(menuRect.width, equals(200.0));
    });
  });
}


