
import 'dart:convert';

import 'package:h_flutter_example_project/models/CoffeeItem.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class CoffeeService{
  Box<CoffeeItem>? _coffeeBox;

  CoffeeService();

  Future<void> initializeHive() async{
    _coffeeBox = await Hive.openBox<CoffeeItem>("coffeeBox");
    await fetchCoffeeItems();
  }

  Future<List<CoffeeItem>> fetchCoffeeItems() async {
    if (_coffeeBox != null && _coffeeBox!.isNotEmpty) {
      // coffeebox의 데이터를 list 형식으로 반환함.
      return _coffeeBox!.values.toList();
    }

    const url = "http://10.0.2.2:8001/burgerMenu"; // 에뮬레이터에서 로컬 서버에 접근

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> fetchedItems = jsonResponse['burgerMenu']; // 'burgerMenu' 키에 접근

        List<CoffeeItem> coffeeItems = fetchedItems.map(
                (item) => CoffeeItem.fromJson(item)
        ).toList();

        for (var coffee in coffeeItems) {
          _coffeeBox?.add(coffee);
        }

        return coffeeItems;
      } else {
        print("요청 실패 : ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("에러 발생 : $e");
      return [];
    }
  }


  Future<void> deleteCoffeeItem(int index) async {
    await _coffeeBox?.deleteAt(index);
  }

  Future<void> addCoffeeItem(CoffeeItem coffeeItem) async{
    await _coffeeBox?.add(coffeeItem);
  }
}