import 'package:flutter/material.dart';
import 'cafe_list/CafeListview.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Coffee Card",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blue,
        ),

        body: Container(
          child: DynamicListView(),
        ),

        bottomNavigationBar: SizedBox(
          width: double.infinity,
          height: 60,
          child: Container(
            color: Colors.grey,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home, color: Colors.white),
                    SizedBox(height: 5),
                    Text('Home', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.coffee, color: Colors.white),
                    SizedBox(height: 5),
                    Text('Favorite', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(height: 5),
                    Text('Main', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
