import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/sectionList/mechanix_section_list_theme.dart';
import 'package:widgets/widgets/sectionList/section_list_items_type.dart';

class MechanixSettingsMenuPage extends StatefulWidget {
  const MechanixSettingsMenuPage({super.key});

  @override
  State<MechanixSettingsMenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MechanixSettingsMenuPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MechanixSectionListTheme(
            style: MechanixSectionListThemeData(
              height: 40,
            ),
            child:
                MechanixSectionList(title: 'Connectivity', sectionListItems: [
              SectionListItems(
                  title: 'Network',
                  leading: SizedBox(
                      height: 24,
                      width: 24,
                      child: Icon(
                        Icons.wifi,
                        size: 24,
                      )),
                  trailing: SizedBox(
                    height: 24,
                    width: 24,
                    child: Icon(Icons.abc),
                  )),
              SectionListItems(
                title: 'Mobile Data',
                leading: SizedBox(
                    height: 24,
                    width: 24,
                    child: Icon(
                      Icons.network_cell,
                    )),
              ),
              SectionListItems(
                title: 'Bluetooth',
              ),
            ]),
          ),
          MechanixSectionList.builder(
            title: 'Connectivity',
            itemCount: 2,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Text('data $index'),
                  Text('data ${index + 1}'),
                ],
              );
            },
          ),
          MechanixSectionList.separated(
            title: 'Connectivity',
            sectionListItems: [
              SectionListItems(
                  title: 'Network',
                  leading: SizedBox(
                      height: 24,
                      width: 24,
                      child: Icon(
                        Icons.wifi,
                        size: 24,
                      )),
                  trailing: SizedBox(
                    height: 24,
                    width: 24,
                    child: Icon(Icons.abc),
                  )),
              SectionListItems(
                title: 'Mobile Data',
                leading: SizedBox(
                    height: 24,
                    width: 24,
                    child: Icon(
                      Icons.network_cell,
                    )),
              ),
              SectionListItems(
                title: 'Bluetooth',
              ),
            ],
            separatorBuilder: (context, index) => Divider(
              thickness: 3,
              height: 6,
              color: Colors.amber,
            ),
          )
        ],
      ),
    );
  }
}
