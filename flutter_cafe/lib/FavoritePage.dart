import 'package:flutter/material.dart';

import 'CustomAppBar.dart';
import 'CustomBottomNavBar.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Favorite Page"),
      body: Center(
        child: Text("This is the Favorite Page"),
      ),
      bottomNavigationBar: CustomBottomNavBar(), // 바텀 네비게이션 바 재사용
    );
  }
}
