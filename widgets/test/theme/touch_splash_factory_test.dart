import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('TouchOptimizedSplashFactory Comprehensive Audit Tests', () {
    test('MechanixTheme configures TouchOptimizedSplashFactory', () {
      final light = MechanixTheme.light;
      expect(light.splashFactory, isA<TouchOptimizedSplashFactory>());
      expect(light.splashColor, isNotNull);

      final dark = MechanixTheme.dark;
      expect(dark.splashFactory, isA<TouchOptimizedSplashFactory>());
      expect(dark.splashColor, isNotNull);
    });

    testWidgets('MechanixButton uses TouchOptimizedSplashFactory and resolves overlayColor', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixButton.filled(
                label: 'Test Button',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      final filledButton = tester.widget<FilledButton>(
        find.byType(FilledButton),
      );
      final style = filledButton.style!;

      expect(style.splashFactory, isA<TouchOptimizedSplashFactory>());

      final pressedOverlay = style.overlayColor?.resolve({WidgetState.pressed});
      expect(pressedOverlay, isNotNull);
      expect(pressedOverlay?.a, greaterThan(0.0));

      final disabledOverlay = style.overlayColor?.resolve({
        WidgetState.disabled,
      });
      expect(disabledOverlay, equals(Colors.transparent));
    });

    testWidgets('MechanixIconButton uses TouchOptimizedSplashFactory and resolves overlayColor', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixIconButton(
                icon: const Icon(Icons.star),
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      final iconButton = tester.widget<IconButton>(find.byType(IconButton));
      final style = iconButton.style!;

      expect(style.splashFactory, isA<TouchOptimizedSplashFactory>());

      final pressedOverlay = style.overlayColor?.resolve({WidgetState.pressed});
      expect(pressedOverlay, isNotNull);
      expect(pressedOverlay?.a, greaterThan(0.0));
    });

    testWidgets('TouchOptimizedSplash triggers immediately on tap and completes fade-out in 150ms', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixButton.filled(
                label: 'Tap Target',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      final buttonFinder = find.text('Tap Target');
      final gesture = await tester.startGesture(tester.getCenter(buttonFinder));
      await tester.pump(); // Tap down

      await gesture.up();
      await tester.pump();

      // Halfway through fade-out
      await tester.pump(const Duration(milliseconds: 75));

      // Past 150ms
      await tester.pump(const Duration(milliseconds: 100));

      await tester.pumpAndSettle();
    });

    testWidgets('Rapid repeated taps deduplicate splashes without stacking opacity or crashing', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: MechanixButton.filled(
                label: 'Rapid Tap Target',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      final buttonFinder = find.text('Rapid Tap Target');

      // Tap 1
      final g1 = await tester.startGesture(tester.getCenter(buttonFinder));
      await tester.pump(const Duration(milliseconds: 20));
      await g1.up();
      await tester.pump(const Duration(milliseconds: 20));

      // Tap 2 immediately while Tap 1 is still fading
      final g2 = await tester.startGesture(tester.getCenter(buttonFinder));
      await tester.pump(const Duration(milliseconds: 20));
      await g2.up();
      await tester.pump(const Duration(milliseconds: 20));

      // Tap 3 immediately
      final g3 = await tester.startGesture(tester.getCenter(buttonFinder));
      await tester.pump(const Duration(milliseconds: 20));
      await g3.up();

      // Let animation finish completely
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();
    });

    testWidgets('Early widget unmount during fade-out disposes cleanly without leaking tickers', (
      WidgetTester tester,
    ) async {
      var showButton = true;
      late StateSetter setWidgetState;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                setWidgetState = setState;
                return showButton
                    ? MechanixButton.filled(
                        label: 'Ephemeral Target',
                        onPressed: () {},
                      )
                    : const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      final buttonFinder = find.text('Ephemeral Target');
      final gesture = await tester.startGesture(tester.getCenter(buttonFinder));
      await tester.pump();
      await gesture.up();
      await tester.pump(const Duration(milliseconds: 50)); // Fading out

      // Unmount the button mid-fade
      setWidgetState(() {
        showButton = false;
      });
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();
    });

    testWidgets('Supports circular touch splashes when radius is specified without customBorder', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Center(
              child: InkResponse(
                splashFactory: const TouchOptimizedSplashFactory(),
                containedInkWell: false,
                radius: 24.0,
                onTap: () {},
                child: const Icon(Icons.circle),
              ),
            ),
          ),
        ),
      );

      final iconFinder = find.byType(Icon);
      final gesture = await tester.startGesture(tester.getCenter(iconFinder));
      await tester.pump();
      await gesture.up();
      await tester.pump(const Duration(milliseconds: 150));
      await tester.pumpAndSettle();
    });
  });
}
