import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import 'package:widgets/widgets/list_items/mechanix_simple_list_theme.dart';
import 'package:widgets/widgets/list_items/simple_list_items_type.dart';
import 'package:widgets/widgets/text_input/mechanix_text_input_theme.dart';

class BottomSheetPage extends StatelessWidget {
  const BottomSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Bottom Sheet Examples")),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Bottom Sheet 1 - Delete File",
                  style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              Builder(
                // Use Builder to get a new context and theme applied
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      MechanixBottomSheet.show(
                        context,
                        child: const DeleteSheetContent(),
                      );
                    },
                    child: const Text("Show Delete File Sheet"),
                  );
                },
              ),
              const Divider(height: 32, color: Colors.white30),
              const Text("Bottom Sheet 2 - Properties",
                  style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // Use the static show method to display the bottom sheet with default theme
                  MechanixBottomSheet.show(
                    context,
                    child: const PropertiesSheetContent(),
                  );
                },
                child: const Text("Show Properties Sheet"),
              ),
              const Divider(height: 32, color: Colors.white30),
              const Text("Bottom Sheet 3 - Text Input",
                  style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              Builder(
                // Use Builder to get a new context and theme applied
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      MechanixBottomSheet.show(
                        context,
                        child: const TextInputSheetContent(),
                      );
                    },
                    child: const Text("Show Text Input Sheet"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteSheetContent extends StatelessWidget {
  const DeleteSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align to start
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Delete",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Delete file.png permanently",
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  debugPrint("Delete confirmed");
                  Navigator.of(context).pop();
                },
                child: const Text("Delete"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Properties sheet content
class PropertiesSheetContent extends StatelessWidget {
  const PropertiesSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MechanixSimpleListTheme(
      style: MechanixSimpleListThemeData(
          itemPadding: const EdgeInsets.all(8),
          backgroundColor: Colors.transparent),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MechanixSimpleList(
            isDividerRequired: false,
            padding: EdgeInsets.zero,
            listItems: [
              SimpleListItems(
                title: "Properties",
                titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
                onTap: () {},
                trailing: Icon(Icons.info, color: Colors.white70),
              ),
              SimpleListItems(
                  title: "Type", onTap: () {}, trailing: const Text("pdf")),
              SimpleListItems(
                  title: "Size", onTap: () {}, trailing: const Text("120mb")),
              SimpleListItems(
                  title: "Modified",
                  onTap: () {},
                  trailing: const Text("25-07-2025, 12:30pm")),
              SimpleListItems(
                  title: "Accessed",
                  onTap: () {},
                  trailing: const Text("25-07-2025, 12:30pm")),
              SimpleListItems(
                  title: "Changed",
                  onTap: () {},
                  trailing: const Text("25-07-2025, 12:30pm")),
              SimpleListItems(
                  title: "Readable", onTap: () {}, trailing: const Text("Yes")),
              SimpleListItems(
                  title: "Writable", onTap: () {}, trailing: const Text("Yes")),
              SimpleListItems(
                  title: "Hidden", onTap: () {}, trailing: const Text("No")),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ),
        ],
      ),
    );
  }
}

class TextInputSheetContent extends StatelessWidget {
  const TextInputSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MechanixTextInputTheme(
      style: MechanixTextInputThemeData(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Enter Your Name",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: MechanixTextInput<String>.textInput(
                  hintText: "Your name",
                  onChanged: (value) {
                    debugPrint("Name changed: $value");
                  },
                  onFieldSubmitted: (value) {
                    debugPrint("Field submitted: $value");
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 48, // Set width and height to the same value
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[700],
                    foregroundColor: Colors.white,
                    shape:
                        const CircleBorder(), // Use CircleBorder for perfect circle
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 48, // Set width and height to the same value
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape:
                        const CircleBorder(), // Use CircleBorder for perfect circle
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    debugPrint("Submit pressed");
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.check),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
