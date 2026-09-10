import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixBottomSheet Theme Tests', () {
    test('MechanixTheme.light and dark configure BottomSheetThemeData correctly', () {
      for (final theme in [MechanixTheme.light, MechanixTheme.dark]) {
        final bottomSheetTheme = theme.bottomSheetTheme;
        final colorScheme = theme.colorScheme;

        expect(bottomSheetTheme.backgroundColor, colorScheme.surfaceContainerLow);
        expect(bottomSheetTheme.modalBackgroundColor, colorScheme.surfaceContainerLow);
        expect(
          bottomSheetTheme.modalBarrierColor,
          colorScheme.scrim.withValues(alpha: 0.32),
        );
        expect(bottomSheetTheme.elevation, 1.0);
        expect(bottomSheetTheme.modalElevation, 1.0);
        expect(bottomSheetTheme.showDragHandle, isTrue);
        expect(
          bottomSheetTheme.dragHandleColor,
          colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
        );
        expect(bottomSheetTheme.clipBehavior, Clip.antiAlias);
        expect(bottomSheetTheme.dragHandleSize, isNull);
        expect(bottomSheetTheme.constraints, isNull);

        final shape = bottomSheetTheme.shape as RoundedRectangleBorder?;
        expect(shape, isNotNull);
        final borderRadius = shape!.borderRadius as BorderRadius;
        expect(borderRadius, BorderRadius.zero);
      }
    });
  });

  group('MechanixBottomSheet Widget & Modal Tests', () {
    testWidgets('MechanixBottomSheet.showModal opens and renders content and drag handle', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MechanixBottomSheet.showModal(
                      context: context,
                      builder: (context) => const SizedBox(
                        height: 200,
                        child: Center(child: Text('Modal Sheet Content')),
                      ),
                    );
                  },
                  child: const Text('Open Modal'),
                );
              },
            ),
          ),
        ),
      );

      // Sheet is not open initially
      expect(find.text('Modal Sheet Content'), findsNothing);

      // Tap button to open
      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      // Content and BottomSheet are visible
      expect(find.text('Modal Sheet Content'), findsOneWidget);
      expect(find.byType(BottomSheet), findsOneWidget);

      // Verify drag handle is rendered
      final bottomSheet = tester.widget<BottomSheet>(find.byType(BottomSheet));
      expect(bottomSheet.showDragHandle, isTrue);
    });

    testWidgets('tapping modal barrier dismisses the bottom sheet', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MechanixBottomSheet.showModal(
                      context: context,
                      builder: (context) => const SizedBox(
                        height: 200,
                        child: Center(child: Text('Dismissible Sheet')),
                      ),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Dismissible Sheet'), findsOneWidget);

      // Tap above sheet (barrier area)
      await tester.tapAt(const Offset(20, 20));
      await tester.pumpAndSettle();

      // Sheet should be dismissed
      expect(find.text('Dismissible Sheet'), findsNothing);
    });

    testWidgets('Escape key dismisses modal sheet on desktop', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MechanixBottomSheet.showModal(
                      context: context,
                      builder: (context) => const SizedBox(
                        height: 200,
                        child: Text('Desktop Escape Sheet'),
                      ),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Desktop Escape Sheet'), findsOneWidget);

      // Send Escape key
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();

      expect(find.text('Desktop Escape Sheet'), findsNothing);
    });

    testWidgets('dragging down dismisses modal bottom sheet', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MechanixBottomSheet.showModal(
                      context: context,
                      builder: (context) => const SizedBox(
                        height: 250,
                        child: Center(child: Text('Draggable Sheet')),
                      ),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Draggable Sheet'), findsOneWidget);

      // Drag down from sheet
      await tester.drag(find.text('Draggable Sheet'), const Offset(0, 300));
      await tester.pumpAndSettle();

      expect(find.text('Draggable Sheet'), findsNothing);
    });

    testWidgets('MechanixBottomSheet.show opens persistent sheet coexisting with UI', (
      WidgetTester tester,
    ) async {
      int backgroundTapCount = 0;
      PersistentBottomSheetController? sheetController;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Column(
              children: [
                ElevatedButton(
                  onPressed: () => backgroundTapCount++,
                  child: const Text('Background Action'),
                ),
                Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        sheetController = MechanixBottomSheet.show(
                          context: context,
                          builder: (context) => const SizedBox(
                            height: 120,
                            child: Center(child: Text('Persistent Content')),
                          ),
                        );
                      },
                      child: const Text('Open Persistent'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Persistent'));
      await tester.pumpAndSettle();
      expect(find.text('Persistent Content'), findsOneWidget);

      // Background button remains clickable without modal barrier blocking
      await tester.tap(find.text('Background Action'));
      await tester.pump();
      expect(backgroundTapCount, 1);

      // Close programmatically via controller
      sheetController?.close();
      await tester.pumpAndSettle();
      expect(find.text('Persistent Content'), findsNothing);
    });

    testWidgets('applies responsive max width (640dp) on wide desktop screens', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MechanixBottomSheet.showModal(
                      context: context,
                      builder: (context) => const SizedBox(
                        height: 200,
                        child: Center(child: Text('Desktop Sized Sheet')),
                      ),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final materialFinder = find.descendant(
        of: find.byType(BottomSheet),
        matching: find.byType(Material),
      );
      final sheetRenderBox = tester.renderObject<RenderBox>(materialFinder.first);
      // Max width constrained to 640 on 1200 wide screen
      expect(sheetRenderBox.size.width, 640.0);
      // Centered horizontally: (1200 - 640) / 2 = 280
      final sheetTopLeft = sheetRenderBox.localToGlobal(Offset.zero);
      expect(sheetTopLeft.dx, 280.0);
    });

    testWidgets('persistent bottom sheet spans full width on desktop', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MechanixBottomSheet.show(
                      context: context,
                      builder: (context) => const SizedBox(
                        height: 100,
                        child: Center(child: Text('Persistent Desktop Sheet')),
                      ),
                    );
                  },
                  child: const Text('Open Persistent'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Persistent'));
      await tester.pumpAndSettle();

      final sheetRenderBox = tester.renderObject<RenderBox>(find.byType(BottomSheet));
      expect(sheetRenderBox.size.width, 1200.0);
    });

    testWidgets('fills full width on narrow mobile screens', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(380, 700);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MechanixBottomSheet.showModal(
                      context: context,
                      builder: (context) => const SizedBox(
                        height: 200,
                        child: Center(child: Text('Mobile Sized Sheet')),
                      ),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final sheetRenderBox = tester.renderObject<RenderBox>(find.byType(BottomSheet));
      expect(sheetRenderBox.size.width, 380.0);
    });

    testWidgets('supports scrollable content inside bottom sheet', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MechanixBottomSheet.showModal(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SizedBox(
                        height: 400,
                        child: ListView.builder(
                          itemCount: 50,
                          itemBuilder: (context, index) => ListTile(
                            title: Text('List Item $index'),
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text('Open Scrollable'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Scrollable'));
      await tester.pumpAndSettle();

      expect(find.text('List Item 0'), findsOneWidget);
      // Scroll list
      await tester.drag(find.text('List Item 0'), const Offset(0, -300));
      await tester.pumpAndSettle();

      expect(find.text('List Item 0'), findsNothing);
      expect(find.byType(ListTile), findsWidgets);
    });

    testWidgets('supports text field with focus and input inside sheet', (
      WidgetTester tester,
    ) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MechanixBottomSheet.showModal(
                      context: context,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(labelText: 'Sheet Input'),
                        ),
                      ),
                    );
                  },
                  child: const Text('Open Input Sheet'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Input Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Sheet Input'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Testing Mechanix Input');
      expect(controller.text, 'Testing Mechanix Input');
    });

    testWidgets('mounted sheet reactively updates on runtime theme change', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MechanixTheme(
          themeMode: ThemeMode.light,
          builder: (context, themeData, child) {
            return MaterialApp(
              theme: themeData.light,
              darkTheme: themeData.dark,
              themeMode: themeData.mode,
              home: Scaffold(
                body: Builder(
                  builder: (scaffoldContext) {
                    return Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            MechanixBottomSheet.showModal(
                              context: scaffoldContext,
                              builder: (sheetContext) {
                                final currentBrightness = Theme.of(sheetContext).brightness;
                                return SizedBox(
                                  height: 150,
                                  child: Center(
                                    child: Text('Brightness: $currentBrightness'),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text('Open Theme Sheet'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            MechanixTheme.setThemeMode(scaffoldContext, ThemeMode.dark);
                          },
                          child: const Text('Toggle Theme'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      );

      // Open sheet in Light mode
      await tester.tap(find.text('Open Theme Sheet'));
      await tester.pumpAndSettle();
      expect(find.text('Brightness: Brightness.light'), findsOneWidget);

      // Change theme to Dark mode while sheet is still open
      final context = tester.element(find.text('Brightness: Brightness.light'));
      MechanixTheme.setThemeMode(context, ThemeMode.dark);
      await tester.pumpAndSettle();

      // Sheet re-rendered dynamically to dark brightness without being reopened
      expect(find.text('Brightness: Brightness.dark'), findsOneWidget);
    });
  });
}
