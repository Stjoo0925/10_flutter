import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_flutter_example_project/models/CoffeeItem.dart';

import '../service/CoffeeService.dart';
import '../views/CoffeeDetailScreen.dart';


class CoffeeViewModel extends ChangeNotifier{
  List<CoffeeItem> _coffeeItems = [];
  List<CoffeeItem> get coffeeItems => _coffeeItems;

  CoffeeItem? _coffeeItem;

  final CoffeeService _coffeeService;

  CoffeeViewModel(this._coffeeService){
    _initializeHive();
  }

  Future<void> _initializeHive() async{
    await _coffeeService.initializeHive();
    await fetchCoffeeItems();
  }

  Future<void> fetchCoffeeItems() async{
    _coffeeItems = await _coffeeService.fetchCoffeeItems();
    notifyListeners();
  }

  Future<void> detailsCofffeeItem(BuildContext context, int index) async {
    _coffeeItem = _coffeeItems[index];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CoffeeDetailScreen(coffeeItem:_coffeeItem)
        )
    );

    notifyListeners();

  }

  void deleteItem(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
        title: Text("삭제확인"),
          content: Text("정말로 이 항목을 삭제하시겠습니까?"),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop(); // 대화 상자 닫기
                },
                child: Text("취소")
            ),
            TextButton(onPressed: () async{
              try{
                await _coffeeService.deleteCoffeeItem(index);
                coffeeItems.removeAt(index);
                notifyListeners();
                Navigator.of(context).pop();
              } catch(e){
                print("삭제중 오류 발생");
              }
              },
                child: Text("삭제")
            )
          ],
    )
    );
  }
}