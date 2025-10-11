import 'package:flutter/material.dart';
import 'package:widgets/widgets/search_bar/mechanix_search_bar.dart';

class SearchBarPage extends StatefulWidget {
  const SearchBarPage({super.key});

  @override
  State<SearchBarPage> createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  String selectValue = '';

  void onChanged(String value) {
    setState(() {
      selectValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MechanixSearchBar(
          onChanged: onChanged,
        ),
        Text(selectValue)
      ],
    );
  }
}
