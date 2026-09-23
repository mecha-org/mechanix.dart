import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixNavigationBar Widget Tests', () {
    testWidgets('renders MechanixNavigationBar with default 80.0dp height', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            bottomNavigationBar: MechanixNavigationBar(
              selectedIndex: 0,
              destinations: const [
                MechanixNavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                MechanixNavigationDestination(
                  icon: Icon(Icons.search_outlined),
                  selectedIcon: Icon(Icons.search),
                  label: 'Search',
                ),
              ],
            ),
          ),
        ),
      );

      final barFinder = find.byType(MechanixNavigationBar);
      expect(barFinder, findsOneWidget);

      final barSize = tester.getSize(barFinder);
      expect(barSize.height, 80.0);
    });

    testWidgets(
      'selected color and 1px top border are applied to whole nav item with icon and label',
      (WidgetTester tester) async {
        final darkTheme = MechanixTheme.dark;
        final colorScheme = darkTheme.colorScheme;

        await tester.pumpWidget(
          MaterialApp(
            theme: darkTheme,
            home: Scaffold(
              bottomNavigationBar: MechanixNavigationBar(
                selectedIndex: 0,
                destinations: [
                  MechanixNavigationDestination(
                    icon: Icon(Icons.home_outlined, key: Key('icon_0')),
                    label: 'Home',
                  ),
                  MechanixNavigationDestination(
                    icon: Icon(Icons.search_outlined, key: Key('icon_1')),
                    label: 'Search',
                  ),
                ],
              ),
            ),
          ),
        );

        // Find AnimatedContainers for destination items
        final containers = tester.widgetList<AnimatedContainer>(
          find.byType(AnimatedContainer),
        );

        // In whole-item mode, cell container height is 80.0 dp
        final cellContainers = containers
            .where((c) => c.constraints?.maxHeight == 80.0)
            .toList();

        expect(cellContainers.length, 2);

        // 1px top border lines
        final borderLines = containers
            .where((c) => c.constraints?.maxHeight == 1.0)
            .toList();

        expect(borderLines.length, 2);

        final selectedBorderLine = borderLines[0].decoration as BoxDecoration?;
        expect(selectedBorderLine?.color, colorScheme.onSecondaryFixed);

        final unselectedBorderLine =
            borderLines[1].decoration as BoxDecoration?;
        expect(unselectedBorderLine?.color, Colors.transparent);
      },
    );

    testWidgets('fires onDestinationSelected when destination tapped', (
      WidgetTester tester,
    ) async {
      int selectedIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                bottomNavigationBar: MechanixNavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  destinations: const [
                    MechanixNavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    MechanixNavigationDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      expect(selectedIndex, 0);

      // Tap on Settings destination
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      expect(selectedIndex, 1);
    });

    testWidgets('disabled destination cannot be selected', (
      WidgetTester tester,
    ) async {
      int selectedIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                bottomNavigationBar: MechanixNavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  destinations: const [
                    MechanixNavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      label: 'Home',
                    ),
                    MechanixNavigationDestination(
                      icon: Icon(Icons.lock_outline),
                      label: 'Disabled',
                      enabled: false,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Disabled'));
      await tester.pumpAndSettle();

      // Selected index remains 0
      expect(selectedIndex, 0);
    });

    testWidgets('supports Flutter standard NavigationDestination', (
      WidgetTester tester,
    ) async {
      int selectedIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                bottomNavigationBar: MechanixNavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.explore_outlined),
                      selectedIcon: Icon(Icons.explore),
                      label: 'Explore',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.bookmark_outline),
                      selectedIcon: Icon(Icons.bookmark),
                      label: 'Saved',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      expect(find.text('Explore'), findsOneWidget);
      expect(find.text('Saved'), findsOneWidget);

      await tester.tap(find.text('Saved'));
      await tester.pumpAndSettle();

      expect(selectedIndex, 1);
    });

    testWidgets('respects NavigationDestinationLabelBehavior', (
      WidgetTester tester,
    ) async {
      // Test alwaysHide
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            bottomNavigationBar: MechanixNavigationBar(
              selectedIndex: 0,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              destinations: [
                MechanixNavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                MechanixNavigationDestination(
                  icon: Icon(Icons.search_outlined),
                  label: 'Search',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsNothing);
      expect(find.text('Search'), findsNothing);

      // Test onlyShowSelected
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            bottomNavigationBar: MechanixNavigationBar(
              selectedIndex: 0,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              destinations: [
                MechanixNavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                MechanixNavigationDestination(
                  icon: Icon(Icons.search_outlined),
                  label: 'Search',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsNothing);
    });

    testWidgets(
      'renders badge when provided on MechanixNavigationDestination',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              bottomNavigationBar: MechanixNavigationBar(
                selectedIndex: 0,
                destinations: [
                  MechanixNavigationDestination(
                    icon: Icon(Icons.notifications_outlined),
                    label: 'Alerts',
                    badge: Text('5'),
                  ),
                  MechanixNavigationDestination(
                    icon: Icon(Icons.person_outline),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('5'), findsOneWidget);
        expect(find.text('Alerts'), findsOneWidget);
      },
    );

    testWidgets(
      'renders 4.0dp destination gap between navigation destinations by default',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              bottomNavigationBar: MechanixNavigationBar(
                selectedIndex: 0,
                destinations: [
                  MechanixNavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    label: 'Home',
                  ),
                  MechanixNavigationDestination(
                    icon: Icon(Icons.search_outlined),
                    label: 'Search',
                  ),
                  MechanixNavigationDestination(
                    icon: Icon(Icons.person_outline),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        );

        // 3 items -> 2 SizedBox widgets with width 4.0
        final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
        final gapBoxes = sizedBoxes
            .where((s) => s.width == 4.0 && s.height == null)
            .toList();

        expect(gapBoxes.length, 2);
      },
    );

    testWidgets(
      'renders vertical dividers when destinationGap is 0 and showDividers is true',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              bottomNavigationBar: MechanixNavigationBar(
                selectedIndex: 0,
                destinationGap: 0,
                destinations: [
                  MechanixNavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    label: 'Home',
                  ),
                  MechanixNavigationDestination(
                    icon: Icon(Icons.search_outlined),
                    label: 'Search',
                  ),
                  MechanixNavigationDestination(
                    icon: Icon(Icons.person_outline),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        );

        // 3 items -> 2 vertical divider containers of width 1.0
        final containers = tester.widgetList<Container>(find.byType(Container));
        final dividerContainers = containers
            .where(
              (c) =>
                  c.constraints?.maxWidth == 1.0 &&
                  c.constraints?.maxHeight == 80.0,
            )
            .toList();

        expect(dividerContainers.length, 2);
      },
    );

    testWidgets('supports pill mode when applyToWholeItem is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            bottomNavigationBar: MechanixNavigationBar(
              selectedIndex: 0,
              theme: NavigationBarThemeDataConfig(
                applyToWholeItem: false,
                itemWidth: 56.0,
                itemHeight: 32.0,
              ),
              destinations: [
                MechanixNavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                MechanixNavigationDestination(
                  icon: Icon(Icons.search_outlined),
                  label: 'Search',
                ),
              ],
            ),
          ),
        ),
      );

      final containers = tester.widgetList<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );

      final pillContainers = containers
          .where(
            (c) =>
                c.constraints?.maxWidth == 56.0 &&
                c.constraints?.maxHeight == 32.0,
          )
          .toList();

      expect(pillContainers.length, 2);
    });
  });
}
