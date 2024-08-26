import 'package:flutter/material.dart';
import 'FavoritePage.dart';
import 'HomePage.dart';
import 'MainContentPage.dart';

void main() {
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'SF함박눈TTF', // 앱 전체에 폰트 적용
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/favorite': (context) => const FavoritePage(),
        '/main': (context) => const MainContentPage(),
      },
    );
  }
}
