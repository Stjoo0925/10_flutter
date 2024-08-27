import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'CustomAppBar.dart';
import 'CustomBottomNavBar.dart';

class MainContentPage extends StatelessWidget {
  const MainContentPage({super.key});

  Future<void> _addNewItem(BuildContext context) async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    final TextEditingController imageUrlController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('메뉴 추가'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: '메뉴이름'),
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: '메뉴설명'),
              ),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: '이미지 URL'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('추가'),
              onPressed: () async {
                final title = titleController.text;
                final content = contentController.text;
                final imageUrl = imageUrlController.text;
                if (title.isNotEmpty && content.isNotEmpty && imageUrl.isNotEmpty) {
                  await _submitNewItem(title, content, imageUrl);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitNewItem(String title, String content, String imageUrl) async {
    final String url = 'http://10.0.2.2:8001/cafe_list';
    final Map<String, dynamic> newItem = {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "imageUrl": imageUrl,
      "title": title,
      "content": content,
      "orderablestatus": true,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newItem),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("메뉴가 성공적으로 추가되었습니다.");
    } else {
      print("메뉴 추가 실패: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Main Page"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("This is the Main Page"),
            ElevatedButton(
              onPressed: () {
                _addNewItem(context);
              },
              child: const Text('새 항목 추가'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
