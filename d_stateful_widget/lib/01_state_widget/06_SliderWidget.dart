import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State createState() => SliderState();
}

class SliderState extends State<SliderWidget> {
  double score = 0;

  void scoreMethod(double value) {
    setState(() {
      score = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$score"),
        Slider(value: score.toDouble(),
            onChanged: scoreMethod,
            min: 0, 
            max: 100,
            divisions: 100)
      ],
    );
  }
}