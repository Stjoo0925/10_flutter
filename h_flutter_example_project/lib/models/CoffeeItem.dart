
import 'package:hive/hive.dart';

part "CoffeeItem.g.dart";
// flutter pub get
// flutter pub run build_runner build

@HiveType(typeId: 0)
class CoffeeItem{
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  List<String>?  ingredients;

  @HiveField(3)
  String? image;

  CoffeeItem({required this.title,required this.description,required this.ingredients,required this.image});
  CoffeeItem.empty();

  // {"0":"제목 내용 리스트 이미지"}

  factory CoffeeItem.fromJson(Map<String, dynamic> json) {
    return CoffeeItem(
      title: json['title'],
      description: json['description'],
      ingredients: json["ingredients"] is List
          ? List<String>.from(json["ingredients"]) // 이미 List인 경우
          : [json["ingredients"].toString()], // String인 경우 List로 변환
      image: json["image"],
    );
  }
}