import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_flutter_example_project/models/CoffeeItem.dart';

import '../service/CoffeeService.dart';
import '../views/CoffeeDetailScreen.dart';


class CoffeeViewModel extends ChangeNotifier{
  List<CoffeeItem> _coffeeItems = [];
  List<CoffeeItem> get coffeeItems => _coffeeItems;

  CoffeeItem? _coffeeItem;
  CoffeeItem? get coffeeItem => _coffeeItem;

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

  void setImage([String? path]){
    if(_coffeeItem?.image == null){
      _coffeeItem?.image = path;
    }else{
      _coffeeItem?.image = null;
    }
  }

  void setTitle(String? title){
    _coffeeItem?.title = title;
  }

  void setDescription(String? description){
    _coffeeItem?.description = description;
  }

  bool validateForm(GlobalKey<FormState> formKey){
    return formKey.currentState!.validate();
  }

  void saveForm(GlobalKey<FormState> formKey, BuildContext context) async{
    if(validateForm(formKey)){
      formKey.currentState!.save();
      if(_coffeeItem != null){
        try{
          await _coffeeService.addCoffeeItem(_coffeeItem!);
          formKey.currentState!.reset();
          _coffeeItem = CoffeeItem.empty();
          
          Navigator.pushNamed(context, "/");
        }catch(e){
          print("hive에 데이터를 저장하는 과정에서 요류 발생 : $e");
        }
      }else{
        print("coffeeItem이 유효하지 않습니다.");
      }
    }
  }
}