import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/menu/models/mechanix_menu_item.dart';

class FabExamplePage extends StatefulWidget {
  const FabExamplePage({super.key});

  @override
  State<FabExamplePage> createState() => _FabExamplePageState();
}

class _FabExamplePageState extends State<FabExamplePage> {
  @override
  Widget build(BuildContext context) {
    return MechanixFloatingActionBar(
      offset: Offset(300, 300),
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
      ],
    );
  }
}
