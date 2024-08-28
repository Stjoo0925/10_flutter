import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_flutter_example_project/models/NumberItem.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class NumberDetailScreen extends StatelessWidget {
  final NumberItem? numberItem;

  NumberDetailScreen({required this.numberItem, super.key});

  String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 11) {
      return '${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 7)}-${phoneNumber.substring(7, 11)}';
    } else if (phoneNumber.length == 10) {
      return '${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6, 10)}';
    }
    return phoneNumber; // 기본 형식 반환
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;
    if (numberItem!.image == null || numberItem!.image!.isEmpty) {
      widget = Container(
        width: double.infinity,
        height: 500,
        color: Colors.grey,
        child: const Center(child: Text("이미지가 없습니다.")),
      );
    } else {
      bool isFile = numberItem!.image.toString().startsWith("file://") ||
          File(numberItem!.image.toString()).existsSync();
      widget = isFile
          ? FutureBuilder<File>(
        future: File(numberItem!.image.toString()).existsSync()
            ? Future.value(File(numberItem!.image.toString()))
            : null,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('이미지 로드 실패'));
          } else if (snapshot.hasData) {
            return Image.file(
              snapshot.data!,
              fit: BoxFit.fill,
            );
          } else {
            return const Center(child: Text('파일 없음'));
          }
        },
      )
          : Image.network(
        numberItem!.image.toString(),
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        },
      );
    }

    final formattedPhoneNumber = formatPhoneNumber(numberItem!.phoneNumber!);
    final uri = Uri.parse("tel:+82${numberItem!.phoneNumber}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          numberItem!.title.toString(),
          style: TextStyle(color: Colors.white), // 텍스트 색상을 흰색으로 설정
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white, // 뒤로가기 버튼(및 AppBar의 다른 아이콘) 색상 설정
        ),// AppBar의 배경색 설정
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: 350, // 원형을 유지하기 위해 width와 height를 동일하게 설정
            height: 350,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle, // 원형 모양을 지정
                border: Border.all(
                  color: Colors.black, // 테두리 색상 설정
                  width: 4.0, // 테두리 두께 설정
                ),
              ),
              child: ClipOval(
                child: widget, // 이미지 또는 콘텐츠를 원형으로 자름
              ),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0), // 상하단 마진 추가
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey, // 상단 보더라인 색상
                      width: 2.0, // 상단 보더라인 두께
                    ),
                    bottom: BorderSide(
                      color: Colors.grey, // 하단 보더라인 색상
                      width: 2.0, // 하단 보더라인 두께
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                        "전화번호 : ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "$formattedPhoneNumber",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () async {
                        var status = await Permission.phone.request();
                        if (status.isGranted) {
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          } else {
                            print("전화걸기 실패");
                          }
                        } else {
                          print("권한을 승인해주세요");
                        }
                      },
                      icon: const Icon(Icons.call),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                  "설명",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text("${numberItem!.description}"),
            ],
          ),
        ],
      ),
    );
  }
}
