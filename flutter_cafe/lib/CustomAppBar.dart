import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Coffee Card",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0, // 앱바 제목의 폰트 크기
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.brown,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
