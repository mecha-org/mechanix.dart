import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/features/components/list_preview.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('ListPreview Widget Tests', () {
    testWidgets('renders ListPreview header and all sections', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: ListPreview(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('List Components'), findsOneWidget);

      // Section Titles
      expect(find.text('Design Matrix Showcase'), findsOneWidget);
      expect(find.text('Interactive Playground'), findsOneWidget);
      expect(find.text('Expandable Lists with Accordion Button'), findsOneWidget);
      expect(find.text('Draggable & Reorderable Lists'), findsOneWidget);
      expect(find.text('Swipable Lists with Action Reveal'), findsOneWidget);

      // Verify component types rendered
      expect(find.byType(MechanixListTile), findsWidgets);
      expect(find.byType(MechanixExpandableListTile), findsWidgets);
      expect(find.byType(MechanixDraggableListTile), findsWidgets);
      expect(find.byType(MechanixSwipableListTile), findsWidgets);
      expect(find.byType(MechanixAccordionButton), findsWidgets);
    });
  });
}
