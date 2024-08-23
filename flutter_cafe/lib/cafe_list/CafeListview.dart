import 'package:flutter/material.dart';

import 'SampleCard.dart';

class DynamicListView extends StatelessWidget {
  final List<String> items = List.generate(10, (index) => "아이템 $index");

  DynamicListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: 130,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: const SampleCard(),
          ),
        );
      },
    );
  }
}