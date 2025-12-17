import 'package:flutter/material.dart';
import 'package:widgets/extension.dart';
import 'package:widgets/widgets.dart';
import 'package:widgets/widgets/wheel_scroll/mechanix_wheel_scroll_theme.dart';
import 'package:widgets/widgets/wheel_scroll/wheel_scroll_options_type.dart';

final List<WheelScrollOption<int>> shortMonths = [
  WheelScrollOption(label: 'Jan', value: 1),
  WheelScrollOption(label: 'Feb', value: 2),
  WheelScrollOption(label: 'Mar', value: 3),
  WheelScrollOption(label: 'Apr', value: 4),
  WheelScrollOption(label: 'May', value: 5),
  WheelScrollOption(label: 'Jun', value: 6),
  WheelScrollOption(label: 'Jul', value: 7),
  WheelScrollOption(label: 'Aug', value: 8),
  WheelScrollOption(label: 'Sep', value: 9),
  WheelScrollOption(label: 'Oct', value: 10),
  WheelScrollOption(label: 'Nov', value: 11),
  WheelScrollOption(label: 'Dec', value: 12),
];

class WheelScrollPage extends StatefulWidget {
  const WheelScrollPage({super.key});

  @override
  State<WheelScrollPage> createState() => _WheelScrollPageState();
}

class _WheelScrollPageState extends State<WheelScrollPage> {
  int selectedMonth = 0;
  int selectedYear = 0;
  int selectedWeekDay = 0;
  int selectedDay = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      MechanixWheelScroll(
                        width: 116,
                        height: 220,
                        selectionWidth: 116,
                        selectionHeight: 56,
                        value: selectedMonth,
                        options: shortMonths,
                        theme: MechanixWheelScrollThemeData(
                            selectionBorderRadius: CircularRadius.all(0)),
                        onSelectedItemChanged: (value) {
                          setState(() {
                            selectedMonth = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
