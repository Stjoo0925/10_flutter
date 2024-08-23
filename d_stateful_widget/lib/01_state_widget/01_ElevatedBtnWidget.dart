import 'package:flutter/material.dart';

class ElevatedBtnWidget extends StatelessWidget{
  final VoidCallback onPressed;

  const ElevatedBtnWidget({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          overlayColor: Colors.red,
          foregroundColor: Colors.white
        ),
        child: const Text("eleBtn"),
      ),
    );
  }
}