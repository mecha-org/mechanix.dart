import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import 'package:widgets/widgets/menu/mechanix_menu_item_theme.dart';
import 'package:widgets/widgets/menu/mechanix_menu_theme.dart';

class PopupMenuPage extends StatelessWidget {
  const PopupMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        extensions: [
          MechanixMenuThemeData(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.hovered)) {
                return Colors.grey[700];
              }
              return const Color(0xFF424242);
            }),
            borderRadius: 12,
            shadowColor: WidgetStatePropertyAll(Colors.black54),
          ),
          const MechanixMenuItemThemeData(
            iconColor: WidgetStatePropertyAll(Colors.white70),
            textStyle: TextStyle(color: Colors.white, fontSize: 14),
            checkColor: WidgetStatePropertyAll(Colors.blue),
          ),
        ],
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Menu 1 - Radio Buttons",
                  style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              const SingleSelectMenuExample(),
              const Divider(height: 32, color: Colors.white30),
              const Text("Menu 2 - Actions",
                  style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              const ActionMenuExample(),
              const Divider(height: 32, color: Colors.white30),
              const Text("Menu 3 - Multi Select",
                  style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              const MultiSelectMenuExample(),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleSelectMenuExample extends StatefulWidget {
  const SingleSelectMenuExample({super.key});

  @override
  State<SingleSelectMenuExample> createState() =>
      _SingleSelectMenuExampleState();
}

class _SingleSelectMenuExampleState extends State<SingleSelectMenuExample> {
  String selected = "None";

  @override
  Widget build(BuildContext context) {
    return MechanixMenu(
      selectionMode: MenuSelectionMode.single,
      selectedItems: ["Name"],
      onSelectionChanged: (selected) => print("Selected: $selected"),
      items: [
        MechanixMenuItem(label: "Name", layout: MenuItemLayout.checkLeft),
        MechanixMenuDivider(color: Colors.white24),
        MechanixMenuItem(
            label: "Size",
            layout: MenuItemLayout.checkLeft,
            trailingWidget:
                const Icon(Icons.sort, size: 16, color: Colors.white70)),
        MechanixMenuDivider(color: Colors.white24),
        MechanixMenuItem(
            label: "File modified", layout: MenuItemLayout.checkLeft),
      ],
    );
  }
}

class RadioMenuExample extends StatefulWidget {
  const RadioMenuExample({super.key});

  @override
  State<RadioMenuExample> createState() => _RadioMenuExampleState();
}

class _RadioMenuExampleState extends State<RadioMenuExample> {
  String selectedOption = "None";

  @override
  Widget build(BuildContext context) {
    final options = [
      "None",
      "Name",
      "Size",
      "Type",
      "File modified",
      "File created"
    ];

    return MechanixMenu(
      items: options.map((label) {
        return MechanixMenuItem(
          label: label,
          layout:
              MenuItemLayout.checkLeft, // Check on left looks like a radio menu
          checkValue: selectedOption == label,
          onCheckChanged: (val) {
            if (val) {
              setState(() {
                selectedOption = label;
              });
            }
          },
        );
      }).toList(),
    );
  }
}

class ActionMenuExample extends StatelessWidget {
  const ActionMenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MechanixMenu(
      items: [
        MechanixMenuItem(
          label: "Rename",
          layout: MenuItemLayout.iconRight,
          trailingWidget: Icon(Icons.edit, color: Colors.white70),
          onTap: () => debugPrint("Rename tapped"),
        ),
        MechanixMenuItem(
          label: "Compress",
          layout: MenuItemLayout.iconRight,
          trailingWidget: Icon(Icons.archive, color: Colors.white70),
          onTap: () => debugPrint("Compress tapped"),
        ),
        MechanixMenuItem(
          label: "Create folder",
          layout: MenuItemLayout.iconRight,
          trailingWidget: Icon(Icons.create_new_folder, color: Colors.white70),
          onTap: () => debugPrint("Create folder tapped"),
        ),
        MechanixMenuItem(
          label: "Show hidden files",
          layout: MenuItemLayout.iconRight,
          trailingWidget: Icon(Icons.visibility_off, color: Colors.white70),
          onTap: () => debugPrint("Show hidden files tapped"),
        ),
        MechanixMenuItem(
          label: "Properties",
          layout: MenuItemLayout.iconRight,
          trailingWidget: Icon(Icons.info_outline, color: Colors.white70),
          onTap: () => debugPrint("Properties tapped"),
        ),
        MechanixMenuItem(
          label: "Delete",
          layout: MenuItemLayout.iconRight,
          trailingWidget: Icon(Icons.delete, color: Colors.red),
          onTap: () => debugPrint("Delete tapped"),
          textStyle: const TextStyle(color: Colors.red),
        ),
      ],
    );
  }
}

class MultiSelectMenuExample extends StatefulWidget {
  const MultiSelectMenuExample({super.key});

  @override
  State<MultiSelectMenuExample> createState() => _MultiSelectMenuExampleState();
}

class _MultiSelectMenuExampleState extends State<MultiSelectMenuExample> {
  String selected = "None";

  @override
  Widget build(BuildContext context) {
    return MechanixMenu(
      selectionMode: MenuSelectionMode.multiple,
      selectedItems: ["Name"],
      onSelectionChanged: (selected) => print("Selected: $selected"),
      itemPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      items: [
        MechanixMenuItem(label: "Name", layout: MenuItemLayout.checkLeft),
        MechanixMenuDivider(color: Colors.white24),
        MechanixMenuItem(
            label: "Size",
            layout: MenuItemLayout.checkLeft,
            trailingWidget:
                const Icon(Icons.sort, size: 16, color: Colors.white70)),
        MechanixMenuDivider(color: Colors.white24),
        MechanixMenuItem(
            label: "File modified", layout: MenuItemLayout.checkLeft),
      ],
    );
  }
}
