import 'package:flutter/material.dart';
import 'package:g_provider_with_status_manager/modelAndView/CounterViewModel.dart';
import 'package:g_provider_with_status_manager/view/NonStateScreen.dart';
import 'package:g_provider_with_status_manager/view/ProviderScreen.dart';
import 'package:provider/provider.dart';

/// provider
/// flutter에서 상태 관리를 위한 인기 있는 패턴이자 라이브러리로 간단하고 직관적인 api를 통해
/// 애플리키이션의 상태를 효율적으로 관리할 수 있도록 해준다.
/// provider는 flutter의 inheritedWidget을 기반으로 하고 있으며, 상태를 공유하고 위젯 트리에서
/// 필요한 곳에서 쉽게 접글할 수 있도록 한다.

void main() {
  runApp(

      ChangeNotifierProvider(
        create: (context) => CounterViewModel(),
        child: MainApp(),
      )
  );
}

class MainApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Root(),
    );
  }
}

class Root extends StatefulWidget {

  @override
  RootState createState() => RootState();
}

class RootState extends State<Root> {
  int _currentPage = 0;

  List<Widget> pages = [
    NonStateScreen(),
    ProviderScreen(),
  ];

  void _onTap(int index){
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("counter")),
      body: pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.block),
              label: "상태 관리가 없는 화면"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.backup),
              label: "상태 관리"
          )
        ],
        currentIndex: _currentPage,
        onTap: _onTap,
      ),
    );
  }
}