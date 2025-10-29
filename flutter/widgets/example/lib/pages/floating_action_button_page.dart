import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/floating_action_bar/mechanix_floating_action_bar_theme.dart';
import 'package:widgets/widgets/menu/models/mechanix_menu_item.dart';

class FabExamplePage extends StatefulWidget {
  const FabExamplePage({super.key});

  @override
  State<FabExamplePage> createState() => _FabExamplePageState();
}

class _FabExamplePageState extends State<FabExamplePage> {
  final FloatingActionBarController _fabController =
      FloatingActionBarController();

  void _openMenuProgrammatically() {
    _fabController.open();
  }

  void _closeMenuProgrammatically() {
    _fabController.close();
  }

  void _toggleMenuProgrammatically() {
    _fabController.toggle();
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: _openMenuProgrammatically,
              child: Text('Open Floating Menu'),
            ),
            ElevatedButton(
              onPressed: _closeMenuProgrammatically,
              child: Text('Close Floating Menu'),
            ),
            ElevatedButton(
              onPressed: _toggleMenuProgrammatically,
              child: Text('Toggle Floating Menu'),
            ),
            MechanixFloatingActionBar(
              offset: Offset(300, 300),
              isMenuButtonRequired: false,
              floatingActionBarController: _fabController,
              menus: [
                MechanixMenu(
                  items: [
                    MechanixMenuItemsType(title: 'Menu 1', onTap: () {}),
                    MechanixMenuItemsType(title: 'Menu 2', onTap: () {}),
                    MechanixMenuItemsType(title: 'Menu 3', onTap: () {}),
                  ],
                ),
                MechanixMenu(
                  items: [
                    MechanixMenuItemsType(title: 'Menu 4', onTap: () {}),
                    MechanixMenuItemsType(title: 'Menu 5', onTap: () {}),
                    MechanixMenuItemsType(title: 'Menu 6', onTap: () {}),
                  ],
                ),
                IconButton.filled(onPressed: () {}, icon: Icon(Icons.ac_unit))
              ],
            )
          ],
        ),
        MechanixFloatingActionBar(
          offset: Offset(300, 300),
          buttonIcon: IconWidget.fromIconData(icon: Icon(Icons.abc)),
          outsideClickDisabled: true,
          floatingActionBarController: _fabController,
          theme: MechanixFloatingActionBarThemeData(
            height: 100,
            width: 500,
            decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(16)),
          ),
          menus: [
            MechanixMenu(
              items: [
                MechanixMenuItemsType(title: 'Menu 1', onTap: () {}),
                MechanixMenuItemsType(
                    title: 'Menu 2',
                    onTap: () {
                      _fabController.close();
                    }),
                MechanixMenuItemsType(title: 'Menu 3', onTap: () {}),
              ],
            ),
            MechanixMenu(
              items: [
                MechanixMenuItemsType(title: 'Menu 4', onTap: () {}),
                MechanixMenuItemsType(title: 'Menu 5', onTap: () {}),
                MechanixMenuItemsType(title: 'Menu 6', onTap: () {}),
              ],
            ),
            IconButton.filled(onPressed: () {}, icon: Icon(Icons.ac_unit))
          ],
        )
      ],
    );
  }
}
