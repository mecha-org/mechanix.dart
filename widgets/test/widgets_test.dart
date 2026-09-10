import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  test(
    'Mechanix public symbols are exported from package:widgets/widgets.dart',
    () {
      expect(MechanixIcons.caretLeft, isNotNull);
      expect(MechanixSpacing.medium, equals(16.0));
      final theme = createTextTheme(textColor: const Color(0xFF000000));
      expect(theme.displayLarge, isNotNull);
      expect(theme.headlineLarge, isNotNull);
      expect(theme.titleLarge, isNotNull);
      expect(theme.bodyLarge, isNotNull);
      expect(theme.labelLarge, isNotNull);
      expect(MechanixTheme.light, isA<ThemeData>());
      expect(MechanixTheme.dark, isA<ThemeData>());
      expect(MechanixColors.lightColorScheme, isA<ColorScheme>());
      expect(MechanixColors.darkColorScheme, isA<ColorScheme>());
      expect(const MechanixTheme(child: SizedBox()), isA<MechanixThemeScope>());
      expect(
        MechanixButton(label: 'Test', onPressed: () {}),
        isA<MechanixButton>(),
      );
      expect(
        MechanixCheckbox(value: true, onChanged: (_) {}),
        isA<MechanixCheckbox>(),
      );
      expect(const CheckboxThemeDataConfig(), isA<CheckboxThemeDataConfig>());
      expect(
        const MechanixCheckboxTheme(
          data: CheckboxThemeDataConfig(),
          child: SizedBox(),
        ),
        isA<MechanixCheckboxTheme>(),
      );
      expect(
        MechanixRadio<int>(value: 1, onChanged: (_) {}),
        isA<MechanixRadio<int>>(),
      );
      expect(const RadioThemeDataConfig(), isA<RadioThemeDataConfig>());
      expect(
        const MechanixRadioTheme(
          data: RadioThemeDataConfig(),
          child: SizedBox(),
        ),
        isA<MechanixRadioTheme>(),
      );
    },
  );
}
