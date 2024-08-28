import 'package:hive/hive.dart';

part 'CoffeeItem.g.dart';

@HiveType(typeId: 0)
class CoffeeItem {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? image;

  CoffeeItem({required this.id, required this.title, required this.description, required this.image});

  CoffeeItem.empty();

  factory CoffeeItem.fromJson(Map<String, dynamic> json) {
    return CoffeeItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image']
    );
  }
}
