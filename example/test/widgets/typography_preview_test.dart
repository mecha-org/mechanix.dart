import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/features/typography/typography_preview.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('TypographyPreview Widget Tests', () {
    testWidgets(
      'renders all 15 Material 3 typography styles and About section',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(child: TypographyPreview()),
            ),
          ),
        );

        // Verify Header
        expect(find.text('Typography'), findsOneWidget);
        expect(find.text('Material 3 Type Scale'), findsOneWidget);

        // Verify category group headers
        expect(find.text('Display'), findsOneWidget);
        expect(find.text('Headline'), findsOneWidget);
        expect(find.text('Title'), findsOneWidget);
        expect(find.text('Body'), findsOneWidget);
        expect(find.text('Label'), findsOneWidget);

        // Verify all 15 style names
        final styles = [
          'Display Large',
          'Display Medium',
          'Display Small',
          'Headline Large',
          'Headline Medium',
          'Headline Small',
          'Title Large',
          'Title Medium',
          'Title Small',
          'Body Large',
          'Body Medium',
          'Body Small',
          'Label Large',
          'Label Medium',
          'Label Small',
        ];

        for (final style in styles) {
          expect(find.text(style), findsWidgets);
        }
      },
    );

    testWidgets('dynamically extracts metadata from active Theme textTheme', (
      WidgetTester tester,
    ) async {
      final customTheme = ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'TestFontFamily',
            fontSize: 77.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 3.5,
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: customTheme,
          home: const Scaffold(
            body: SingleChildScrollView(child: TypographyPreview()),
          ),
        ),
      );

      // Verify dynamic metadata reflects the active TextStyle properties
      expect(find.text('TestFontFamily'), findsOneWidget);
      expect(find.text('77px'), findsOneWidget);
      expect(find.text('700'), findsOneWidget);
      expect(find.text('3.50px'), findsOneWidget);
    });

    testWidgets(
      'displays Mechanix SpaceGrotesk typography when wrapped in MechanixTheme',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MechanixTheme(
            builder: (context, theme, child) => MaterialApp(
              theme: theme.light,
              darkTheme: theme.dark,
              home: const Scaffold(
                body: SingleChildScrollView(child: TypographyPreview()),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Mechanix uses 'SpaceGrotesk' as font family across text styles
        expect(find.text('SpaceGrotesk'), findsWidgets);
      },
    );

    testWidgets('renders cleanly on narrow mobile viewport without overflow', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: TypographyPreview()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TypographyPreview), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders cleanly on desktop viewport', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        MechanixTheme(
          builder: (context, theme, child) => MaterialApp(
            theme: theme.light,
            home: const Scaffold(
              body: SingleChildScrollView(child: TypographyPreview()),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TypographyPreview), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
