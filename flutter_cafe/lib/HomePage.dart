import 'package:flutter/material.dart';

import 'CustomAppBar.dart';
import 'CustomBottomNavBar.dart';
import 'cafe_list/CafeListview.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "HomePage"),
      body: DynamicListView(), // 바디 부분
      bottomNavigationBar: CustomBottomNavBar(), // 바텀 네비게이션 바
    );
  }
}
