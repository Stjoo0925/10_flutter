import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget{

  @override
  State createState() => CheckBoxState();
}

class CheckBoxState extends State<CheckBoxWidget> {
  late bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$_isChecked"),
        Checkbox(
          value: _isChecked,
          onChanged: (bool? value){
            setState(() {
              _isChecked = value ?? false;
            });
          },
        )
      ],
    );
  }
}