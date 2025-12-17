import 'package:flutter/material.dart';
import 'package:widgets/extensions/edge_insets.dart';
import 'package:widgets/widgets.dart';
import 'package:widgets/widgets/list_items/simple_list_items_type.dart';

class MechanixSimpleListPage extends StatefulWidget {
  const MechanixSimpleListPage({super.key});

  @override
  State<MechanixSimpleListPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MechanixSimpleListPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MechanixSimpleList(
            listItems: [
              SimpleListItems(
                  title: "Option 1", onTap: () {}, leading: Text('Leading')),
              SimpleListItems(
                  title: "Option 2", onTap: () {}, trailing: Text('Trailing')),
              SimpleListItems(title: "Option 3", onTap: () {}),
            ],
          ).padBottom(),
          MechanixSimpleList.builder(
            itemCount: 4,
            itemBuilder: (context, index) => Text('data'),
          ).padBottom(),
          MechanixSimpleList.separated(
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.redAccent,
                height: 3,
                thickness: 3,
              );
            },
            listItems: [
              SimpleListItems(title: "Edit Profile"),
              SimpleListItems(
                  title: "Change Password", trailing: Icon(Icons.abc)),
              SimpleListItems(
                  title: "Logout",
                  titleTextStyle: TextStyle(color: Colors.red)),
            ],
          )
        ],
      ),
    );
  }
}
