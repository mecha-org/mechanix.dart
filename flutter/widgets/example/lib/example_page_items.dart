import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:widgets_example/pages/alerts_page.dart';
import 'package:widgets_example/pages/bottom_sheet_page.dart';
import 'package:widgets_example/pages/buttons_page.dart';
import 'package:widgets_example/pages/floating_action_button_page.dart';
import 'package:widgets_example/pages/icon_widget_page.dart';
import 'package:widgets_example/pages/list_page.dart';
import 'package:widgets_example/pages/navigation_page.dart';
import 'package:widgets_example/pages/popup_menu_page.dart';
import 'package:widgets_example/pages/search_bar_page.dart';
import 'package:widgets_example/pages/section_list_page.dart';
import 'package:widgets_example/pages/select_page.dart';
import 'package:widgets_example/pages/simple_list_page.dart';
import 'package:widgets_example/pages/slider_widget_page.dart';
import 'package:widgets_example/pages/text_input_page.dart';
import 'package:widgets_example/pages/wheel_scroll_page.dart';

import 'pages/checkbox_page.dart';

class PageItem {
  const PageItem({
    required this.title,
    this.leadingBuilder,
    this.titleBuilder,
    this.actionsBuilder,
    required this.pageBuilder,
    required this.iconBuilder,
    this.floatingActionButtonBuilder,
  });

  final String title;
  final WidgetBuilder? leadingBuilder;
  final WidgetBuilder? titleBuilder;
  final List<Widget> Function(BuildContext context)? actionsBuilder;
  final WidgetBuilder pageBuilder;
  final WidgetBuilder? floatingActionButtonBuilder;
  final Widget Function(BuildContext context, bool selected) iconBuilder;
}

final examplePageItems = <PageItem>[
  PageItem(
    title: 'MechanixCheckbox',
    pageBuilder: (context) => const CheckboxPage(),
    iconBuilder: (context, selected) => selected
        ? const Icon(Icons.check_box)
        : const Icon(Icons.check_box_outline_blank),
  ),
  PageItem(
      title: 'MechanixButton',
      //   floatingActionButtonBuilder: (_) => const CodeSnippedButton( //TODO: Code Snippet Button
      //   snippetUrl:
      //       'https://raw.githubusercontent.com/ubuntu/yaru.dart/main/example/lib/pages/autocomplete_page.dart',
      // ),
      pageBuilder: (context) => const ButtonsPage(),
      iconBuilder: (context, selected) =>
          const Icon(Icons.radio_button_checked)),
  PageItem(
    title: 'MechanixAlerts',
    pageBuilder: (context) => const AlertsPage(),
    iconBuilder: (context, selected) => const Icon(Icons.smart_screen_rounded),
  ),
  PageItem(
    title: 'MechanixSectionList',
    pageBuilder: (context) => const MechanixSettingsMenuPage(),
    iconBuilder: (context, selected) => const Icon(Icons.smart_screen_rounded),
  ),
  PageItem(
    title: 'MechanixSimpleList',
    pageBuilder: (context) => const MechanixSimpleListPage(),
    iconBuilder: (context, selected) => const Icon(Icons.smart_screen_rounded),
  ),
  PageItem(
    title: 'MechanixIconWidget',
    pageBuilder: (context) => const MechanixIconWidget(),
    iconBuilder: (context, selected) => const Icon(Icons.smart_screen_rounded),
  ),
  PageItem(
      title: 'MechanixFABMenu',
      pageBuilder: (context) => const FabExamplePage(),
      iconBuilder: (context, selected) =>
          const Icon(Icons.smart_screen_rounded)),
  PageItem(
      title: 'Mechanix Navigation Bar',
      pageBuilder: (context) => const NavigationPage(),
      iconBuilder: (context, selected) =>
          const Icon(Icons.smart_screen_rounded)),
  PageItem(
      title: 'Mechanix Pressable List',
      pageBuilder: (context) => const MechanixList(),
      iconBuilder: (context, selected) =>
          const Icon(Icons.smart_screen_rounded)),
  PageItem(
      title: 'MechanixSlider',
      pageBuilder: (context) => const MechanixSliderPage(),
      iconBuilder: (context, selected) =>
          const Icon(Icons.smart_screen_rounded)),
  PageItem(
      title: 'MechanixSelect',
      pageBuilder: (context) => const SelectPage(),
      iconBuilder: (context, selected) =>
          const Icon(Icons.smart_screen_rounded)),
  PageItem(
      title: 'MechanixMenu',
      pageBuilder: (context) => const PopupMenuPage(),
      iconBuilder: (context, selected) => const Icon(Icons.menu)),
  PageItem(
      title: 'MechanixWheelScroll',
      pageBuilder: (context) => const WheelScrollPage(),
      iconBuilder: (context, selected) =>
          const Icon(Icons.smart_screen_rounded)),
  PageItem(
      title: 'MechanixTextInput',
      pageBuilder: (context) => const MechanixTextInputPage(),
      iconBuilder: (context, selected) =>
          const Icon(Icons.smart_screen_rounded)),
  PageItem(
      title: 'MechanixBottomSheet',
      pageBuilder: (context) => const BottomSheetPage(),
      iconBuilder: (context, selected) =>
          const Icon(Icons.border_top_outlined)),
  PageItem(
      title: 'MechanixSearchBar',
      pageBuilder: (context) => const SearchBarPage(),
      iconBuilder: (context, selected) => const Icon(Icons.menu)),
].sortedBy((page) => page.title);
