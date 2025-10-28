import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets.dart';
import 'package:widgets/widgets/menu/constants/menu_selection_type.dart';
import 'package:widgets/widgets/menu/constants/menu_transitions.dart';

class PopupMenuPage extends StatefulWidget {
  const PopupMenuPage({super.key});

  @override
  State<PopupMenuPage> createState() => _PopupMenuPageState();
}

class _PopupMenuPageState extends State<PopupMenuPage> {
  final MechanixMenuController _menuController = MechanixMenuController();

  void _openMenuProgrammatically() {
    _menuController.open();
  }

  void _closeMenuProgrammatically() {
    _menuController.close();
  }

  void _toggleMenuProgrammatically() {
    _menuController.toggle();
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                MechanixMenu.builder(
                  menuController: _menuController,
                  animationType: MenuTransitions.slideDown,
                  selectionType: MenuSelection.single,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Text('Menu $index');
                  },
                ),
              ],
            ),
            MechanixMenu.builder(
              animationType: MenuTransitions.slideDown,
              selectionType: MenuSelection.single,
              buttonIcon: IconWidget.fromIconData(
                icon: Icon(Icons.download_done_outlined),
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Text('Menu $index');
              },
            )
          ],
        ),
      ),
    );
  }
}
