import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_flutter_example_project/views/RootScreen.dart';

class Layout extends StatefulWidget{
  const Layout({super.key});

  @override
  _LayoutState createState() => _LayoutState();
}


class _LayoutState extends State<Layout>{

  int _currentIndex = 0;

  void _onTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _pages = [
    const Rootscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Coffee Cards")),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.coffee),
              label: "Favorite"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "add"
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onTapped,
      ),
    );
  }
}