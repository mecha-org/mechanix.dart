import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixBadge Theme Tests', () {
    test('MechanixTheme.light and dark configure BadgeThemeData correctly', () {
      for (final theme in [MechanixTheme.light, MechanixTheme.dark]) {
        final badgeTheme = theme.badgeTheme;
        final colorScheme = theme.colorScheme;

        expect(badgeTheme.backgroundColor, colorScheme.error);
        expect(badgeTheme.textColor, colorScheme.onError);
        expect(badgeTheme.smallSize, 6.0);
        expect(badgeTheme.largeSize, 16.0);
        expect(badgeTheme.padding, const EdgeInsets.symmetric(horizontal: 4.0));
        expect(badgeTheme.alignment, AlignmentDirectional.topEnd);
        expect(badgeTheme.textStyle?.fontSize, 11.0);
        expect(badgeTheme.textStyle?.fontWeight, FontWeight.w500);
      }
    });
  });

  group('MechanixBadge Widget Tests', () {
    testWidgets('renders small dot badge', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: const Scaffold(
            body: Center(
              child: MechanixBadge.small(
                child: Icon(Icons.notifications),
              ),
            ),
          ),
        ),
      );

      final badgeFinder = find.byType(Badge);
      expect(badgeFinder, findsOneWidget);

      final badge = tester.widget<Badge>(badgeFinder);
      expect(badge.label, isNull);
      expect(badge.isLabelVisible, isTrue);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
    });

    testWidgets('renders count badge with label and handles overflow', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: Column(
                children: [
                  MechanixBadge.count(
                    count: 5,
                    child: const Icon(Icons.mail),
                  ),
                  MechanixBadge.count(
                    count: 105,
                    maxCount: 99,
                    child: const Icon(Icons.mail),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
      expect(find.text('99+'), findsOneWidget);
    });

    testWidgets('renders standalone badge without child', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixBadge(
                label: const Text('PRO'),
              ),
            ),
          ),
        ),
      );

      final badge = tester.widget<Badge>(find.byType(Badge));
      expect(badge.child, isNull);
      expect(find.text('PRO'), findsOneWidget);
    });

    testWidgets('resolves semantic variants correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Column(
              children: [
                const MechanixBadge(
                  key: Key('error_badge'),
                  variant: MechanixBadgeVariant.error,
                  label: Text('E'),
                ),
                const MechanixBadge(
                  key: Key('primary_badge'),
                  variant: MechanixBadgeVariant.primary,
                  label: Text('P'),
                ),
                const MechanixBadge(
                  key: Key('neutral_badge'),
                  variant: MechanixBadgeVariant.neutral,
                  label: Text('N'),
                ),
                const MechanixBadge(
                  key: Key('surface_badge'),
                  variant: MechanixBadgeVariant.surface,
                  label: Text('S'),
                ),
              ],
            ),
          ),
        ),
      );

      final errorBadge = tester.widget<Badge>(
        find.descendant(of: find.byKey(const Key('error_badge')), matching: find.byType(Badge)),
      );
      expect(errorBadge.backgroundColor, MechanixColors.lightColorScheme.error);
      expect(errorBadge.textColor, MechanixColors.lightColorScheme.onError);

      final primaryBadge = tester.widget<Badge>(
        find.descendant(of: find.byKey(const Key('primary_badge')), matching: find.byType(Badge)),
      );
      expect(primaryBadge.backgroundColor, MechanixColors.lightColorScheme.primary);
      expect(primaryBadge.textColor, MechanixColors.lightColorScheme.onPrimary);

      final neutralBadge = tester.widget<Badge>(
        find.descendant(of: find.byKey(const Key('neutral_badge')), matching: find.byType(Badge)),
      );
      expect(neutralBadge.backgroundColor, MechanixColors.lightColorScheme.secondaryContainer);
      expect(neutralBadge.textColor, MechanixColors.lightColorScheme.onSecondaryContainer);

      final surfaceBadge = tester.widget<Badge>(
        find.descendant(of: find.byKey(const Key('surface_badge')), matching: find.byType(Badge)),
      );
      expect(surfaceBadge.backgroundColor, MechanixColors.lightColorScheme.surfaceContainerHigh);
      expect(surfaceBadge.textColor, MechanixColors.lightColorScheme.onSurface);
    });

    testWidgets('exposes accessibility semantics when semanticLabel is provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixBadge.count(
                count: 7,
                semanticLabel: '7 unread emails',
                child: const Icon(Icons.email),
              ),
            ),
          ),
        ),
      );

      expect(
        tester.getSemantics(find.byType(MechanixBadge)),
        matchesSemantics(label: '7 unread emails'),
      );
    });

    testWidgets('preserves child interactive semantics when semanticLabel is provided', (
      tester,
    ) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixBadge.count(
                count: 3,
                semanticLabel: '3 unread notifications',
                child: IconButton(
                  onPressed: () => tapped = true,
                  icon: const Icon(Icons.notifications),
                  tooltip: 'Notifications',
                ),
              ),
            ),
          ),
        ),
      );

      // Verify child button can be tapped and triggers callback
      await tester.tap(find.byType(IconButton));
      expect(tapped, isTrue);

      // Verify badge semantics
      expect(
        tester.getSemantics(find.byType(MechanixBadge)),
        matchesSemantics(label: '3 unread notifications'),
      );

      // Verify child button semantics is preserved and interactive
      expect(
        tester.getSemantics(find.byType(IconButton)),
        matchesSemantics(
          tooltip: 'Notifications',
          hasTapAction: true,
          hasFocusAction: true,
          isButton: true,
          isFocusable: true,
          hasEnabledState: true,
          isEnabled: true,
        ),
      );
    });

    testWidgets('error variant preserves error color even when ambient BadgeThemeData has custom background', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            badgeTheme: const BadgeThemeData(
              backgroundColor: Colors.blue,
              textColor: Colors.yellow,
            ),
          ),
          home: const Scaffold(
            body: Center(
              child: MechanixBadge(
                variant: MechanixBadgeVariant.error,
                label: Text('ERR'),
              ),
            ),
          ),
        ),
      );

      final badge = tester.widget<Badge>(find.byType(Badge));
      final colorScheme = Theme.of(tester.element(find.byType(Badge))).colorScheme;
      expect(badge.backgroundColor, colorScheme.error);
      expect(badge.textColor, colorScheme.onError);
    });

    testWidgets('hides label when isLabelVisible is false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixBadge(
                isLabelVisible: false,
                label: const Text('HIDDEN'),
                child: const Icon(Icons.star),
              ),
            ),
          ),
        ),
      );

      final badge = tester.widget<Badge>(find.byType(Badge));
      expect(badge.isLabelVisible, isFalse);
      expect(find.text('HIDDEN'), findsNothing);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('reactively updates colors on runtime theme change', (tester) async {
      var isDark = false;
      late StateSetter stateSetter;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            stateSetter = setState;
            return MaterialApp(
              theme: isDark ? MechanixTheme.dark : MechanixTheme.light,
              home: Scaffold(
                body: Center(
                  child: MechanixBadge(
                    variant: MechanixBadgeVariant.primary,
                    label: const Text('THEMED'),
                  ),
                ),
              ),
            );
          },
        ),
      );

      var badge = tester.widget<Badge>(find.byType(Badge));
      expect(badge.backgroundColor, MechanixColors.lightColorScheme.primary);

      stateSetter(() {
        isDark = true;
      });
      await tester.pumpAndSettle();

      badge = tester.widget<Badge>(find.byType(Badge));
      expect(badge.backgroundColor, MechanixColors.darkColorScheme.primary);
    });
  });
}
