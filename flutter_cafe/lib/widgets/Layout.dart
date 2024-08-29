import 'package:flutter/material.dart';
import 'package:h_flutter_example_project/views/AddNumberScreen.dart';
import 'package:h_flutter_example_project/views/FavoriteNumberListScreen.dart';
import 'package:h_flutter_example_project/views/RootScreen.dart';

class Layout extends StatefulWidget{
  Layout({super.key});

  @override
  LayoutState createState() => LayoutState();
}


class LayoutState extends State<Layout>{
  int _currunIndex = 0;


  void _onItemTapped(int index){
    setState(() {
      _currunIndex = index;
    });
  }

  final List<Widget> _pages = [
    const Rootscreen(),
    FavoriteNumberListScreen(),
    AddNumberScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold로 변경
        appBar: AppBar(title: const Text("전화번호", style: TextStyle(color: Colors.white),), backgroundColor: Colors.black,), // AppBar 추가
        body: _pages[_currunIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: "people"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: "bookmark"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: "add"
            ),
          ],
          currentIndex: _currunIndex,
          selectedItemColor: Colors.white, // 선택된 항목 라벨 색상
          unselectedItemColor: Colors.grey, // 선택되지 않은 항목 라벨 색상
          showUnselectedLabels: true, // 선택되지 않은 항목 라벨도 표시
          onTap: _onItemTapped,
        )
    );
  }
}