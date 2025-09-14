import 'package:flutter/widgets.dart';
import 'package:widgets/mechanix.dart';

class MechanixTextInputPage extends StatefulWidget {
  const MechanixTextInputPage({super.key});

  @override
  State<MechanixTextInputPage> createState() => _MechanixTextInputPageState();
}

class _MechanixTextInputPageState extends State<MechanixTextInputPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MechanixTextInput.textInput(),
          MechanixTextInput.textInput(
            initialValue: "Initial Value",
          ),
          MechanixTextInput.password(
            hintText: 'Enter Password',
          ),
        ],
      ),
    );
  }
}
