import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixSnackbar Component Tests', () {
    testWidgets('renders basic one-line text message', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Center(
              child: MechanixSnackbar(
                message: Text('One-line snackbar message'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('One-line snackbar message'), findsOneWidget);
      expect(find.byType(MechanixSnackbar), findsOneWidget);
      // Verify semantics
      expect(find.bySemanticsLabel('One-line snackbar message'), findsOneWidget);
    });

    testWidgets('renders factory MechanixSnackbar.text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: MechanixSnackbar.text(
                text: 'Factory constructor text',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Factory constructor text'), findsOneWidget);
    });

    testWidgets('renders action button and triggers callback on tap', (tester) async {
      var actionTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: MechanixSnackbar(
                message: const Text('Item deleted'),
                action: MechanixSnackbarAction(
                  label: 'UNDO',
                  onPressed: () {
                    actionTapped = true;
                  },
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Item deleted'), findsOneWidget);
      expect(find.text('UNDO'), findsOneWidget);

      await tester.tap(find.text('UNDO'));
      await tester.pump();

      expect(actionTapped, isTrue);
    });

    testWidgets('triggers action on keyboard activation (Enter / Space)', (tester) async {
      var actionTapped = false;
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: MechanixSnackbar(
                message: const Text('Changes pending'),
                action: MechanixSnackbarAction(
                  label: 'APPLY',
                  focusNode: focusNode,
                  onPressed: () {
                    actionTapped = true;
                  },
                ),
              ),
            ),
          ),
        ),
      );

      focusNode.requestFocus();
      await tester.pump();
      expect(focusNode.hasFocus, isTrue);

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      expect(actionTapped, isTrue);

      focusNode.dispose();
    });

    testWidgets('renders close icon button and invokes onClose on tap', (tester) async {
      var closeTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: MechanixSnackbar(
                message: const Text('Upload complete'),
                showCloseIcon: true,
                onClose: () {
                  closeTapped = true;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(MechanixIcons.x), findsOneWidget);

      await tester.tap(find.byIcon(MechanixIcons.x));
      await tester.pump();

      expect(closeTapped, isTrue);
    });

    testWidgets('renders both action and close icon inline', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: MechanixSnackbar(
                message: const Text('File synchronized'),
                action: MechanixSnackbarAction(
                  label: 'VIEW',
                  onPressed: () {},
                ),
                showCloseIcon: true,
              ),
            ),
          ),
        ),
      );

      expect(find.text('File synchronized'), findsOneWidget);
      expect(find.text('VIEW'), findsOneWidget);
      expect(find.byIcon(MechanixIcons.x), findsOneWidget);

      // Verify they are rendered in a horizontal Row (Inline layout)
      final rowFinder = find.descendant(
        of: find.byType(MechanixSnackbar),
        matching: find.byType(Row),
      );
      expect(rowFinder, findsOneWidget);
    });

    testWidgets('respects explicit SnackbarLayout.stacked layout', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: MechanixSnackbar(
                layout: SnackbarLayout.stacked,
                message: const Text('Longer explanatory message requiring more room'),
                action: MechanixSnackbarAction(
                  label: 'LONG ACTION',
                  onPressed: () {},
                ),
                showCloseIcon: true,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Longer explanatory message requiring more room'), findsOneWidget);
      expect(find.text('LONG ACTION'), findsOneWidget);
      expect(find.byIcon(MechanixIcons.x), findsOneWidget);

      // In stacked layout, outer structure is a Column
      final columnFinder = find.descendant(
        of: find.byType(MechanixSnackbar),
        matching: find.byType(Column),
      );
      expect(columnFinder, findsOneWidget);
    });

    testWidgets('auto layout switches to stacked when action label is long', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 340,
                child: MechanixSnackbar(
                  message: const Text('Short message'),
                  action: MechanixSnackbarAction(
                    label: 'VERY LONG ACTION LABEL',
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      final columnFinder = find.descendant(
        of: find.byType(MechanixSnackbar),
        matching: find.byType(Column),
      );
      expect(columnFinder, findsOneWidget);
    });

    testWidgets('respects custom theme overrides via MechanixSnackbarTheme', (tester) async {
      const customBg = Color(0xFF112233);
      const customFg = Color(0xFFEEFFEE);
      const customAction = Color(0xFFFF5500);

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: MechanixSnackbarTheme(
                data: const MechanixSnackbarThemeData(
                  backgroundColor: customBg,
                  foregroundColor: customFg,
                  actionColor: customAction,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                child: MechanixSnackbar(
                  message: const Text('Themed message'),
                  action: MechanixSnackbarAction(
                    label: 'ACTION',
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(MechanixSnackbar),
          matching: find.byType(Container),
        ).first,
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(customBg));
      expect(decoration.borderRadius, equals(BorderRadius.circular(16.0)));

      final actionText = tester.widget<Text>(find.text('ACTION'));
      expect(actionText.style?.color, equals(customAction));
    });

    testWidgets('toSnackBar wraps inside floating SnackBar with transparent outer background', (tester) async {
      final snackbar = MechanixSnackbar(
        message: const Text('Floating content'),
        action: MechanixSnackbarAction(label: 'OK', onPressed: () {}),
      );

      final nativeSnackBar = snackbar.toSnackBar(
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.all(20),
      );

      expect(nativeSnackBar.behavior, equals(SnackBarBehavior.floating));
      expect(nativeSnackBar.backgroundColor, equals(Colors.transparent));
      expect(nativeSnackBar.elevation, equals(0.0));
      expect(nativeSnackBar.duration, equals(const Duration(seconds: 5)));
      expect(nativeSnackBar.margin, equals(const EdgeInsets.all(20)));
      expect(nativeSnackBar.content, equals(snackbar));
    });

    testWidgets('MechanixSnackbar.text(...).show displays snackbar via ScaffoldMessenger', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MechanixSnackbar.text(
                      text: 'Displayed via show()',
                      action: MechanixSnackbarAction(
                        label: 'CONFIRM',
                        onPressed: () {},
                      ),
                      showCloseIcon: true,
                    ).show(context);
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Displayed via show()'), findsNothing);

      await tester.tap(find.text('Show'));
      await tester.pump(); // Starts animation
      await tester.pump(const Duration(milliseconds: 500)); // Completes entrance animation

      expect(find.text('Displayed via show()'), findsOneWidget);
      expect(find.text('CONFIRM'), findsOneWidget);
      expect(find.byIcon(MechanixIcons.x), findsOneWidget);

      // Tapping close dismisses the snackbar
      await tester.tap(find.byIcon(MechanixIcons.x));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Displayed via show()'), findsNothing);
    });

    testWidgets('MechanixSnackbar(message: ...).show displays custom widget via ScaffoldMessenger', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    const MechanixSnackbar(
                      message: Row(
                        children: [
                          Icon(Icons.info),
                          SizedBox(width: 8),
                          Text('Custom widget message'),
                        ],
                      ),
                    ).show(context);
                  },
                  child: const Text('Show Custom'),
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Custom widget message'), findsNothing);
      await tester.tap(find.text('Show Custom'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Custom widget message'), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('tapping action dismisses enclosing snackbar from Scaffold', (tester) async {
      var actionFired = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MechanixSnackbar.text(
                      text: 'Action dismiss test',
                      action: MechanixSnackbarAction(
                        label: 'UNDO',
                        onPressed: () {
                          actionFired = true;
                        },
                      ),
                    ).show(context);
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Action dismiss test'), findsOneWidget);
      expect(find.text('UNDO'), findsOneWidget);

      await tester.tap(find.text('UNDO'));
      await tester.pump();
      expect(actionFired, isTrue);

      await tester.pumpAndSettle();
      expect(find.text('Action dismiss test'), findsNothing);
    });

    testWidgets('respects width parameter and sets margin to null in toSnackBar', (tester) async {
      final snackbar = MechanixSnackbar(
        message: const Text('Fixed width snackbar'),
        width: 400.0,
      );

      final nativeSnackBar = snackbar.toSnackBar();

      expect(nativeSnackBar.width, equals(400.0));
      expect(nativeSnackBar.margin, isNull);
    });

    testWidgets('toSnackBar with explicit width overrides default margin', (tester) async {
      final snackbar = MechanixSnackbar(
        message: const Text('Floating message'),
      );

      final nativeSnackBar = snackbar.toSnackBar(width: 450.0);

      expect(nativeSnackBar.width, equals(450.0));
      expect(nativeSnackBar.margin, isNull);
    });

    testWidgets('MechanixSnackbar.text(...).show displays snackbar with width without crashing', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MechanixSnackbar.text(
                      width: 400,
                      text: 'Fixed width message',
                    ).show(context);
                  },
                  child: const Text('Show Fixed Width'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Fixed Width'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Fixed width message'), findsOneWidget);
    });

    test('throws AssertionError when both margin and width are provided to constructor', () {
      expect(
        () => MechanixSnackbar(
          message: const Text('Test'),
          width: 400,
          margin: const EdgeInsets.all(16),
        ),
        throwsAssertionError,
      );
    });

    test('throws AssertionError when both margin and width are provided to toSnackBar', () {
      final snackbar = MechanixSnackbar(
        message: const Text('Test'),
      );
      expect(
        () => snackbar.toSnackBar(
          width: 400,
          margin: const EdgeInsets.all(16),
        ),
        throwsAssertionError,
      );
    });

    testWidgets('close button enforces minimum 48x48dp touch target', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Center(
              child: MechanixSnackbar(
                message: Text('Test message'),
                showCloseIcon: true,
              ),
            ),
          ),
        ),
      );

      final closeButtonFinder = find.byType(Tooltip);
      final size = tester.getSize(closeButtonFinder);
      expect(size.width, greaterThanOrEqualTo(48.0));
      expect(size.height, greaterThanOrEqualTo(48.0));
    });

    testWidgets('action button enforces minimum 48x48dp touch target', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: MechanixSnackbar(
                message: const Text('Test message'),
                action: MechanixSnackbarAction(
                  label: 'ACTION',
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      );

      final actionButtonFinder = find.ancestor(
        of: find.text('ACTION'),
        matching: find.byType(MechanixButton),
      );
      final size = tester.getSize(actionButtonFinder);
      expect(size.width, greaterThanOrEqualTo(48.0));
      expect(size.height, greaterThanOrEqualTo(48.0));
    });

    testWidgets('prevents re-entrant tap invocations on action button', (tester) async {
      var callCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MechanixSnackbar.text(
                      text: 'Re-entrancy test',
                      action: MechanixSnackbarAction(
                        label: 'CLICK',
                        onPressed: () {
                          callCount++;
                        },
                      ),
                    ).show(context);
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      final actionButton = find.text('CLICK');
      expect(actionButton, findsOneWidget);

      // Tap rapidly twice
      await tester.tap(actionButton);
      await tester.tap(actionButton);
      await tester.pump();

      expect(callCount, equals(1));
    });

    testWidgets('renders action button in disabled state when onPressed is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Center(
              child: MechanixSnackbar(
                message: Text('Disabled action test'),
                action: MechanixSnackbarAction(
                  label: 'DISABLED',
                  onPressed: null,
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('DISABLED'), findsOneWidget);
      // Tap on disabled action should do nothing and not crash
      await tester.tap(find.text('DISABLED'));
      await tester.pump();
      expect(find.text('DISABLED'), findsOneWidget);
      final disabledText = tester.widget<Text>(find.text('DISABLED'));
      expect(
        disabledText.style?.color,
        equals(MechanixColors.darkColorScheme.onSurface.withValues(alpha: 0.38)),
      );
    });

    testWidgets('toSnackBar propagates persist flag correctly', (tester) async {
      final withAction = MechanixSnackbar(
        message: const Text('Persist test'),
        action: MechanixSnackbarAction(label: 'ACT', onPressed: () {}),
      );
      expect(withAction.persist, isTrue);
      expect(withAction.toSnackBar().persist, isTrue);

      final withoutAction = const MechanixSnackbar(
        message: Text('No persist'),
      );
      expect(withoutAction.persist, isFalse);
      expect(withoutAction.toSnackBar().persist, isFalse);

      final explicitPersist = const MechanixSnackbar(
        message: Text('Explicit persist'),
        persist: true,
      );
      expect(explicitPersist.persist, isTrue);
      expect(explicitPersist.toSnackBar().persist, isTrue);

      final explicitNoPersistWithAction = MechanixSnackbar(
        message: const Text('Explicit false persist'),
        action: MechanixSnackbarAction(label: 'ACT', onPressed: () {}),
        persist: false,
      );
      expect(explicitNoPersistWithAction.persist, isFalse);
      expect(explicitNoPersistWithAction.toSnackBar().persist, isFalse);
    });

    testWidgets('toSnackBar invokes onVisible callback when shown', (tester) async {
      var visibleFired = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    MechanixSnackbar.text(
                      text: 'Visible test',
                      onVisible: () {
                        visibleFired = true;
                      },
                    ).show(context);
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(visibleFired, isTrue);
    });

    testWidgets('supports SnackBarBehavior.fixed and asserts when margin/width are provided', (tester) async {
      final fixedSnackbar = const MechanixSnackbar(
        message: Text('Fixed snackbar'),
        behavior: SnackBarBehavior.fixed,
      );
      final nativeFixed = fixedSnackbar.toSnackBar();
      expect(nativeFixed.behavior, equals(SnackBarBehavior.fixed));
      expect(nativeFixed.margin, isNull);
      expect(nativeFixed.width, isNull);

      expect(
        () => MechanixSnackbar(
          message: const Text('Fixed error'),
          behavior: SnackBarBehavior.fixed,
          width: 300,
        ),
        throwsAssertionError,
      );
    });

    testWidgets('respects actionOverflowThreshold ratio for dynamic stacking', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: MechanixSnackbar(
                  actionOverflowThreshold: 0.1, // Very low threshold forces stacked
                  message: const Text('Short'),
                  action: MechanixSnackbarAction(
                    label: 'ACT',
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      final columnFinder = find.descendant(
        of: find.byType(MechanixSnackbar),
        matching: find.byType(Column),
      );
      expect(columnFinder, findsOneWidget);
    });
  });
}
