import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  String? value;
  Function(String?)? setValue; // Update setValue to accept nullable String

  FormWidget({required this.value, required this.setValue});

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormWidget> {
  _FormState();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.value,
      decoration: const InputDecoration(labelText: "값을 입력하세요"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "값을 입력해주세요";
        }
        return null;
      },
      onSaved: widget.setValue,
    );
  }
}
