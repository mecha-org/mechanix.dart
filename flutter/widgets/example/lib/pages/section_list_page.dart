import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/section_list/mechanix_section_list_theme.dart';
import 'package:widgets/widgets/section_list/section_list_items_type.dart';

List<SectionListItems> generateLargeList() {
  return List<SectionListItems>.generate(10000, (index) {
    return SectionListItems(
      title: 'Item ${index + 1}',
      onTap: () {
        print('Tapped item ${index + 1}');
      },
      leading: Icon(Icons.circle, size: 16),
      defaultTrailingIcon: true,
    );
  });
}

class MechanixSettingsMenuPage extends StatefulWidget {
  const MechanixSettingsMenuPage({super.key});

  @override
  State<MechanixSettingsMenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MechanixSettingsMenuPage> {
  final List<SectionListItems> largeItems = generateLargeList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Large lazy list with 10,000 items
              MechanixSectionList.lazy(
                title: 'Large Item List (10,000 items)',
                sectionListItems: largeItems,
                initialItemCount: 50, // Show first 50 items
                batchSize: 25, // Load 25 more when reaching bottom
                listBoxConstraints: BoxConstraints(maxHeight: 400),
                theme: MechanixSectionListThemeData(
                  widgetPadding: EdgeInsets
                      .zero, // Remove extra padding since parent has padding
                ),
              ),

              const SizedBox(height: 20),

              // Regular section list with custom theme
              MechanixSectionListTheme(
                style: MechanixSectionListThemeData(
                  height: 40,
                  widgetPadding: EdgeInsets.zero,
                ),
                child: MechanixSectionList(
                  title: 'Connectivity',
                  sectionListItems: [
                    SectionListItems(
                      title: 'Network',
                      leading: SizedBox(
                        height: 24,
                        width: 24,
                        child: Icon(Icons.wifi, size: 24),
                      ),
                      trailing: SizedBox(
                        height: 24,
                        width: 24,
                        child: Icon(Icons.abc),
                      ),
                    ),
                    SectionListItems(
                      title: 'Mobile Data',
                      leading: SizedBox(
                        height: 24,
                        width: 24,
                        child: Icon(Icons.network_cell),
                      ),
                    ),
                    SectionListItems(
                      title: 'Bluetooth',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Builder pattern section list
              MechanixSectionList.builder(
                title: 'Custom Builder List',
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Data $index'),
                        Text('Item ${index + 1}'),
                      ],
                    ),
                  );
                },
                theme: MechanixSectionListThemeData(
                  widgetPadding: EdgeInsets.zero,
                ),
              ),

              const SizedBox(height: 20),

              // Separated section list
              MechanixSectionList.separated(
                title: 'Connectivity Settings',
                sectionListItems: [
                  SectionListItems(
                    title: 'Network',
                    leading: SizedBox(
                      height: 24,
                      width: 24,
                      child: Icon(Icons.wifi, size: 24),
                    ),
                    trailing: SizedBox(
                      height: 24,
                      width: 24,
                      child: Icon(Icons.abc),
                    ),
                  ),
                  SectionListItems(
                    title: 'Mobile Data',
                    leading: SizedBox(
                      height: 24,
                      width: 24,
                      child: Icon(Icons.network_cell),
                    ),
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
                theme: MechanixSectionListThemeData(
                  widgetPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
