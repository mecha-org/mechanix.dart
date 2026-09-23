import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixIconButton Widget Tests', () {
    testWidgets('renders all 4 icon button variants', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                MechanixIconButton.filled(icon: Icons.add, onPressed: () {}),
                MechanixIconButton.tonal(icon: Icons.edit, onPressed: () {}),
                MechanixIconButton.outline(
                  icon: Icons.delete,
                  onPressed: () {},
                ),
                MechanixIconButton.standard(
                  icon: Icons.share,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
      expect(find.byIcon(Icons.share), findsOneWidget);
    });

    testWidgets('verifies icon sizes and dimensions across scale sizes', (
      WidgetTester tester,
    ) async {
      final specs = [
        (IconButtonSize.xSmall, 32.0, 20.0),
        (IconButtonSize.small, 40.0, 24.0),
        (IconButtonSize.medium, 56.0, 24.0),
        (IconButtonSize.large, 72.0, 30.86),
        (IconButtonSize.xLarge, 96.0, 32.0),
        (IconButtonSize.xxLarge, 136.0, 40.0),
      ];

      for (final spec in specs) {
        final sizeEnum = spec.$1;
        final expectedDim = spec.$2;
        final expectedIconSize = spec.$3;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: MechanixIconButton(
                  size: sizeEnum,
                  icon: Icons.star,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        final sizedBoxFinder = find
            .ancestor(
              of: find.byIcon(Icons.star),
              matching: find.byType(SizedBox),
            )
            .first;
        final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
        expect(sizedBox.width, equals(expectedDim));
        expect(sizedBox.height, equals(expectedDim));

        final iconWidget = tester.widget<Icon>(find.byIcon(Icons.star));
        expect(iconWidget.size, equals(expectedIconSize));
      }
    });

    testWidgets('enforces minimum 48x48 tap target on xSmall and small sizes', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                MechanixIconButton(
                  size: IconButtonSize.xSmall,
                  icon: Icons.check,
                  onPressed: () {},
                ),
                MechanixIconButton(
                  size: IconButtonSize.small,
                  icon: Icons.close,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      final checkConstrainedBox = tester.widget<ConstrainedBox>(
        find
            .ancestor(
              of: find.byIcon(Icons.check),
              matching: find.byType(ConstrainedBox),
            )
            .last,
      );
      expect(checkConstrainedBox.constraints.minWidth, equals(48.0));
      expect(checkConstrainedBox.constraints.minHeight, equals(48.0));

      final closeConstrainedBox = tester.widget<ConstrainedBox>(
        find
            .ancestor(
              of: find.byIcon(Icons.close),
              matching: find.byType(ConstrainedBox),
            )
            .last,
      );
      expect(closeConstrainedBox.constraints.minWidth, equals(48.0));
      expect(closeConstrainedBox.constraints.minHeight, equals(48.0));
    });

    testWidgets('handles tap and long press events when enabled', (
      WidgetTester tester,
    ) async {
      var tapped = false;
      var longPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixIconButton(
              icon: Icons.thumb_up,
              onPressed: () => tapped = true,
              onLongPress: () => longPressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.thumb_up));
      expect(tapped, isTrue);

      await tester.longPress(find.byIcon(Icons.thumb_up));
      expect(longPressed, isTrue);
    });

    testWidgets('respects disabled state when onPressed is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MechanixIconButton(icon: Icons.block, onPressed: null),
          ),
        ),
      );

      final button = tester.widget<IconButton>(find.byType(IconButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('resolves focused border for all variants when focused', (
      WidgetTester tester,
    ) async {
      final focusNode = FocusNode();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixIconButton.filled(
              icon: Icons.star,
              focusNode: focusNode,
              autofocus: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      final iconButton = tester.widget<IconButton>(find.byType(IconButton));
      final side = iconButton.style?.side?.resolve({WidgetState.focused});
      expect(side, isNotNull);
      expect(side?.width, equals(3.0));
    });

    testWidgets(
      'standard icon button has no border by default and 3px border only when focused',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MechanixIconButton.standard(
                icon: Icons.star,
                onPressed: () {},
              ),
            ),
          ),
        );

        final iconButton = tester.widget<IconButton>(find.byType(IconButton));
        final defaultSide = iconButton.style?.side?.resolve({});
        final focusedSide = iconButton.style?.side?.resolve({
          WidgetState.focused,
        });

        expect(defaultSide, isNull);
        expect(focusedSide, isNotNull);
        expect(focusedSide?.width, equals(3.0));
      },
    );

    testWidgets('verifies 48x48 min tap target for xSmall icon button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixIconButton(
              size: IconButtonSize.xSmall, // 32x32 visual
              icon: Icons.check,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Find the outer ConstrainedBox wrapping the MechanixIconButton
      final constrainedBox = tester.widget<ConstrainedBox>(
        find
            .ancestor(
              of: find.byIcon(Icons.check),
              matching: find.byType(ConstrainedBox),
            )
            .last,
      );

      // Verify the tap target constraints are at least 48x48
      expect(constrainedBox.constraints.minWidth, equals(48.0));
      expect(constrainedBox.constraints.minHeight, equals(48.0));
    });

    testWidgets('verifies 48x48 min tap target for small icon button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixIconButton(
              size: IconButtonSize.small, // 40X40 visual
              icon: Icons.check,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Find the outer ConstrainedBox wrapping the button
      final constrainedBox = tester.widget<ConstrainedBox>(
        find
            .ancestor(
              of: find.byIcon(Icons.check),
              matching: find.byType(ConstrainedBox),
            )
            .last,
      );

      // Verify the tap target constraints are at least 48x48
      expect(constrainedBox.constraints.minWidth, equals(48.0));
      expect(constrainedBox.constraints.minHeight, equals(48.0));
    });

    testWidgets('resolves state-aware colors from IconButtonThemeDataConfig WidgetStateProperty', (
      WidgetTester tester,
    ) async {
      final themeConfig = IconButtonThemeDataConfig(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return Colors.grey;
          if (states.contains(WidgetState.hovered)) return Colors.blue;
          return Colors.purple;
        }),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixIconButtonTheme(
              data: themeConfig,
              child: MechanixIconButton.filled(
                icon: Icons.star,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      final iconButton = tester.widget<IconButton>(find.byType(IconButton));
      final resolvedNormal = iconButton.style?.backgroundColor?.resolve({});
      final resolvedDisabled = iconButton.style?.backgroundColor?.resolve({WidgetState.disabled});

      expect(resolvedNormal, equals(Colors.purple));
      expect(resolvedDisabled, equals(Colors.grey));
    });

    testWidgets('resolves state-aware side from IconButtonThemeDataConfig WidgetStateProperty', (
      WidgetTester tester,
    ) async {
      final themeConfig = IconButtonThemeDataConfig(
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return const BorderSide(color: Colors.red, width: 4.0);
          }
          return const BorderSide(color: Colors.green, width: 2.0);
        }),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixIconButtonTheme(
              data: themeConfig,
              child: MechanixIconButton.filled(
                icon: Icons.star,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      final iconButton = tester.widget<IconButton>(find.byType(IconButton));
      final resolvedNormalSide = iconButton.style?.side?.resolve({});
      final resolvedFocusedSide = iconButton.style?.side?.resolve({WidgetState.focused});

      expect(resolvedNormalSide?.color, equals(Colors.green));
      expect(resolvedNormalSide?.width, equals(2.0));
      expect(resolvedFocusedSide?.color, equals(Colors.red));
      expect(resolvedFocusedSide?.width, equals(4.0));
    });

    testWidgets('unselected -> selected color transitions across all 4 variants', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return Column(
                  children: [
                    MechanixIconButton.filled(
                      key: const Key('filled_unselected'),
                      isSelected: false,
                      icon: Icons.star,
                      onPressed: () {},
                    ),
                    MechanixIconButton.filled(
                      key: const Key('filled_selected'),
                      isSelected: true,
                      icon: Icons.star,
                      onPressed: () {},
                    ),
                    MechanixIconButton.tonal(
                      key: const Key('tonal_unselected'),
                      isSelected: false,
                      icon: Icons.star,
                      onPressed: () {},
                    ),
                    MechanixIconButton.tonal(
                      key: const Key('tonal_selected'),
                      isSelected: true,
                      icon: Icons.star,
                      onPressed: () {},
                    ),
                    MechanixIconButton.outline(
                      key: const Key('outline_unselected'),
                      isSelected: false,
                      icon: Icons.star,
                      onPressed: () {},
                    ),
                    MechanixIconButton.outline(
                      key: const Key('outline_selected'),
                      isSelected: true,
                      icon: Icons.star,
                      onPressed: () {},
                    ),
                    MechanixIconButton.standard(
                      key: const Key('standard_unselected'),
                      isSelected: false,
                      icon: Icons.star,
                      onPressed: () {},
                    ),
                    MechanixIconButton.standard(
                      key: const Key('standard_selected'),
                      isSelected: true,
                      icon: Icons.star,
                      onPressed: () {},
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      final BuildContext context = tester.element(find.byType(Scaffold));
      final scheme = Theme.of(context).colorScheme;

      // Filled
      final filledUnsel = tester.widget<IconButton>(
        find.descendant(
          of: find.byKey(const Key('filled_unselected')),
          matching: find.byType(IconButton),
        ),
      );
      final filledSel = tester.widget<IconButton>(
        find.descendant(
          of: find.byKey(const Key('filled_selected')),
          matching: find.byType(IconButton),
        ),
      );
      expect(filledUnsel.style?.backgroundColor?.resolve({}), equals(scheme.secondary));
      expect(filledUnsel.style?.foregroundColor?.resolve({}), equals(scheme.primary));
      expect(filledSel.style?.backgroundColor?.resolve({WidgetState.selected}), equals(scheme.primary));
      expect(filledSel.style?.foregroundColor?.resolve({WidgetState.selected}), equals(scheme.onSurface));

      // Tonal
      final tonalUnsel = tester.widget<IconButton>(
        find.descendant(
          of: find.byKey(const Key('tonal_unselected')),
          matching: find.byType(IconButton),
        ),
      );
      final tonalSel = tester.widget<IconButton>(
        find.descendant(
          of: find.byKey(const Key('tonal_selected')),
          matching: find.byType(IconButton),
        ),
      );
      expect(tonalUnsel.style?.backgroundColor?.resolve({}), equals(scheme.secondary));
      expect(tonalUnsel.style?.foregroundColor?.resolve({}), equals(scheme.onSecondaryFixed));
      expect(tonalSel.style?.backgroundColor?.resolve({WidgetState.selected}), equals(scheme.secondaryContainer));
      expect(tonalSel.style?.foregroundColor?.resolve({WidgetState.selected}), equals(scheme.onSecondaryContainer));

      // Outline
      final outlineUnsel = tester.widget<IconButton>(
        find.descendant(
          of: find.byKey(const Key('outline_unselected')),
          matching: find.byType(IconButton),
        ),
      );
      final outlineSel = tester.widget<IconButton>(
        find.descendant(
          of: find.byKey(const Key('outline_selected')),
          matching: find.byType(IconButton),
        ),
      );
      expect(outlineUnsel.style?.backgroundColor?.resolve({}), equals(scheme.secondary));
      expect(outlineUnsel.style?.side?.resolve({})?.color, equals(scheme.outline));
      expect(outlineSel.style?.backgroundColor?.resolve({WidgetState.selected}), equals(scheme.inverseSurface));
      expect(outlineSel.style?.foregroundColor?.resolve({WidgetState.selected}), equals(scheme.onInverseSurface));
      expect(outlineSel.style?.side?.resolve({WidgetState.selected}), isNull);

      // Standard
      final standardUnsel = tester.widget<IconButton>(
        find.descendant(
          of: find.byKey(const Key('standard_unselected')),
          matching: find.byType(IconButton),
        ),
      );
      final standardSel = tester.widget<IconButton>(
        find.descendant(
          of: find.byKey(const Key('standard_selected')),
          matching: find.byType(IconButton),
        ),
      );
      expect(standardUnsel.style?.backgroundColor?.resolve({}), equals(Colors.transparent));
      expect(standardUnsel.style?.foregroundColor?.resolve({}), equals(scheme.onSecondaryFixed));
      expect(standardSel.style?.backgroundColor?.resolve({WidgetState.selected}), equals(Colors.transparent));
      expect(standardSel.style?.foregroundColor?.resolve({WidgetState.selected}), equals(scheme.primary));
    });

    testWidgets('selectedIcon swap: shows selectedIcon when isSelected is true and falls back to icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                MechanixIconButton(
                  key: const Key('icon_unselected'),
                  isSelected: false,
                  icon: Icons.bookmark_border,
                  selectedIcon: Icons.bookmark,
                  onPressed: () {},
                ),
                MechanixIconButton(
                  key: const Key('icon_selected'),
                  isSelected: true,
                  icon: Icons.bookmark_border,
                  selectedIcon: Icons.bookmark,
                  onPressed: () {},
                ),
                MechanixIconButton(
                  key: const Key('fallback_selected'),
                  isSelected: true,
                  icon: Icons.star,
                  selectedIcon: null,
                  onPressed: () {},
                ),
                MechanixIconButton(
                  key: const Key('widget_selected'),
                  isSelected: true,
                  icon: const Text('UNSEL'),
                  selectedIcon: const Text('SEL'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      // Unselected shows bookmark_border
      expect(
        find.descendant(
          of: find.byKey(const Key('icon_unselected')),
          matching: find.byIcon(Icons.bookmark_border),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byKey(const Key('icon_unselected')),
          matching: find.byIcon(Icons.bookmark),
        ),
        findsNothing,
      );

      // Selected shows bookmark
      expect(
        find.descendant(
          of: find.byKey(const Key('icon_selected')),
          matching: find.byIcon(Icons.bookmark),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byKey(const Key('icon_selected')),
          matching: find.byIcon(Icons.bookmark_border),
        ),
        findsNothing,
      );

      // Selected with null selectedIcon falls back to icon
      expect(
        find.descendant(
          of: find.byKey(const Key('fallback_selected')),
          matching: find.byIcon(Icons.star),
        ),
        findsOneWidget,
      );

      // Selected with Widget displays selected Widget
      expect(
        find.descendant(
          of: find.byKey(const Key('widget_selected')),
          matching: find.text('SEL'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byKey(const Key('widget_selected')),
          matching: find.text('UNSEL'),
        ),
        findsNothing,
      );
    });

    testWidgets('disabled + isSelected combined respects disabled styling', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return Column(
                  children: [
                    const MechanixIconButton.filled(
                      key: Key('disabled_selected'),
                      isSelected: true,
                      icon: Icons.check,
                      onPressed: null,
                    ),
                    const MechanixIconButton.filled(
                      key: Key('custom_disabled_selected'),
                      isSelected: true,
                      icon: Icons.check,
                      disabledColor: Colors.amber,
                      disabledForegroundColor: Colors.teal,
                      onPressed: null,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      final BuildContext context = tester.element(find.byType(Scaffold));
      final scheme = Theme.of(context).colorScheme;

      final disabledBtn = tester.widget<IconButton>(
        find.descendant(
          of: find.byKey(const Key('disabled_selected')),
          matching: find.byType(IconButton),
        ),
      );

      final resolvedBg = disabledBtn.style?.backgroundColor?.resolve({
        WidgetState.disabled,
        WidgetState.selected,
      });
      final resolvedFg = disabledBtn.style?.foregroundColor?.resolve({
        WidgetState.disabled,
        WidgetState.selected,
      });

      // Disabled styling wins outright
      expect(resolvedBg, equals(scheme.onSurface.withValues(alpha: 0.10)));
      expect(resolvedFg, equals(scheme.onSurface.withValues(alpha: 0.38)));

      // Custom disabled color overrides win
      final customDisabledBtn = tester.widget<IconButton>(
        find.descendant(
          of: find.byKey(const Key('custom_disabled_selected')),
          matching: find.byType(IconButton),
        ),
      );
      expect(
        customDisabledBtn.style?.backgroundColor?.resolve({
          WidgetState.disabled,
          WidgetState.selected,
        }),
        equals(Colors.amber),
      );
      expect(
        customDisabledBtn.style?.foregroundColor?.resolve({
          WidgetState.disabled,
          WidgetState.selected,
        }),
        equals(Colors.teal),
      );
    });

    testWidgets('renders all 4 variants x both IconButtonType (square, rounded) with toggle state', (
      WidgetTester tester,
    ) async {
      for (final variant in IconButtonVariant.values) {
        for (final type in IconButtonType.values) {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: MechanixIconButton(
                  variant: variant,
                  type: type,
                  isSelected: true,
                  icon: Icons.touch_app,
                  selectedIcon: Icons.touch_app_outlined,
                  onPressed: () {},
                ),
              ),
            ),
          );

          final iconBtn = tester.widget<IconButton>(find.byType(IconButton));
          final shape = iconBtn.style?.shape?.resolve({WidgetState.selected}) as RoundedRectangleBorder?;
          expect(shape, isNotNull);

          if (type == IconButtonType.square) {
            expect(shape?.borderRadius, equals(BorderRadius.zero));
          } else {
            expect(shape?.borderRadius, equals(BorderRadius.circular(1000)));
          }

          expect(find.byIcon(Icons.touch_app_outlined), findsOneWidget);
        }
      }
    });

    testWidgets('resolves 3-tier theming hierarchy for selected color overrides', (
      WidgetTester tester,
    ) async {
      // Tier 1: Inherited theme
      final inheritedTheme = const IconButtonThemeDataConfig(
        selectedBackgroundColor: Colors.pink,
        selectedForegroundColor: Colors.yellow,
        selectedBorderColor: Colors.brown,
      );

      // Tier 2: Instance theme overriding Tier 1
      final instanceTheme = const IconButtonThemeDataConfig(
        selectedBackgroundColor: Colors.teal,
        selectedForegroundColor: Colors.lime,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixIconButtonTheme(
              data: inheritedTheme,
              child: Column(
                children: [
                  // Uses Tier 1 (Inherited theme)
                  MechanixIconButton(
                    key: const Key('tier1'),
                    isSelected: true,
                    icon: Icons.star,
                    onPressed: () {},
                  ),
                  // Uses Tier 2 (Instance theme overriding Tier 1)
                  MechanixIconButton(
                    key: const Key('tier2'),
                    isSelected: true,
                    theme: instanceTheme,
                    icon: Icons.star,
                    onPressed: () {},
                  ),
                  // Uses Tier 3 (Direct constructor params overriding Tier 1 and 2)
                  MechanixIconButton(
                    key: const Key('tier3'),
                    isSelected: true,
                    theme: instanceTheme,
                    selectedBackgroundColor: Colors.cyan,
                    selectedForegroundColor: Colors.orange,
                    selectedBorderColor: Colors.deepPurple,
                    icon: Icons.star,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Tier 1 check
      final btn1 = tester.widget<IconButton>(
        find.descendant(
          of: find.byKey(const Key('tier1')),
          matching: find.byType(IconButton),
        ),
      );
      expect(btn1.style?.backgroundColor?.resolve({WidgetState.selected}), equals(Colors.pink));
      expect(btn1.style?.foregroundColor?.resolve({WidgetState.selected}), equals(Colors.yellow));
      expect(btn1.style?.side?.resolve({WidgetState.selected})?.color, equals(Colors.brown));

      // Tier 2 check
      final btn2 = tester.widget<IconButton>(
        find.descendant(
          of: find.byKey(const Key('tier2')),
          matching: find.byType(IconButton),
        ),
      );
      expect(btn2.style?.backgroundColor?.resolve({WidgetState.selected}), equals(Colors.teal));
      expect(btn2.style?.foregroundColor?.resolve({WidgetState.selected}), equals(Colors.lime));
      // selectedBorderColor falls back to Tier 1 since Tier 2 didn't specify it
      expect(btn2.style?.side?.resolve({WidgetState.selected})?.color, equals(Colors.brown));

      // Tier 3 check
      final btn3 = tester.widget<IconButton>(
        find.descendant(
          of: find.byKey(const Key('tier3')),
          matching: find.byType(IconButton),
        ),
      );
      expect(btn3.style?.backgroundColor?.resolve({WidgetState.selected}), equals(Colors.cyan));
      expect(btn3.style?.foregroundColor?.resolve({WidgetState.selected}), equals(Colors.orange));
      expect(btn3.style?.side?.resolve({WidgetState.selected})?.color, equals(Colors.deepPurple));
    });

    testWidgets('focus indicator still shows correctly when isSelected == true across all variants', (
      WidgetTester tester,
    ) async {
      for (final variant in IconButtonVariant.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MechanixIconButton(
                variant: variant,
                isSelected: true,
                icon: Icons.alarm,
                selectedIcon: Icons.timer,
                showFocusIndicator: true,
                onPressed: () {},
              ),
            ),
          ),
        );

        final iconBtn = tester.widget<IconButton>(find.byType(IconButton));
        final focusedSide = iconBtn.style?.side?.resolve({
          WidgetState.selected,
          WidgetState.focused,
        });

        expect(
          focusedSide,
          isNotNull,
          reason: 'Variant $variant should have a focused border when isSelected is true',
        );
        expect(
          focusedSide?.width,
          equals(3.0),
          reason: 'Variant $variant focused border width should be 3.0 when isSelected is true',
        );
      }
    });

    testWidgets('verifies toggle button dimensions and icon sizes across spec fixture sizes (medium, xLarge, xxLarge)', (
      WidgetTester tester,
    ) async {
      // Spec fixtures:
      // - Medium: 56 x 56 (matches IconButtonSize.medium: dimension=56, iconSize=24)
      // - Large: 96 x 96 (maps to codebase IconButtonSize.xLarge: dimension=96, iconSize=32)
      // - XLarge: 136 x 136 (maps to codebase IconButtonSize.xxLarge: dimension=136, iconSize=40)
      // (Also testing IconButtonSize.large: 72x72, iconSize 30.86)
      const fixtures = [
        (IconButtonSize.medium, 56.0, 24.0),
        (IconButtonSize.large, 72.0, 30.86),
        (IconButtonSize.xLarge, 96.0, 32.0),
        (IconButtonSize.xxLarge, 136.0, 40.0),
      ];

      for (final (size, expectedDimension, expectedIconSize) in fixtures) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MechanixIconButton(
                size: size,
                type: IconButtonType.square,
                isSelected: true,
                icon: Icons.alarm,
                selectedIcon: Icons.timer,
                onPressed: () {},
              ),
            ),
          ),
        );

        final sizedBoxFinder = find.byWidgetPredicate(
          (widget) =>
              widget is SizedBox &&
              widget.width == expectedDimension &&
              widget.height == expectedDimension,
        );
        expect(
          sizedBoxFinder,
          findsOneWidget,
          reason: 'Size $size should have dimension $expectedDimension x $expectedDimension',
        );

        final icon = tester.widget<Icon>(find.byIcon(Icons.timer));
        expect(
          icon.size,
          equals(expectedIconSize),
          reason: 'Size $size should have icon size $expectedIconSize',
        );
      }
    });

    testWidgets('parent state toggling updates MechanixIconButton reactively with Alarm/ClockCountdown icon pair', (
      WidgetTester tester,
    ) async {
      bool isSelected = false;

      // Spec uses Alarm and ClockCountdown pair
      const alarmIcon = Icons.alarm;
      const clockCountdownIcon = Icons.timer;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MechanixIconButton(
                  isSelected: isSelected,
                  icon: alarmIcon,
                  selectedIcon: clockCountdownIcon,
                  onPressed: () {
                    setState(() {
                      isSelected = !isSelected;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      // Initially unselected (Alarm icon visible)
      expect(find.byIcon(alarmIcon), findsOneWidget);
      expect(find.byIcon(clockCountdownIcon), findsNothing);

      // Tap to toggle
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      // Now selected (ClockCountdown icon visible)
      expect(find.byIcon(clockCountdownIcon), findsOneWidget);
      expect(find.byIcon(alarmIcon), findsNothing);

      // Tap again to untoggle
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      // Back to unselected (Alarm icon visible)
      expect(find.byIcon(alarmIcon), findsOneWidget);
      expect(find.byIcon(clockCountdownIcon), findsNothing);
    });
  });
}
