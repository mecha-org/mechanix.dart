import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/features/components/snackbar_preview.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('SnackbarPreview Widget Tests', () {
    testWidgets('renders SnackbarPreview header and all section cards', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: SnackbarPreview(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('Snackbars'), findsOneWidget);
      expect(
        find.textContaining('Snackbars provide brief messages about app processes'),
        findsOneWidget,
      );

      // Section Titles
      expect(find.text('Live Interactive Triggers'), findsOneWidget);
      expect(find.text('Visual Specification Matrix'), findsOneWidget);
      expect(find.text('Building Blocks'), findsOneWidget);

      // Matrix Columns
      expect(find.text('Without Dismiss Button'), findsOneWidget);
      expect(find.text('With Dismiss Button'), findsOneWidget);
    });

    testWidgets('renders live interactive trigger buttons and triggers snackbar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: SnackbarPreview(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Simple Message'), findsOneWidget);
      expect(find.text('With Action'), findsOneWidget);
      expect(find.text('With Action & Close'), findsOneWidget);
      expect(find.text('Multiline (Inline Action)'), findsOneWidget);
      expect(find.text('Stacked (Action Below)'), findsOneWidget);

      // Tap on simple message trigger
      await tester.tap(find.text('Simple Message'));
      await tester.pumpAndSettle();

      expect(find.text('File deleted from your device.'), findsOneWidget);
    });

    testWidgets('triggers action callback from live snackbar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: SnackbarPreview(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('With Action'));
      await tester.pumpAndSettle();

      expect(find.text('RETRY'), findsOneWidget);

      await tester.tap(find.text('RETRY'));
      await tester.pumpAndSettle();

      expect(find.text('Callback event: Retry invoked!'), findsOneWidget);
    });

    testWidgets('renders cleanly on narrow mobile viewport without overflow', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: SnackbarPreview(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SnackbarPreview), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
