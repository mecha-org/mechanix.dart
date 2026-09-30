import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('Menu Theme & Config Tests', () {
    test('MenuThemeDataConfig copyWith preserves and overrides values', () {
      const config = MenuThemeDataConfig(
        backgroundColor: Colors.black,
        elevation: 4.0,
        borderWidth: 0.0,
      );

      final copy = config.copyWith(
        backgroundColor: Colors.white,
        elevation: 8.0,
      );

      expect(copy.backgroundColor, equals(Colors.white));
      expect(copy.elevation, equals(8.0));
      expect(copy.borderWidth, equals(0.0));
    });

    test('MenuThemeDataConfig merge works correctly', () {
      const base = MenuThemeDataConfig(
        backgroundColor: Colors.black,
        elevation: 2.0,
      );
      const override = MenuThemeDataConfig(elevation: 6.0, borderWidth: 1.0);

      final merged = base.merge(override);
      expect(merged.backgroundColor, equals(Colors.black));
      expect(merged.elevation, equals(6.0));
      expect(merged.borderWidth, equals(1.0));

      expect(base.merge(null), equals(base));
    });

    test('MenuThemeDataConfig lerp interpolates between configurations', () {
      const a = MenuThemeDataConfig(
        backgroundColor: Color(0xFF000000),
        elevation: 0.0,
        borderWidth: 0.0,
        regularItemHeight: 40.0,
      );
      const b = MenuThemeDataConfig(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 10.0,
        borderWidth: 2.0,
        regularItemHeight: 50.0,
      );

      final half = a.lerp(b, 0.5);
      expect(
        half.backgroundColor,
        equals(
          Color.lerp(const Color(0xFF000000), const Color(0xFFFFFFFF), 0.5),
        ),
      );
      expect(half.elevation, equals(5.0));
      expect(half.borderWidth, equals(1.0));
      expect(half.regularItemHeight, equals(45.0));

      expect(a.lerp(null, 0.5), equals(a));
    });

    test('MenuThemeDataConfig equality and hashCode', () {
      const a = MenuThemeDataConfig(
        backgroundColor: Colors.black,
        elevation: 4.0,
      );
      const b = MenuThemeDataConfig(
        backgroundColor: Colors.black,
        elevation: 4.0,
      );
      const c = MenuThemeDataConfig(
        backgroundColor: Colors.white,
        elevation: 4.0,
      );

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
      expect(a == c, isFalse);
    });

    test('resolveItemHeight, resolveIconSize, resolveLabelStyle return correct values', () {
      const config = MenuThemeDataConfig(
        regularItemHeight: 48.0,
        smallItemHeight: 32.0,
        regularIconSize: 24.0,
        smallIconSize: 16.0,
      );

      expect(config.resolveItemHeight(MechanixMenuSize.regular), equals(48.0));
      expect(config.resolveItemHeight(MechanixMenuSize.small), equals(32.0));
      expect(config.resolveIconSize(MechanixMenuSize.regular), equals(24.0));
      expect(config.resolveIconSize(MechanixMenuSize.small), equals(16.0));
      expect(
        config.resolveLabelStyle(MechanixMenuSize.regular).fontSize,
        equals(14.0),
      );
      expect(
        config.resolveLabelStyle(MechanixMenuSize.small).fontSize,
        equals(12.0),
      );
    });

    testWidgets('MechanixMenuTheme provides config to descendants', (
      tester,
    ) async {
      const customConfig = MenuThemeDataConfig(
        backgroundColor: Colors.amber,
        elevation: 12.0,
      );

      late MenuThemeDataConfig resolved;

      await tester.pumpWidget(
        MaterialApp(
          home: MechanixMenuTheme(
            data: customConfig,
            child: Builder(
              builder: (context) {
                resolved = MechanixMenuTheme.of(context);
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      expect(resolved.backgroundColor, equals(Colors.amber));
      expect(resolved.elevation, equals(12.0));
    });

    test('MechanixTheme.light and dark include MenuThemeDataConfig', () {
      final lightExt = MechanixTheme.light.extension<MenuThemeDataConfig>();
      final darkExt = MechanixTheme.dark.extension<MenuThemeDataConfig>();

      expect(lightExt, isNotNull);
      expect(darkExt, isNotNull);
      expect(lightExt!.borderWidth, equals(0.0));
      expect(darkExt!.borderWidth, equals(0.0));
      expect(lightExt.minTapTargetSize, equals(48.0));
      expect(darkExt.minTapTargetSize, equals(48.0));
    });
  });

  group('Menu Entries Tests', () {
    test('MechanixMenuItem creates with valid parameters', () {
      const item = MechanixMenuItem<String>(
        value: 'cut',
        labelText: 'Cut',
        leadingIcon: Icons.cut,
        trailingText: '⌘X',
        enabled: true,
        selected: false,
      );

      expect(item.value, equals('cut'));
      expect(item.labelText, equals('Cut'));
      expect(item.label, isNull);
      expect(item.leadingIcon, equals(Icons.cut));
      expect(item.trailingText, equals('⌘X'));
      expect(item.enabled, isTrue);
      expect(item.selected, isFalse);
    });

    test('MechanixMenuItem creates with custom label Widget', () {
      const customLabel = Text('Custom Label');
      const item = MechanixMenuItem<String>(
        value: 'custom',
        label: customLabel,
      );

      expect(item.value, equals('custom'));
      expect(item.label, equals(customLabel));
      expect(item.labelText, isNull);
    });

    test('MechanixMenuItem asserts when neither label nor labelText is provided', () {
      expect(
        () => MechanixMenuItem<String>(
          value: 'test',
        ),
        throwsAssertionError,
      );
    });

    test(
      'MechanixMenuItem asserts when both leading and leadingIcon are provided',
      () {
        expect(
          () => MechanixMenuItem<String>(
            value: 'test',
            labelText: 'Test',
            leading: const Icon(Icons.star),
            leadingIcon: Icons.star,
          ),
          throwsAssertionError,
        );
      },
    );

    test('MechanixMenuItem asserts when both trailing and trailingIcon are provided', () {
      expect(
        () => MechanixMenuItem<String>(
          value: 'test',
          labelText: 'Test',
          trailing: const Icon(Icons.star),
          trailingIcon: Icons.star,
        ),
        throwsAssertionError,
      );
    });

    test('MechanixMenuDivider and MechanixMenuCustomEntry extend MechanixMenuEntry<Never>', () {
      // Must compile and be assignable to a list of typed entries without type annotations
      final entries = <MechanixMenuEntry<int>>[
        const MechanixMenuItem(value: 1, labelText: 'One'),
        const MechanixMenuDivider(),
        MechanixMenuCustomEntry(builder: (context) => const Text('Custom')),
        const MechanixMenuItem(value: 2, labelText: 'Two'),
      ];

      expect(entries.length, equals(4));
      expect(entries[1], isA<MechanixMenuDivider>());
      expect(entries[2], isA<MechanixMenuCustomEntry>());
    });

    test(
      'MechanixMenuGroup asserts when both header and headerText are provided',
      () {
        expect(
          () => MechanixMenuGroup<String>(
            header: const Text('Header'),
            headerText: 'Header',
            entries: const [],
          ),
          throwsAssertionError,
        );
      },
    );

    test('MechanixMenuGroup holds grouped entries and properties', () {
      final group = MechanixMenuGroup<String>(
        headerText: 'ACTIONS',
        showDivider: true,
        backgroundColor: Colors.grey,
        entries: const [
          MechanixMenuItem(value: '1', labelText: 'Item 1'),
          MechanixMenuItem(value: '2', labelText: 'Item 2'),
        ],
      );

      expect(group.headerText, equals('ACTIONS'));
      expect(group.showDivider, isTrue);
      expect(group.backgroundColor, equals(Colors.grey));
      expect(group.entries.length, equals(2));
    });
  });
}
