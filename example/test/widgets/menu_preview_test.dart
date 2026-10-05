import 'package:example/features/components/menu_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MenuPreview Widget Tests', () {
    testWidgets('renders MenuPreview header and sections', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(body: MenuPreview()),
        ),
      );

      // Verify page header
      expect(find.text('Menus'), findsOneWidget);
      expect(
        find.textContaining('Menus display a list of choices'),
        findsOneWidget,
      );

      // Verify section titles
      expect(find.text('Examples & Usage'), findsOneWidget);
      expect(find.text('Basic Variants'), findsOneWidget);
      expect(find.text('Building Blocks'), findsOneWidget);

      // Verify anchor types
      expect(find.text('Text-Field Dropdown'), findsOneWidget);
      expect(find.text('Search Dropdown'), findsOneWidget);
      expect(find.text('Chip / Pill Anchor'), findsOneWidget);
      expect(find.text('Icon-Button Anchor'), findsOneWidget);

      // Verify slot anatomy
      expect(find.text('SLOT ANATOMY'), findsOneWidget);
    });
  });
}
