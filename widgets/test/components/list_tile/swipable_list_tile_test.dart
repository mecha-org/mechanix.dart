import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixSwipableListTile Widget Tests', () {
    testWidgets('reveals actions, triggers action on tap, and closes automatically by default', (WidgetTester tester) async {
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
    });

    testWidgets('when autoClose is false, remains open on action tap', (WidgetTester tester) async {
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

    testWidgets('renders open when initiallyOpen is true', (WidgetTester tester) async {
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

    testWidgets('standard swipable tile background color matches hovered color when swiped', (WidgetTester tester) async {
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
    });

    testWidgets('MechanixSwipeIndicator renders correct number of bars with rightmost active', (WidgetTester tester) async {
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
    });

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
