import 'package:flutter/material.dart';

import 'CustomAppBar.dart';
import 'CustomBottomNavBar.dart';

class MainContentPage extends StatelessWidget {
  const MainContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Main Page"),
      body: Center(
        child: Text("This is the Main Page"),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}