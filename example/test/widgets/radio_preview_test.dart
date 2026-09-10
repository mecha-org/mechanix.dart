import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/features/components/radio_preview.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('RadioPreview Widget Tests', () {
    testWidgets('renders RadioPreview header and all section titles', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: SingleChildScrollView(child: RadioPreview()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('Radio buttons'), findsOneWidget);
      expect(
        find.textContaining('Radio buttons allow users to select one option'),
        findsOneWidget,
      );

      // Section Titles
      expect(find.text('State Matrix'), findsOneWidget);
      expect(find.text('Interactive Playground'), findsOneWidget);
      expect(find.text('Radio Group (Mutual Exclusion)'), findsOneWidget);
      expect(find.text('Modern RadioGroup Ancestor'), findsOneWidget);
      expect(find.text('Labeled Radios & Rich Custom Content'), findsOneWidget);
    });

    testWidgets('renders state matrix columns and rows', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: SingleChildScrollView(child: RadioPreview()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Enabled'), findsOneWidget);
      expect(find.text('Hovered'), findsOneWidget);
      expect(find.text('Focused'), findsOneWidget);
      expect(find.text('Pressed'), findsOneWidget);
      expect(find.text('Disabled'), findsOneWidget);
      expect(find.text('Selected'), findsOneWidget);
      expect(find.text('Unselected'), findsOneWidget);
    });

    testWidgets('renders playground items and handles interactive selection', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: SingleChildScrollView(child: RadioPreview()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Playground cards
      expect(find.text('Selected Radio'), findsOneWidget);
      expect(find.text('Unselected Radio'), findsOneWidget);
      expect(find.text('Toggleable Radio'), findsOneWidget);
      expect(find.text('Error State'), findsOneWidget);
      expect(find.text('Disabled Selected'), findsOneWidget);
      expect(find.text('Disabled Unselected'), findsOneWidget);

      expect(find.byType(MechanixRadio<int>), findsWidgets);
    });

    testWidgets(
      'shipping method group updates selection mutually exclusively',
      (WidgetTester tester) async {
        final scrollController = ScrollController();

        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: SingleChildScrollView(
                controller: scrollController,
                child: const RadioPreview(),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final standardFinder = find.text(
          'Standard Delivery (3-5 business days) - Free',
        );
        final expressFinder = find.text(
          'Express Shipping (1-2 business days) - \$9.99',
        );

        expect(standardFinder, findsOneWidget);
        expect(expressFinder, findsOneWidget);
        expect(find.text('Selected: standard'), findsOneWidget);

        final outerScrollable = find.byWidgetPredicate(
          (w) => w is Scrollable && w.controller == scrollController,
        );

        await tester.scrollUntilVisible(
          expressFinder,
          300,
          scrollable: outerScrollable,
        );
        await tester.tap(expressFinder);
        await tester.pumpAndSettle();

        expect(find.text('Selected: express'), findsOneWidget);
        scrollController.dispose();
      },
    );

    testWidgets('rich plan cards allow tapping to update selection', (
      WidgetTester tester,
    ) async {
      final scrollController = ScrollController();

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: SingleChildScrollView(
              controller: scrollController,
              child: const RadioPreview(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final starterFinder = find.text('Starter Plan');
      final proFinder = find.text('Pro Team Plan');

      expect(starterFinder, findsOneWidget);
      expect(proFinder, findsOneWidget);

      final outerScrollable = find.byWidgetPredicate(
        (w) => w is Scrollable && w.controller == scrollController,
      );

      await tester.scrollUntilVisible(
        starterFinder,
        500,
        scrollable: outerScrollable,
      );
      await tester.tap(starterFinder);
      await tester.pumpAndSettle();

      expect(find.byType(MechanixRadio<String>), findsWidgets);
      scrollController.dispose();
    });
  });
}
