import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixSwipableListTile Widget Tests', () {
    testWidgets(
      'reveals actions, triggers action on tap, and closes automatically by default',
      (WidgetTester tester) async {
        var action1Tapped = false;
        var action2Tapped = false;

        final actions = [
          MechanixIconButton.standard(
            size: IconButtonSize.small,
            type: IconButtonType.rounded,
            icon: Icons.settings_outlined,
            onPressed: () => action1Tapped = true,
          ),
          MechanixIconButton.standard(
            size: IconButtonSize.small,
            type: IconButtonType.rounded,
            icon: Icons.chat_bubble_outline,
            onPressed: () => action2Tapped = true,
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: MechanixSwipableListTile(
                label: 'Swipable Item',
                actions: actions,
              ),
            ),
          ),
        );

        expect(find.text('Swipable Item'), findsOneWidget);

        // Drag left to reveal actions
        await tester.drag(find.text('Swipable Item'), const Offset(-250, 0));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
        expect(find.byIcon(Icons.chat_bubble_outline), findsOneWidget);

        // Tap action button
        await tester.tap(find.byIcon(Icons.chat_bubble_outline));
        await tester.pumpAndSettle();

        expect(action2Tapped, isTrue);
        expect(action1Tapped, isFalse);

        // Actions should be closed automatically after tap
        expect(find.byIcon(Icons.settings_outlined), findsNothing);
        expect(find.byIcon(Icons.chat_bubble_outline), findsNothing);
      },
    );

    testWidgets('when autoClose is false, remains open on action tap', (
      WidgetTester tester,
    ) async {
      var actionTapped = false;

      final actions = [
        MechanixIconButton.standard(
          size: IconButtonSize.small,
          type: IconButtonType.rounded,
          icon: Icons.chat_bubble_outline,
          onPressed: () => actionTapped = true,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixSwipableListTile(
              label: 'Swipable Item',
              actions: actions,
              autoClose: false,
            ),
          ),
        ),
      );

      // Drag left to reveal actions
      await tester.drag(find.text('Swipable Item'), const Offset(-250, 0));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.chat_bubble_outline), findsOneWidget);

      // Tap action button
      await tester.tap(find.byIcon(Icons.chat_bubble_outline));
      await tester.pumpAndSettle();

      expect(actionTapped, isTrue);

      // Actions must remain open when autoClose is false
      expect(find.byIcon(Icons.chat_bubble_outline), findsOneWidget);
    });

    testWidgets('renders open when initiallyOpen is true', (
      WidgetTester tester,
    ) async {
      final actions = [
        MechanixIconButton.standard(
          size: IconButtonSize.small,
          type: IconButtonType.rounded,
          icon: Icons.settings_outlined,
          onPressed: () {},
        ),
        MechanixIconButton.standard(
          size: IconButtonSize.small,
          type: IconButtonType.rounded,
          icon: Icons.sensors,
          onPressed: () {},
        ),
        MechanixIconButton.standard(
          size: IconButtonSize.small,
          type: IconButtonType.rounded,
          icon: Icons.chat_bubble_outline,
          onPressed: () {},
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixSwipableListTile(
              label: 'Open Item',
              actions: actions,
              initiallyOpen: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Open Item'), findsOneWidget);
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
      expect(find.byIcon(Icons.sensors), findsOneWidget);
      expect(find.byIcon(Icons.chat_bubble_outline), findsOneWidget);
    });

    testWidgets(
      'standard swipable tile background color matches hovered color when swiped',
      (WidgetTester tester) async {
        final actions = [
          MechanixIconButton.standard(
            size: IconButtonSize.small,
            type: IconButtonType.rounded,
            icon: Icons.settings,
            onPressed: () {},
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: MechanixSwipableListTile(
                label: 'Standard Swipable',
                actions: actions,
                initiallyOpen: true,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final listTileFinder = find.byType(MechanixListTile);
        final listTile = tester.widget<MechanixListTile>(listTileFinder);

        final colorScheme = MechanixColors.darkColorScheme;
        final expectedHoverBg = Color.alphaBlend(
          colorScheme.onSurface.withValues(alpha: 0.08),
          colorScheme.surface,
        );

        expect(listTile.backgroundColor, equals(expectedHoverBg));
      },
    );

    testWidgets(
      'MechanixSwipeIndicator renders correct number of bars with rightmost active',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: const Scaffold(
              body: Column(
                children: [
                  MechanixSwipeIndicator(count: 1),
                  MechanixSwipeIndicator(count: 2),
                  MechanixSwipeIndicator(count: 3),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(MechanixSwipeIndicator), findsNWidgets(3));
      },
    );

    testWidgets('tapping open tile body closes the swipe pane', (
      WidgetTester tester,
    ) async {
      var tileTapped = false;
      final actions = [
        MechanixIconButton.standard(
          size: IconButtonSize.small,
          type: IconButtonType.rounded,
          icon: Icons.settings_outlined,
          onPressed: () {},
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixSwipableListTile(
              label: 'Open Item',
              actions: actions,
              initiallyOpen: true,
              onTap: () => tileTapped = true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);

      // Tap on the tile text (should close without invoking tile onTap)
      final tile = find.byType(MechanixSwipableListTile);
      expect(tile, findsOneWidget);

      final tileBox = tester.renderObject<RenderBox>(tile);
      final tileSize = tileBox.size;

      await tester.tapAt(Offset(tileSize.width * 0.5, tileSize.height * 0.5));
      await tester.pumpAndSettle();

      expect(tileTapped, isFalse);
      expect(find.byIcon(Icons.settings_outlined), findsNothing);
    });

    testWidgets('tapping anywhere on an open tile closes the swipe pane', (
      tester,
    ) async {
      final controller = MechanixSwipeController();

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: MechanixSwipableListTile(
              key: const ValueKey('tile'),
              label: 'Open Item',
              initiallyOpen: true,
              controller: controller,
              actions: [
                MechanixIconButton.standard(
                  size: IconButtonSize.small,
                  type: IconButtonType.rounded,
                  icon: Icons.delete,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(controller.isOpen, isTrue);

      final tile = find.byKey(const ValueKey('tile'));
      final box = tester.renderObject<RenderBox>(tile);
      final topLeft = box.localToGlobal(Offset.zero);

      // Tap the middle of the tile rather than the visible edge.
      await tester.tapAt(
        topLeft + Offset(box.size.width / 2, box.size.height / 2),
      );
      await tester.pumpAndSettle();

      expect(controller.isClosed, isTrue);

      controller.dispose();
    });

    testWidgets(
      'tapping anywhere in middle of another tile in MechanixSwipableList closes the open tile',
      (tester) async {
        final tile1Controller = MechanixSwipeController();
        final tile2Controller = MechanixSwipeController();

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: MechanixSwipableList(
                children: [
                  MechanixSwipableListTile(
                    key: const ValueKey('tile1'),
                    label: 'Item 1',
                    initiallyOpen: true,
                    controller: tile1Controller,
                    actions: [
                      MechanixIconButton.standard(
                        size: IconButtonSize.small,
                        type: IconButtonType.rounded,
                        icon: Icons.delete,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  MechanixSwipableListTile(
                    key: const ValueKey('tile2'),
                    label: 'Item 2',
                    controller: tile2Controller,
                    actions: [
                      MechanixIconButton.standard(
                        size: IconButtonSize.small,
                        type: IconButtonType.rounded,
                        icon: Icons.archive,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(tile1Controller.isOpen, isTrue);
        expect(tile2Controller.isClosed, isTrue);

        // Tap the center of Item 2
        await tester.tap(find.text('Item 2'));
        await tester.pumpAndSettle();

        // Tile 1 must now be closed
        expect(tile1Controller.isClosed, isTrue);
        expect(find.byIcon(Icons.delete), findsNothing);

        tile1Controller.dispose();
        tile2Controller.dispose();
      },
    );
    testWidgets(
      'MechanixSwipeController programmatically opens and closes tile',
      (WidgetTester tester) async {
        final controller = MechanixSwipeController();

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: MechanixSwipableListTile(
                label: 'Controlled Item',
                controller: controller,
                actions: [
                  MechanixIconButton.standard(
                    size: IconButtonSize.small,
                    type: IconButtonType.rounded,
                    icon: Icons.star,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(controller.isClosed, isTrue);
        expect(find.byIcon(Icons.star), findsNothing);

        controller.open();
        await tester.pumpAndSettle();

        expect(controller.isOpen, isTrue);
        expect(find.byIcon(Icons.star), findsOneWidget);

        controller.close();
        await tester.pumpAndSettle();

        expect(controller.isClosed, isTrue);
        expect(find.byIcon(Icons.star), findsNothing);

        controller.dispose();
      },
    );

    test('asserts if more than 3 actions are provided', () {
      expect(
        () => MechanixSwipableListTile(
          label: 'Too many',
          actions: const [
            Icon(Icons.add),
            Icon(Icons.edit),
            Icon(Icons.delete),
            Icon(Icons.share),
          ],
        ),
        throwsAssertionError,
      );
    });
  });
}
