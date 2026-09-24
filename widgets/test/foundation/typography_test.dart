import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('Mechanix createTextTheme Tests', () {
    const textColor = Color(0xFF111111);
    final theme = createTextTheme(textColor: textColor);

    test('Display styles match Mechanix specifications', () {
      final large = theme.displayLarge!;
      expect(large.fontSize, equals(52.0));
      expect(large.height, equals(66.0 / 52.0));
      expect(large.fontWeight, equals(FontWeight.w300));
      expect(large.letterSpacing, equals(0.0));
      expect(large.color, equals(textColor));
      expect(large.fontFamily, endsWith('SpaceGrotesk'));
      expect(large.leadingDistribution, equals(TextLeadingDistribution.even));

      final medium = theme.displayMedium!;
      expect(medium.fontSize, equals(45.0));
      expect(medium.height, equals(52.0 / 45.0));
      expect(medium.fontWeight, equals(FontWeight.w300));
      expect(medium.letterSpacing, equals(0.0));
      expect(medium.color, equals(textColor));
      expect(medium.fontFamily, endsWith('SpaceGrotesk'));

      final small = theme.displaySmall!;
      expect(small.fontSize, equals(36.0));
      expect(small.height, equals(44.0 / 36.0));
      expect(small.fontWeight, equals(FontWeight.w300));
      expect(small.letterSpacing, equals(0.0));
      expect(small.color, equals(textColor));
      expect(small.fontFamily, endsWith('SpaceGrotesk'));
    });

    test('Headline styles match Mechanix specifications', () {
      final large = theme.headlineLarge!;
      expect(large.fontSize, equals(32.0));
      expect(large.height, equals(40.0 / 32.0));
      expect(large.fontWeight, equals(FontWeight.w300));
      expect(large.letterSpacing, equals(0.0));
      expect(large.color, equals(textColor));
      expect(large.fontFamily, endsWith('SpaceGrotesk'));

      final medium = theme.headlineMedium!;
      expect(medium.fontSize, equals(24.0));
      expect(medium.height, equals(36.0 / 24.0));
      expect(medium.fontWeight, equals(FontWeight.w300));
      expect(medium.letterSpacing, equals(2.0));
      expect(medium.color, equals(textColor));
      expect(medium.fontFamily, endsWith('SpaceGrotesk'));

      final small = theme.headlineSmall!;
      expect(small.fontSize, equals(22.0));
      expect(small.height, equals(26.0 / 22.0));
      expect(small.fontWeight, equals(FontWeight.w300));
      expect(small.letterSpacing, equals(0.0));
      expect(small.color, equals(textColor));
      expect(small.fontFamily, endsWith('SpaceGrotesk'));
    });

    test('Title styles match Mechanix specifications', () {
      final large = theme.titleLarge!;
      expect(large.fontSize, equals(20.0));
      expect(large.height, equals(26.0 / 20.0));
      expect(large.fontWeight, equals(FontWeight.w400));
      expect(large.letterSpacing, equals(0.0));
      expect(large.color, equals(textColor));
      expect(large.fontFamily, endsWith('Geist'));

      final medium = theme.titleMedium!;
      expect(medium.fontSize, equals(18.0));
      expect(medium.height, equals(23.0 / 18.0));
      expect(medium.fontWeight, equals(FontWeight.w300));
      expect(medium.letterSpacing, equals(0.0));
      expect(medium.color, equals(textColor));
      expect(medium.fontFamily, endsWith('Geist'));

      final small = theme.titleSmall!;
      expect(small.fontSize, equals(16.0));
      expect(small.height, equals(20.0 / 16.0));
      expect(small.fontWeight, equals(FontWeight.w300));
      expect(small.letterSpacing, equals(0.1));
      expect(small.color, equals(textColor));
      expect(small.fontFamily, endsWith('Geist'));
    });

    test('Body styles match Mechanix specifications', () {
      final large = theme.bodyLarge!;
      expect(large.fontSize, equals(16.0));
      expect(large.height, equals(22.0 / 16.0));
      expect(large.fontWeight, equals(FontWeight.w400));
      expect(large.letterSpacing, equals(0.0));
      expect(large.color, equals(textColor));
      expect(large.fontFamily, endsWith('Geist'));

      final medium = theme.bodyMedium!;
      expect(medium.fontSize, equals(14.0));
      expect(medium.height, equals(18.0 / 14.0));
      expect(medium.fontWeight, equals(FontWeight.w300));
      expect(medium.letterSpacing, equals(-0.25));
      expect(medium.color, equals(textColor));
      expect(medium.fontFamily, endsWith('Geist'));

      final small = theme.bodySmall!;
      expect(small.fontSize, equals(12.0));
      expect(small.height, equals(16.0 / 12.0));
      expect(small.fontWeight, equals(FontWeight.w300));
      expect(small.letterSpacing, equals(0.4));
      expect(small.color, equals(textColor));
      expect(small.fontFamily, endsWith('Geist'));
    });

    test('Label styles match Mechanix specifications', () {
      final large = theme.labelLarge!;
      expect(large.fontSize, equals(14.0));
      expect(large.height, equals(20.0 / 14.0));
      expect(large.fontWeight, equals(FontWeight.w400));
      expect(large.letterSpacing, equals(-0.5));
      expect(large.color, equals(textColor));
      expect(large.fontFamily, endsWith('GeistMono'));

      final medium = theme.labelMedium!;
      expect(medium.fontSize, equals(12.0));
      expect(medium.height, equals(16.0 / 12.0));
      expect(medium.fontWeight, equals(FontWeight.w300));
      expect(medium.letterSpacing, equals(0.5));
      expect(medium.color, equals(textColor));
      expect(medium.fontFamily, endsWith('Geist'));

      final small = theme.labelSmall!;
      expect(small.fontSize, equals(11.0));
      expect(small.height, equals(16.0 / 11.0));
      expect(small.fontWeight, equals(FontWeight.w300));
      expect(small.letterSpacing, equals(0.5));
      expect(small.color, equals(textColor));
      expect(small.fontFamily, endsWith('GeistMono'));
    });

    test('Font family and fallbacks can be customized', () {
      final customTheme = createTextTheme(
        textColor: Colors.blue,
        fontFamily: 'Roboto',
        fontFamilyFallback: ['Noto Sans', 'Noto Color Emoji'],
      );

      expect(customTheme.displayLarge?.fontFamily, equals('Roboto'));
      expect(
        customTheme.displayLarge?.fontFamilyFallback,
        equals(['Noto Sans', 'Noto Color Emoji']),
      );
      expect(customTheme.bodyMedium?.fontFamily, equals('Roboto'));
      expect(
        customTheme.bodyMedium?.fontFamilyFallback,
        equals(['Noto Sans', 'Noto Color Emoji']),
      );
      expect(customTheme.displayLarge?.color, equals(Colors.blue));
    });

    testWidgets('TextTheme renders in widget tree through ThemeData', (
      WidgetTester tester,
    ) async {
      final textTheme = createTextTheme(textColor: Colors.black);

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(textTheme: textTheme),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final theme = Theme.of(context).textTheme;
                return Column(
                  children: [
                    Text('Headline', style: theme.headlineLarge),
                    Text('Title', style: theme.titleMedium),
                    Text('Body', style: theme.bodyMedium),
                    Text('Label', style: theme.labelLarge),
                  ],
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Headline'), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Body'), findsOneWidget);
      expect(find.text('Label'), findsOneWidget);
    });
  });
}
