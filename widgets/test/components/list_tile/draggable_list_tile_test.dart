import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixDraggableListTile Widget Tests', () {
    testWidgets(
      'proxy decorator applies required double box-shadows and background',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: const Scaffold(
              body: MechanixReorderableProxyDecorator(
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: Text('Dragging Item'),
                ),
              ),
            ),
          ),
        );

        expect(find.text('Dragging Item'), findsOneWidget);

        final decoratedBox = tester.widget<DecoratedBox>(
          find.byType(DecoratedBox).first,
        );
        final decoration = decoratedBox.decoration as BoxDecoration;

        // Check double box shadows
        expect(decoration.boxShadow, isNotNull);
        expect(decoration.boxShadow!.length, equals(2));
        expect(decoration.boxShadow![0].offset, equals(const Offset(0, 4)));
        expect(decoration.boxShadow![0].blurRadius, equals(4));
        expect(decoration.boxShadow![1].offset, equals(const Offset(0, 8)));
        expect(decoration.boxShadow![1].blurRadius, equals(12));
        expect(decoration.boxShadow![1].spreadRadius, equals(6));

        // Check background color: onPrimaryFixedVariant in dark mode is 0xFF232325
        expect(
          decoration.color,
          equals(MechanixColors.darkColorScheme.onPrimaryFixedVariant),
        );
      },
    );

    testWidgets(
      'shows resting trailing icon when not dragging and switches to drag handle when dragging',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              body: Column(
                children: [
                  MechanixDraggableListTile(
                    key: Key('resting'),
                    index: 0,
                    label: 'Resting Item',
                    trailingWidgets: [const Icon(Icons.crop_square_rounded)],
                    dragHandleIcon: Icons.drag_handle_rounded,
                    isDragging: false,
                  ),
                  MechanixDraggableListTile(
                    key: Key('dragging'),
                    index: 1,
                    label: 'Dragging Item',
                    trailingWidgets: [const Icon(Icons.crop_square_rounded)],
                    dragHandleIcon: Icons.drag_handle_rounded,
                    isDragging: true,
                  ),
                ],
              ),
            ),
          ),
        );

        // Resting tile has crop_square_rounded icon and long press delayed drag listener
        expect(
          find.byType(ReorderableDelayedDragStartListener),
          findsNWidgets(2),
        );
        expect(find.byIcon(Icons.crop_square_rounded), findsOneWidget);

        // Dragging tile switches trailing icon to drag_handle_rounded (=)
        expect(find.byIcon(Icons.drag_handle_rounded), findsOneWidget);
      },
    );

    testWidgets('MechanixReorderableListView reorders items', (
      WidgetTester tester,
    ) async {
      final items = ['Item A', 'Item B', 'Item C'];

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MechanixReorderableListView(
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final item = items.removeAt(oldIndex);
                      items.insert(newIndex, item);
                    });
                  },
                  children: [
                    for (int i = 0; i < items.length; i++)
                      MechanixDraggableListTile(
                        key: ValueKey(items[i]),
                        index: i,
                        label: items[i],
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Item A'), findsOneWidget);
      expect(find.text('Item B'), findsOneWidget);
      expect(find.text('Item C'), findsOneWidget);
    });
  });
}
