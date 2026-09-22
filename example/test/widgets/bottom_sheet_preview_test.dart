import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/features/components/bottom_sheet_preview.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('BottomSheetPreview Widget Tests', () {
    testWidgets('renders BottomSheetPreview header and sections', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: BottomSheetPreview(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('Bottom Sheet'), findsOneWidget);
      expect(
        find.textContaining('Bottom sheets are surfaces containing supplementary content'),
        findsOneWidget,
      );

      // Section titles
      expect(find.text('Modal Bottom Sheet'), findsOneWidget);
      expect(find.text('Standard (Persistent) Bottom Sheet'), findsOneWidget);
      expect(find.text('Scrollable & Long Content'), findsOneWidget);
      expect(find.text('Keyboard & Input Support'), findsOneWidget);
      expect(find.text('Runtime Theme Reactivity'), findsOneWidget);
    });

    testWidgets('triggers modal bottom sheet and displays modal content', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: BottomSheetPreview(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Modal Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Modal Options'), findsOneWidget);
      expect(find.text('Share document'), findsOneWidget);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.text('Modal Options'), findsNothing);
    });

    testWidgets('triggers persistent bottom sheet and toggles close', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: BottomSheetPreview(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('Show Persistent Sheet'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      expect(find.text('Show Persistent Sheet'), findsOneWidget);
      await tester.tap(find.text('Show Persistent Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Persistent Audio Player'), findsOneWidget);
      expect(find.text('Close Persistent Sheet'), findsOneWidget);

      await tester.tap(find.text('Close Persistent Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Persistent Audio Player'), findsNothing);
    });
  });
}
