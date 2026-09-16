import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixAppBar Component Tests', () {
    testWidgets('renders small variant with title, leading, and actions', (
      tester,
    ) async {
      var backTapped = false;
      var actionTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            appBar: MechanixAppBar.small(
              title: const Text('Small Title'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => backTapped = true,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => actionTapped = true,
                ),
              ],
            ),
            body: const Center(child: Text('Body Content')),
          ),
        ),
      );

      expect(find.text('Small Title'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back));
      expect(backTapped, isTrue);

      await tester.tap(find.byIcon(Icons.search));
      expect(actionTapped, isTrue);
    });

    testWidgets('small variant has preferred height of 64.0 dp', (
      tester,
    ) async {
      const appBar = MechanixAppBar.small(title: Text('Title'));
      expect(appBar.preferredSize.height, equals(64.0));
    });

    testWidgets('medium variant has preferred height of 112.0 dp', (
      tester,
    ) async {
      const appBar = MechanixAppBar.medium(title: Text('Medium Title'));
      expect(appBar.preferredSize.height, equals(112.0));
    });

    testWidgets('large variant has preferred height of 120.0 dp', (
      tester,
    ) async {
      const appBar = MechanixAppBar.large(title: Text('Large Title'));
      expect(appBar.preferredSize.height, equals(120.0));
    });

    testWidgets('search variant has preferred height of 64.0 dp', (
      tester,
    ) async {
      const appBar = MechanixAppBar.search();
      expect(appBar.preferredSize.height, equals(64.0));
    });

    testWidgets(
      'renders medium variant with two-row layout and headlineMedium',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: Scaffold(
              appBar: MechanixAppBar.medium(
                title: const Text('Headline Medium'),
                leading: const BackButton(),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
              body: const SizedBox(),
            ),
          ),
        );

        expect(find.text('Headline Medium'), findsOneWidget);
        expect(find.byType(BackButton), findsOneWidget);
        expect(find.byIcon(Icons.more_vert), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);

        // Verify typography
        final textWidget = tester.widget<Text>(find.text('Headline Medium'));
        expect(textWidget.data, equals('Headline Medium'));
      },
    );

    testWidgets('renders large variant with two-row layout and displayMedium', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            appBar: MechanixAppBar.large(
              title: const Text('Display Medium'),
              leading: const BackButton(),
            ),
            body: const SizedBox(),
          ),
        ),
      );

      expect(find.text('Display Medium'), findsOneWidget);
      expect(find.byType(BackButton), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('renders search variant with TextField and interactions', (
      tester,
    ) async {
      String changedText = '';
      String submittedText = '';

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            appBar: MechanixAppBar.search(
              searchHint: 'Search settings',
              onSearchChanged: (val) => changedText = val,
              onSearchSubmitted: (val) => submittedText = val,
            ),
            body: const SizedBox(),
          ),
        ),
      );

      expect(find.text('Search settings'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'bluetooth');
      expect(changedText, equals('bluetooth'));

      await tester.testTextInput.receiveAction(TextInputAction.done);
      expect(submittedText, equals('bluetooth'));
    });

    testWidgets('renders search variant with custom search widget', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            appBar: MechanixAppBar.search(
              searchWidget: Container(
                key: const Key('custom_search'),
                child: const Text('Custom Search Box'),
              ),
            ),
            body: const SizedBox(),
          ),
        ),
      );

      expect(find.byKey(const Key('custom_search')), findsOneWidget);
      expect(find.text('Custom Search Box'), findsOneWidget);
    });

    testWidgets('preferred height accounts for bottom widget', (tester) async {
      const bottomWidget = PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: SizedBox(height: 48.0),
      );

      const smallWithBottom = MechanixAppBar.small(
        title: Text('Tabbed'),
        bottom: bottomWidget,
      );
      expect(smallWithBottom.preferredSize.height, equals(64.0 + 48.0));

      const mediumWithBottom = MechanixAppBar.medium(
        title: Text('Medium Tabbed'),
        bottom: bottomWidget,
      );
      expect(mediumWithBottom.preferredSize.height, equals(112.0 + 48.0));

      const largeWithBottom = MechanixAppBar.large(
        title: Text('Large Tabbed'),
        bottom: bottomWidget,
      );
      expect(largeWithBottom.preferredSize.height, equals(120.0 + 48.0));
    });

    testWidgets(
      'renders all variants standalone outside Scaffold without layout errors',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: SingleChildScrollView(
              child: Column(
                children: const [
                  MechanixAppBar.small(
                    primary: false,
                    title: Text('Standalone Small'),
                  ),
                  MechanixAppBar.medium(
                    primary: false,
                    title: Text('Standalone Medium'),
                  ),
                  MechanixAppBar.large(
                    primary: false,
                    title: Text('Standalone Large'),
                  ),
                  MechanixAppBar.search(primary: false),
                  MechanixAppBar.small(
                    primary: false,
                    title: Text('Standalone With Bottom'),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(48),
                      child: SizedBox(height: 48),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Standalone Small'), findsOneWidget);
        expect(find.text('Standalone Medium'), findsOneWidget);
        expect(find.text('Standalone Large'), findsOneWidget);
        expect(find.text('Standalone With Bottom'), findsOneWidget);
        expect(find.byType(AppBar), findsNWidgets(5));
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('actions and actionsPadding passed to native AppBar', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: Scaffold(
            appBar: MechanixAppBar.small(
              title: const Text('With Actions'),
              actionsPadding: const EdgeInsets.symmetric(horizontal: 12),
              actions: [
                IconButton(icon: const Icon(Icons.share), onPressed: () {}),
              ],
            ),
            body: const SizedBox(),
          ),
        ),
      );

      final appBarWidget = tester.widget<AppBar>(find.byType(AppBar));
      expect(
        appBarWidget.actionsPadding,
        equals(const EdgeInsets.symmetric(horizontal: 12)),
      );
      expect(find.byIcon(Icons.share), findsOneWidget);
    });
  });

  group('AppBarThemeDataConfig & MechanixAppBarTheme Tests', () {
    test('theme configuration equality, copyWith, and merge', () {
      const config1 = AppBarThemeDataConfig(
        toolbarHeight: 64.0,
        centerTitle: false,
      );
      const config2 = AppBarThemeDataConfig(
        toolbarHeight: 64.0,
        centerTitle: false,
      );

      expect(config1, equals(config2));
      expect(config1.hashCode, equals(config2.hashCode));

      final updated = config1.copyWith(toolbarHeight: 72.0);
      expect(updated.toolbarHeight, equals(72.0));
      expect(updated.centerTitle, isFalse);

      final merged = config1.merge(
        const AppBarThemeDataConfig(centerTitle: true),
      );
      expect(merged.centerTitle, isTrue);
      expect(merged.toolbarHeight, equals(64.0));
    });

    testWidgets(
      'MechanixAppBarTheme provides scoped styling to child app bars',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MechanixTheme.dark,
            home: MechanixAppBarTheme(
              data: const AppBarThemeDataConfig(backgroundColor: Colors.red),
              child: const Scaffold(
                appBar: MechanixAppBar.small(title: Text('Scoped Red')),
                body: SizedBox(),
              ),
            ),
          ),
        );

        final appBarWidget = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBarWidget.backgroundColor, equals(Colors.red));
      },
    );
  });
}
