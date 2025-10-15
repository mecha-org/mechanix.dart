import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import 'package:widgets/widgets/menu/constants/menu_selection_type.dart';
import 'package:widgets/widgets/menu/constants/menu_transitions.dart';
import 'package:widgets/widgets/menu/models/mechanix_menu_item.dart';

class PopupMenuPage extends StatelessWidget {
  const PopupMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 50,
          width: 50,
          color: Colors.transparent,
          child: MechanixMenu(
            animationType: MenuTransitions.slideDown,
            selectionType: MenuSelection.single,
            items: [
              MechanixMenuItemsType(
                title: 'Menu 1',
                leading: IconWidget.fromIconData(
                  icon: Icon(Icons.import_contacts),
                ),
                onTap: () {},
              ),
              MechanixMenuItemsType(
                title: 'Menu 2',
                onTap: () {},
              ),
              MechanixMenuItemsType(
                title: 'Menu 3',
                leading: IconWidget.fromIconData(
                  icon: Icon(Icons.import_contacts),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
