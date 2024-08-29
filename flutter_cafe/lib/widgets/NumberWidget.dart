import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_flutter_example_project/controllers/NumberViewModel.dart';
import 'package:h_flutter_example_project/controllers/FavoriteViewModel.dart';
import 'package:h_flutter_example_project/models/NumberItem.dart';
import 'package:h_flutter_example_project/widgets/ImageWidget.dart';
import 'package:provider/provider.dart';

class NumberWidget extends StatelessWidget {
  final NumberItem numberItem;
  final int index;

  const NumberWidget({required this.numberItem, required this.index});

  @override
  Widget build(BuildContext context) {
    final favoriteViewModel = Provider.of<FavoriteViewModel>(context);
    final numberViewModel = Provider.of<NumberViewModel>(context);

    bool isTrue = favoriteViewModel.isFavorite(index);

    // 전화번호 형식 변환 함수
    String formatPhoneNumber(String phoneNumber) {
      if (phoneNumber.length == 11) {
        return '${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 7)}-${phoneNumber.substring(7, 11)}';
      } else if (phoneNumber.length == 10) {
        return '${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6, 10)}';
      }
      return phoneNumber; // 기본 형식 반환
    }

    return Container(
      width: double.infinity,
      height: 150,
      color: Colors.white,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(Colors.white)),
        onPressed: () => numberViewModel.detailsNumberItem(context, index),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("$index"),
              const SizedBox(width: 20),
              ImageWidget(image: numberItem.image.toString()),
              const SizedBox(width: 25),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${numberItem.title}",
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      formatPhoneNumber(numberItem.phoneNumber ?? ''), // null일 경우 빈 문자열 처리
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                  onPressed: () {
                    favoriteViewModel.toggleFavorite(index);
                  },
                  icon: Icon(
                    isTrue ? Icons.bookmark : Icons.bookmark_border,
                    color: isTrue ? Colors.black : Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                  onPressed: () {
                    numberViewModel.deleteItem(context, index - 1);
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
