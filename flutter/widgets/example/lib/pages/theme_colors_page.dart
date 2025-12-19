import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oklch/oklch.dart';
import 'package:watch_it/watch_it.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/theme/color_setting.dart';
import 'package:widgets/types/theme_colors.dart';

class MechanixThemeColorsPage extends StatelessWidget with WatchItMixin {
  const MechanixThemeColorsPage({super.key});

  String getRGBAString(Color color) {
    return 'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.a})';
  }

  List<Widget> getWidgets(List<Map<String, Color>> colors) {
    final List<Widget> widgets = [];

    for (var color in colors) {
      color.forEach((label, value) {
        widgets.add(Column(
          children: [
            Container(
              height: 100,
              width: 140,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              color: value,
            ),
            Text(label),
            Text(getRGBAString(value)),
          ],
        ));
      });
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final mechanixVariant =
        watchPropertyValue((ThemeToggle t) => t.mechanixVariant);

    final colorSetting =
        ColorSetting(accentColor: mechanixVariant?.color ?? Colors.blue);

    final ThemeColors themeColors = colorSetting.getThemeColor();

    final accents = [
      {"accent 0": themeColors.accent_0},
      {"accent 100": themeColors.accent_100},
      {"accent 200": themeColors.accent_200},
      {"accent 300": themeColors.accent_300},
      {"accent 400": themeColors.accent_400},
      {"accent 500": themeColors.accent_500},
      {"accent 600": themeColors.accent_600},
      {"accent 700": themeColors.accent_700},
      {"accent 800": themeColors.accent_800},
      {"accent 900": themeColors.accent_900},
      {"accent 1000": themeColors.accent_1000},
      {"accent 1100": themeColors.accent_1100},
      {"accent 1200": themeColors.accent_1200},
    ];

    final backgrounds = [
      {"background 0": themeColors.background_0},
      {"background 100": themeColors.background_100},
      {"background 200": themeColors.background_200},
      {"background 300": themeColors.background_300},
      {"background 400": themeColors.background_400},
      {"background 500": themeColors.background_500},
      {"background 600": themeColors.background_600},
      {"background 700": themeColors.background_700},
      {"background 800": themeColors.background_800},
      {"background 900": themeColors.background_900},
      {"background 1000": themeColors.background_1000},
      {"background 1100": themeColors.background_1100},
      {"background 1200": themeColors.background_1200},
    ];

    final foregrounds = [
      {"foreground 0": themeColors.foreground_0},
      {"foreground 100": themeColors.foreground_100},
      {"foreground 200": themeColors.foreground_200},
      {"foreground 300": themeColors.foreground_300},
      {"foreground 400": themeColors.foreground_400},
      {"foreground 500": themeColors.foreground_500},
      {"foreground 600": themeColors.foreground_600},
      {"foreground 700": themeColors.foreground_700},
      {"foreground 800": themeColors.foreground_800},
      {"foreground 900": themeColors.foreground_900},
      {"foreground 1000": themeColors.foreground_1000},
      {"foreground 1100": themeColors.foreground_1100},
      {"foreground 1200": themeColors.foreground_1200},
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            spacing: 40,
            children: [
              VariantPicker(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(OKLCHColor.fromColor(
                          mechanixVariant?.color ?? Colors.blue)
                      .textDescription),
                  IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                            text: OKLCHColor.fromColor(
                                    mechanixVariant?.color ?? Colors.blue)
                                .textDescription));
                      },
                      icon: Icon(Icons.copy)),
                ],
              ),
              Text("Accent Colors"),
              Wrap(children: getWidgets(accents)),
              Text("Background Colors"),
              Wrap(children: getWidgets(backgrounds)),
              Text("Foreground Colors"),
              Wrap(children: getWidgets(foregrounds)),
            ],
          ),
        ),
      ),
    );
  }
}
