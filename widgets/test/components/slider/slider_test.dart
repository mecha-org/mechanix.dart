import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

/// Track length used by the harness: 206px wide leaves a 202px track once the
/// 4px pointer is accounted for, with value 0 at x=2 and value 100 at x=204.
const double _length = 206;

Widget _harness(
  Widget slider, {
  ThemeData? theme,
  TextDirection textDirection = TextDirection.ltr,
  Axis direction = Axis.horizontal,
}) {
  return MaterialApp(
    theme: theme ?? MechanixTheme.light,
    home: Directionality(
      textDirection: textDirection,
      child: Scaffold(
        body: Center(
          child: direction == Axis.horizontal
              ? SizedBox(width: _length, child: slider)
              : SizedBox(height: _length, child: slider),
        ),
      ),
    ),
  );
}

/// A slider that keeps its own value and records callbacks.
class _SliderHost extends StatefulWidget {
  const _SliderHost({
    this.initial = 0,
    this.divisions,
    this.direction = Axis.horizontal,
    this.focusNode,
    this.log,
  });

  final double initial;
  final int? divisions;
  final Axis direction;
  final FocusNode? focusNode;
  final List<String>? log;

  @override
  State<_SliderHost> createState() => _SliderHostState();
}

class _SliderHostState extends State<_SliderHost> {
  late double value = widget.initial;

  @override
  Widget build(BuildContext context) {
    return MechanixSlider(
      value: value,
      divisions: widget.divisions,
      direction: widget.direction,
      focusNode: widget.focusNode,
      onChangeStart: (v) => widget.log?.add('start ${v.round()}'),
      onChanged: (v) => setState(() => value = v),
      onChangeEnd: (v) => widget.log?.add('end ${v.round()}'),
    );
  }
}

double _valueOf(WidgetTester tester) =>
    tester.widget<MechanixSlider>(find.byType(MechanixSlider)).value;

/// Matches a `drawRect` with [color], skipping any other paint calls before it.
///
/// Compares 8-bit ARGB values because [Paint] stores colors at that precision.
bool Function(Symbol, List<dynamic>) _rectColored(Color color) =>
    (method, args) =>
        method == #drawRect &&
        (args[1] as Paint).color.toARGB32() == color.toARGB32();

/// Matches a `drawRawPoints` run of ticks, optionally with exactly [count]
/// ticks and with [color], skipping any other paint calls before it.
bool Function(Symbol, List<dynamic>) _ticks({int? count, Color? color}) =>
    (method, args) =>
        method == #drawRawPoints &&
        (count == null || (args[1] as Float32List).length == count * 4) &&
        (color == null ||
            (args[2] as Paint).color.toARGB32() == color.toARGB32());

/// Presses the center of the slider so its pointer is painted.
Future<TestGesture> _press(WidgetTester tester) async {
  final gesture = await tester.startGesture(
    tester.getCenter(find.byType(MechanixSlider)),
  );
  await tester.pump();
  return gesture;
}

Finder get _paint => find.descendant(
  of: find.byType(MechanixSlider),
  matching: find.byType(CustomPaint),
);

