import 'package:flutter/material.dart';
import 'package:h_flutter_example_project/models/NumberItem.dart';
import 'package:h_flutter_example_project/services/PhoneService.dart';
import 'package:h_flutter_example_project/views/NumberDetailScreen.dart';
import '../services/PhoneService.dart';

class NumberViewModel extends ChangeNotifier {
  List<NumberItem> _numberItems = [];

  List<NumberItem> get numberItems => _numberItems;

  NumberItem? _numberItem = NumberItem.empty();
  NumberItem? get numberItem => _numberItem;

  final NumberService _numberService;

  NumberViewModel(this._numberService) {
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    _numberItems = (await _numberService.initializeHive())!;
    notifyListeners();
  }


  Future<void> detailsNumberItem(BuildContext context, int index) async {
    _numberItem = _numberItems[index-1];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NumberDetailScreen(numberItem: _numberItem)));

    notifyListeners();
  }

  void deleteItem(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("전화번호 삭"),
              content: Text("정말로 이 번호를 삭제하시겠습니까?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 대화 상자 닫기
                    },
                    child: Text("취소")),
                TextButton(
                    onPressed: () async {
                      try {
                        await _numberService.deletePhoneItem(index);

                        _numberItems.removeAt(index);
                        notifyListeners();
                        Navigator.of(context).pop();
                      } catch (e) {
                        print("삭제 중 오류 발생 : $e");
                      }
                    },
                    child: Text("삭제"))
              ],
            ));
  }

  void setImage(String? path) {
    if (path != null) {
      _numberItem?.image = path;
    } else {
      _numberItem?.image = null;
    }

    notifyListeners();
  }

  void setTitle(String? title) {
    _numberItem?.title = title;
  }

  void setDescription(String? description) {
    _numberItem?.description = description;
  }

  void setPhoneNumber(String? phoneNumber){
    _numberItem?.phoneNumber = phoneNumber;
  }

  bool validateForm(GlobalKey<FormState> formKey) {
    return formKey.currentState!.validate();
  }

  void saveForm(GlobalKey<FormState> formKey, BuildContext context) async {
    if (validateForm(formKey)) {
      formKey.currentState!.save();

      if (_numberItem != null) {
        try {
          await _numberService.addPhoneItem(_numberItem!); // hive에 저장
          _numberItems.add(_numberItem!);
          formKey.currentState!.reset(); // 폼 리셋
          _numberItem = NumberItem.empty();
          notifyListeners();
          Navigator.pushNamed(context, "/");
        } catch (e) {
          print("hive에 데이터를 저장하는 과정에서 오류 발생 : $e");
        }
      } else {
        print("전화번호가 유효하지 않습니다.");
      }
    }
  }
}
