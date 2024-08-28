import 'dart:io';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String? image;

  ImageWidget({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    if (image == null || image!.isEmpty) {
      return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle, // 둥근 모양으로 설정
          border: Border.all(color: Colors.black, width: 2), // 테두리 추가
        ),
        child: const Center(child: Text("이미지 없음")),
      );
    }

    // 이미지가 파일 경로인지 확인
    bool isFile = image!.startsWith('file://') || File(image!).existsSync();

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle, // 둥근 모양으로 설정
        border: Border.all(color: Colors.black, width: 2), // 테두리 추가
      ),
      child: ClipOval(
        child: isFile
            ? FutureBuilder<File>(
          future: File(image!).existsSync() ? Future.value(File(image!)) : null,
          builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('이미지 로드 실패'));
            } else if (snapshot.hasData) {
              return Image.file(snapshot.data!, fit: BoxFit.cover);
            } else {
              return const Center(child: Text('파일 없음'));
            }
          },
        )
            : Image.network(
          image!,
          fit: BoxFit.cover, // 이미지를 꽉 채우도록 설정
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
