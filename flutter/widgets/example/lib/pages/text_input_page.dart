import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:widgets/mechanix.dart';

class MechanixTextInputPage extends StatefulWidget {
  const MechanixTextInputPage({super.key});

  @override
  State<MechanixTextInputPage> createState() => _MechanixTextInputPageState();
}

class _MechanixTextInputPageState extends State<MechanixTextInputPage> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MechanixTextInput.textInput(),
          const SizedBox(height: 20),
          MechanixTextInput.textInput(
            initialValue: "Initial Value",
          ),
          const SizedBox(height: 20),
          MechanixTextInput.password(
            hintText: 'Enter Password',
          ),
          const SizedBox(height: 20),
          MechanixTextInput.password(
            inputDecoration: InputDecoration(
              suffixIcon: Icon(Icons.close),
              prefixIcon: Icon(Icons.lock_outline),
              errorText: "Error Text",
            ),
          ),
        ],
      ),
    );
  }
}
