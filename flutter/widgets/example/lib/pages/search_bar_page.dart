import 'package:flutter/material.dart';
import 'package:widgets/widgets/searchbar/mechanix_search_bar.dart';
import 'package:widgets/widgets/select/select_type.dart';

class SearchBarPage extends StatefulWidget {
  const SearchBarPage({super.key});

  @override
  State<SearchBarPage> createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  String selectValue = '';
  final TextEditingController textController = TextEditingController();

  void onChanged(SelectOption option) {
    setState(() {
      selectValue = option.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MechanixSearchBar(
          onChanged: (value) {},
          controller: textController,
          onBackwardIconPress: () => textController.clear(),
          onCloseIconPress: () => textController.clear(),
        )
      ],
    );
  }
}
