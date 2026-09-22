import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/features/components/badge_preview.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('BadgePreview Widget Tests', () {
    testWidgets('renders BadgePreview header and all sections', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: BadgePreview(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('Badges'), findsOneWidget);
      expect(
        find.textContaining('Badges convey dynamic notifications, counts, or status information'),
        findsOneWidget,
      );

      // Section titles
      expect(find.text('Small Badges (Status Indicators)'), findsOneWidget);
      expect(find.text('Count Badges'), findsOneWidget);
      expect(find.text('Text Label Badges'), findsOneWidget);
      expect(find.text('Semantic Color Variants'), findsOneWidget);
      expect(find.text('Standalone Badges (Without Child)'), findsOneWidget);

      // Verify widgets
      expect(find.byType(MechanixBadge), findsWidgets);
    });

    testWidgets('renders counts and label texts', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: const Scaffold(
            body: BadgePreview(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Counts
      expect(find.text('3'), findsOneWidget);
      expect(find.text('42'), findsOneWidget);
      expect(find.text('99+'), findsOneWidget);
      expect(find.text('999+'), findsOneWidget);

      // Labels
      expect(find.text('NEW'), findsOneWidget);
      expect(find.text('PRO'), findsOneWidget);
      expect(find.text('BETA'), findsOneWidget);
      expect(find.text('PENDING'), findsOneWidget);
      expect(find.text('ARCHIVED'), findsOneWidget);
    });
  });
}
