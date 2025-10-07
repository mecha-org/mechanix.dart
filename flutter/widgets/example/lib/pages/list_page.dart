import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';

class MechanixList extends StatefulWidget {
  const MechanixList({super.key});

  @override
  State<MechanixList> createState() => _MechanixListState();
}

class _MechanixListState extends State<MechanixList> {
  bool selectionMode = false;
  List<int> ids = [];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
        height: 20,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        //checkbox color changes at theme level in main.dart can be change here also
        return MechanixSelectableList(
          onLongPress: () {
            setState(() {
              if (!selectionMode) {
                ids.clear();
              }
              selectionMode = !selectionMode;
            });
          },
          onTap: () {
            setState(() {
              if (ids.contains(index)) {
                ids.remove(index);
              } else {
                ids.add(index);
              }
            });
          },
          isSelected: ids.contains(index),
          selectionMode: selectionMode,
          title: "Index $index  ",
          trailingWidget: Text("Trailing Widget"),
        );
      },
    );
  }
}
