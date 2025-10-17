import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import 'package:widgets/widgets/menu/constants/menu_selection_type.dart';
import 'package:widgets/widgets/menu/constants/menu_transitions.dart';

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
          child: MechanixMenu.builder(
            animationType: MenuTransitions.slideDown,
            selectionType: MenuSelection.single,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Text('Menu $index');
            },
          ),
        ),
      ),
    );
  }
}
