import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_flutter_example_project/controllers/NumberViewModel.dart';
import 'package:h_flutter_example_project/controllers/FavoriteViewModel.dart';
import 'package:h_flutter_example_project/models/NumberItem.dart';
import 'package:h_flutter_example_project/widgets/NumberWidget.dart';
import 'package:provider/provider.dart';

class FavoriteNumberListScreen extends StatelessWidget {

  FavoriteNumberListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteViewModel = Provider.of<FavoriteViewModel>(context);
    final numberViewModel = Provider.of<NumberViewModel>(context);

    List<int> favoriteIndices = favoriteViewModel.getFavoriteIndices();
    List<NumberItem> favoriteItems = favoriteIndices
        .where((index) => index > 0 && index <= numberViewModel.numberItems.length)
        .map((index) => numberViewModel.numberItems[index - 1])
        .toList();

    return Scaffold(
      backgroundColor: Colors.white, // 페이지 전체의 배경색을 하얀색으로 설정
      body: favoriteItems.isEmpty
          ? const Center(
        child: Text(
          "즐겨찾기 한 번호가 없습니다",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final favoriteNumber = favoriteItems[index];
          return Container(
            color: Colors.white,
            child: NumberWidget(
                numberItem: favoriteNumber, index: favoriteIndices[index]),
          );
        },
      ),
    );
  }
}
