import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/features/components/divider_preview.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('DividerPreview Widget Tests', () {
    testWidgets('renders DividerPreview header and all sections', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: DividerPreview(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('Dividers'), findsOneWidget);
      expect(
        find.textContaining('Dividers are thin visual lines that group, separate, and structure content'),
        findsOneWidget,
      );

      // Section titles
      expect(find.text('Horizontal Dividers'), findsOneWidget);
      expect(find.text('Inset Dividers'), findsOneWidget);
      expect(find.text('Vertical Dividers'), findsOneWidget);
      expect(find.text('Card & Dialog Separators'), findsOneWidget);

      // Verify widgets
      expect(find.byType(MechanixDivider), findsWidgets);
      expect(find.byType(MechanixVerticalDivider), findsWidgets);
    });

    testWidgets('renders list item insets correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: const Scaffold(
            body: DividerPreview(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Alice Cooper'), findsOneWidget);
      expect(find.text('Bob Martin'), findsOneWidget);
      expect(find.text('Charlie Brown'), findsOneWidget);
    });
  });
}