void main() {
  group('MechanixSlider Size Tests', () {
    const expected = {
      MechanixSliderSize.xSmall: (16.0, 32.0),
      MechanixSliderSize.small: (24.0, 36.0),
      MechanixSliderSize.medium: (40.0, 52.0),
      MechanixSliderSize.large: (56.0, 68.0),
      MechanixSliderSize.xLarge: (96.0, 108.0),
    };

    test('size tokens match the Mechanix specification', () {
      for (final entry in expected.entries) {
        final config = SliderSizeConfig.of(entry.key);
        expect(config.barHeight, entry.value.$1, reason: '${entry.key}');
        expect(config.pointerHeight, entry.value.$2, reason: '${entry.key}');
        expect(config.tickWidth, 2);
        expect(config.tickGap, 4);
      }
    });

    testWidgets('horizontal slider is as tall as the pointer', (tester) async {
      for (final entry in expected.entries) {
        await tester.pumpWidget(
          _harness(
            MechanixSlider(value: 50, size: entry.key, onChanged: (_) {}),
          ),
        );
        expect(
          tester.getSize(find.byType(MechanixSlider)),
          Size(_length, entry.value.$2),
        );
      }
    });

    testWidgets('vertical slider is as wide as the pointer', (tester) async {
      for (final entry in expected.entries) {
        await tester.pumpWidget(
          _harness(
            MechanixSlider(
              value: 50,
              size: entry.key,
              direction: Axis.vertical,
              onChanged: (_) {},
            ),
            direction: Axis.vertical,
          ),
        );
        expect(
          tester.getSize(find.byType(MechanixSlider)),
          Size(entry.value.$2, _length),
        );
      }
    });
  });

  group('MechanixSlider Interaction Tests', () {
    testWidgets('tap jumps to the tapped value and reports start/end', (
      tester,
    ) async {
      final log = <String>[];
      await tester.pumpWidget(_harness(_SliderHost(log: log)));

      final rect = tester.getRect(find.byType(MechanixSlider));
      await tester.tapAt(rect.centerLeft + const Offset(_length / 2, 0));
      await tester.pump();

      expect(_valueOf(tester), closeTo(50, 0.5));
      expect(log, ['start 0', 'end 50']);
    });

    testWidgets('horizontal drag updates the value continuously', (
      tester,
    ) async {
      final log = <String>[];
      await tester.pumpWidget(_harness(_SliderHost(log: log)));

      final rect = tester.getRect(find.byType(MechanixSlider));
      final gesture = await tester.startGesture(rect.centerLeft);
      await gesture.moveBy(const Offset(50, 0));
      await gesture.moveBy(const Offset(60, 0));
      await tester.pump();
      final midValue = _valueOf(tester);
      expect(midValue, greaterThan(0));
      expect(midValue, lessThan(100));

      await gesture.moveTo(rect.centerRight + const Offset(40, 0));
      await gesture.up();
      await tester.pump();

      expect(_valueOf(tester), 100);
      expect(log.first, 'start 0');
      expect(log.last, 'end 100');
      expect(log.where((e) => e.startsWith('start')), hasLength(1));
    });

    testWidgets('vertical slider fills from the bottom', (tester) async {
      await tester.pumpWidget(
        _harness(
          const _SliderHost(direction: Axis.vertical),
          direction: Axis.vertical,
        ),
      );

      final rect = tester.getRect(find.byType(MechanixSlider));
      await tester.tapAt(rect.topCenter + const Offset(0, 3));
      await tester.pump();
      expect(_valueOf(tester), closeTo(100, 1));

      final gesture = await tester.startGesture(rect.topCenter);
      await gesture.moveTo(rect.bottomCenter + const Offset(0, 20));
      await gesture.up();
      await tester.pump();
      expect(_valueOf(tester), 0);
    });

    testWidgets('horizontal slider fills from the right in RTL', (
      tester,
    ) async {
      await tester.pumpWidget(
        _harness(const _SliderHost(), textDirection: TextDirection.rtl),
      );

      final rect = tester.getRect(find.byType(MechanixSlider));
      await tester.tapAt(rect.centerLeft + const Offset(3, 0));
      await tester.pump();
      expect(_valueOf(tester), closeTo(100, 1));
    });

    testWidgets('divisions snap the value to the nearest step', (tester) async {
      await tester.pumpWidget(_harness(const _SliderHost(divisions: 4)));

      final rect = tester.getRect(find.byType(MechanixSlider));
      // 40% of the track rounds to the 2nd of 4 steps.
      await tester.tapAt(rect.centerLeft + const Offset(2 + 202 * 0.4, 0));
      await tester.pump();
      expect(_valueOf(tester), 50);

      await tester.tapAt(rect.centerLeft + const Offset(2 + 202 * 0.1, 0));
      await tester.pump();
      expect(_valueOf(tester), 0);
    });

    testWidgets('disabled slider ignores taps and drags', (tester) async {
      await tester.pumpWidget(
        _harness(const MechanixSlider(value: 30, onChanged: null)),
      );

      final rect = tester.getRect(find.byType(MechanixSlider));
      await tester.tapAt(rect.center);
      await tester.dragFrom(rect.centerLeft, const Offset(150, 0));
      await tester.pump();

      expect(_valueOf(tester), 30);
      expect(tester.takeException(), isNull);
    });
  });

  group('MechanixSlider Keyboard Tests', () {
    testWidgets('arrow, page, home and end keys change the value', (
      tester,
    ) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await tester.pumpWidget(
        _harness(_SliderHost(initial: 50, focusNode: focusNode)),
      );
      focusNode.requestFocus();
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();
      expect(_valueOf(tester), 51);

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();
      expect(_valueOf(tester), 50);

      await tester.sendKeyEvent(LogicalKeyboardKey.pageUp);
      await tester.pump();
      expect(_valueOf(tester), 60);

      await tester.sendKeyEvent(LogicalKeyboardKey.end);
      await tester.pump();
      expect(_valueOf(tester), 100);

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
      await tester.pump();
      expect(_valueOf(tester), 100);

      await tester.sendKeyEvent(LogicalKeyboardKey.home);
      await tester.pump();
      expect(_valueOf(tester), 0);
    });

    testWidgets('arrow keys move one division when divisions is set', (
      tester,
    ) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await tester.pumpWidget(
        _harness(_SliderHost(divisions: 10, focusNode: focusNode)),
      );
      focusNode.requestFocus();
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();
      expect(_valueOf(tester), 10);
    });

    testWidgets('disabled slider cannot be focused', (tester) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await tester.pumpWidget(
        _harness(
          MechanixSlider(value: 50, onChanged: null, focusNode: focusNode),
        ),
      );
      focusNode.requestFocus();
      await tester.pump();
      expect(focusNode.hasFocus, isFalse);
    });
  });

  group('MechanixSlider Rendering Tests', () {
    testWidgets('value label is displayed only while dragging', (tester) async {
      await tester.pumpWidget(_harness(const _SliderHost(initial: 50)));
      expect(find.byType(Text), findsNothing);

      final rect = tester.getRect(find.byType(MechanixSlider));
      final gesture = await tester.startGesture(rect.center);
      await gesture.moveBy(const Offset(30, 0));
      await tester.pump();
      expect(find.byType(Text), findsOneWidget);

      await gesture.up();
      await tester.pump();
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('showValueLabel false never displays the label', (tester) async {
      await tester.pumpWidget(
        _harness(
          MechanixSlider(value: 50, showValueLabel: false, onChanged: (_) {}),
        ),
      );
      expect(find.byType(Text), findsNothing);
      final rect = tester.getRect(find.byType(MechanixSlider));
      final gesture = await tester.startGesture(rect.center);
      await gesture.moveBy(const Offset(30, 0));
      await tester.pump();
      expect(find.byType(Text), findsNothing);
      await gesture.up();
    });

    testWidgets('divisions paint one tick per step plus the pointer', (
      tester,
    ) async {
      await tester.pumpWidget(
        _harness(MechanixSlider(value: 0, divisions: 4, onChanged: (_) {})),
      );
      // At rest: all 5 stops, no gap and no pointer.
      expect(tester.renderObject(_paint), paints..something(_ticks(count: 5)));
      expect(tester.renderObject(_paint), isNot(paints..rect()));

      final gesture = await tester.startGesture(
        tester.getRect(find.byType(MechanixSlider)).centerLeft,
      );
      await tester.pump();
      // Pressed: the stop under the pointer is hidden, then the pointer.
      expect(
        tester.renderObject(_paint),
        paints
          ..something(_ticks(count: 4))
          ..rect(),
      );
      expect(
        tester.renderObject(_paint),
        isNot(paints..something(_ticks(count: 5))),
      );
      await gesture.up();
    });

    testWidgets('at rest, the tick under the pointer is active', (
      tester,
    ) async {
      final scheme = MechanixTheme.light.colorScheme;
      await tester.pumpWidget(
        _harness(MechanixSlider(value: 100, divisions: 4, onChanged: (_) {})),
      );
      // At the maximum every stop is filled, including the last one.
      expect(
        tester.renderObject(_paint),
        paints..something(_ticks(count: 5, color: scheme.onSecondaryFixed)),
      );

      await tester.pumpWidget(
        _harness(MechanixSlider(value: 50, divisions: 4, onChanged: (_) {})),
      );
      // Halfway: stops 0, 1 and the one under the pointer are filled.
      expect(
        tester.renderObject(_paint),
        paints
          ..something(_ticks(count: 3, color: scheme.onSecondaryFixed))
          ..something(_ticks(count: 2, color: scheme.secondaryFixedDim)),
      );
    });

    testWidgets('pointer is painted only while pressed or dragging', (
      tester,
    ) async {
      final scheme = MechanixTheme.light.colorScheme;
      await tester.pumpWidget(_harness(const _SliderHost(initial: 50)));
      final pointer = paints..something(_rectColored(scheme.onSecondary));
      expect(tester.renderObject(_paint), isNot(pointer));

      final rect = tester.getRect(find.byType(MechanixSlider));
      final gesture = await tester.startGesture(rect.center);
      await tester.pump();
      expect(tester.renderObject(_paint), pointer);

      await gesture.moveBy(const Offset(30, 0));
      await tester.pump();
      expect(tester.renderObject(_paint), pointer);

      await gesture.up();
      await tester.pump();
      expect(tester.renderObject(_paint), isNot(pointer));

      await tester.tapAt(rect.center);
      await tester.pump();
      expect(tester.renderObject(_paint), isNot(pointer));
    });

    for (final brightness in Brightness.values) {
      testWidgets('uses Mechanix color tokens in ${brightness.name} theme', (
        tester,
      ) async {
        final theme = brightness == Brightness.light
            ? MechanixTheme.light
            : MechanixTheme.dark;
        final scheme = theme.colorScheme;
        await tester.pumpWidget(
          _harness(MechanixSlider(value: 50, onChanged: (_) {}), theme: theme),
        );
        await _press(tester);

        expect(
          tester.renderObject(_paint),
          paints
            ..something(_ticks(color: scheme.onSecondaryFixed))
            ..something(_ticks(color: scheme.secondaryFixedDim))
            ..something(_rectColored(scheme.onSecondary)),
        );
      });
    }

    testWidgets('pointer follows the MechanixTheme accent color', (
      tester,
    ) async {
      const accent = Color(0xFF2196F3);
      await tester.pumpWidget(
        MechanixTheme(
          accentColor: accent,
          builder: (context, theme, child) =>
              MaterialApp(theme: theme.light, home: child),
          child: Scaffold(
            body: Center(
              child: SizedBox(
                width: _length,
                child: MechanixSlider(value: 50, onChanged: (_) {}),
              ),
            ),
          ),
        ),
      );
      await _press(tester);

      expect(
        tester.renderObject(_paint),
        paints..something(_rectColored(accent)),
      );
    });

    testWidgets('disabled slider fades active ticks and hides the pointer', (
      tester,
    ) async {
      final scheme = MechanixTheme.light.colorScheme;
      await tester.pumpWidget(
        _harness(const MechanixSlider(value: 50, onChanged: null)),
      );

      expect(
        tester.renderObject(_paint),
        paints
          ..something(
            _ticks(color: scheme.onSecondaryFixed.withValues(alpha: 0.16)),
          )
          ..something(_ticks(color: scheme.secondaryFixedDim)),
      );

      await _press(tester);
      expect(
        tester.renderObject(_paint),
        isNot(
          paints..something(
            _rectColored(scheme.onSecondary.withValues(alpha: 0.32)),
          ),
        ),
      );
    });

    testWidgets('instance theme overrides the pointer color', (tester) async {
      await tester.pumpWidget(
        _harness(
          MechanixSlider(
            value: 50,
            onChanged: (_) {},
            theme: const SliderThemeDataConfig(
              pointerColor: WidgetStatePropertyAll(Color(0xFF00FF00)),
            ),
          ),
        ),
      );
      await _press(tester);

      expect(
        tester.renderObject(_paint),
        paints..something(_rectColored(const Color(0xFF00FF00))),
      );
    });

    testWidgets(
      'dynamic instance theme update in didUpdateWidget updates pointer color',
      (tester) async {
        await tester.pumpWidget(
          _harness(
            MechanixSlider(
              value: 50,
              onChanged: (_) {},
              theme: const SliderThemeDataConfig(
                pointerColor: WidgetStatePropertyAll(Color(0xFF00FF00)),
              ),
            ),
          ),
        );
        await _press(tester);
        expect(
          tester.renderObject(_paint),
          paints..something(_rectColored(const Color(0xFF00FF00))),
        );

        await tester.pumpWidget(
          _harness(
            MechanixSlider(
              value: 50,
              onChanged: (_) {},
              theme: const SliderThemeDataConfig(
                pointerColor: WidgetStatePropertyAll(Color(0xFFFF00FF)),
              ),
            ),
          ),
        );
        await _press(tester);
        expect(
          tester.renderObject(_paint),
          paints..something(_rectColored(const Color(0xFFFF00FF))),
        );
      },
    );
  });

  group('MechanixSlider Variant Tests', () {
    for (final variant in [
      MechanixSliderVariant.centered,
      MechanixSliderVariant.range,
    ]) {
      testWidgets('${variant.name} variant is not implemented yet', (
        tester,
      ) async {
        await tester.pumpWidget(
          _harness(
            MechanixSlider(value: 50, variant: variant, onChanged: (_) {}),
          ),
        );
        expect(tester.takeException(), isUnimplementedError);
      });
    }
  });

  group('MechanixSlider Semantics Tests', () {
    testWidgets('exposes slider semantics with adjust actions', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(_harness(const _SliderHost(initial: 50)));

      expect(
        tester.getSemantics(find.byType(MechanixSlider)),
        matchesSemantics(
          isSlider: true,
          isEnabled: true,
          hasEnabledState: true,
          isFocusable: true,
          value: '50',
          increasedValue: '51',
          decreasedValue: '49',
          hasIncreaseAction: true,
          hasDecreaseAction: true,
          textDirection: TextDirection.ltr,
        ),
      );
      handle.dispose();
    });
  });
}
