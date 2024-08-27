import 'package:flutter/cupertino.dart';

class CounterViewModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count; // java의 gatter와 같은 역할

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }

}