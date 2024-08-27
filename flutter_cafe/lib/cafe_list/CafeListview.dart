import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // http 패키지 import
import 'dart:convert'; // json 파싱을 위한 import
import 'SampleCard.dart'; // SampleCard 위젯 import

class DynamicListView extends StatefulWidget {
  const DynamicListView({super.key});

  @override
  _DynamicListViewState createState() => _DynamicListViewState();
}

class _DynamicListViewState extends State<DynamicListView> {
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8001/cafe_list'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        items = data
            .where((item) => item['orderablestatus'] == true) // 주문 가능 상태가 true인 항목만 필터링
            .map((item) {
          return {
            "productId": item["id"], // 프로덕트 ID
            "imageUrl": item["imageUrl"],
            "title": item["title"],
            "content": item["content"],
          };
        })
            .toList();
      });
    } else {
      throw Exception('리스트 가져오기 실패');
    }
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index); // 리스트에서 항목 삭제
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: double.infinity,
              height: 130,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5DC),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.brown),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26, // 그림자 색상
                    offset: Offset(0, 2), // 그림자 위치
                    blurRadius: 6.0, // 그림자 흐림 정도
                  ),
                ],
              ),
              padding: const EdgeInsets.all(3.0),
              child: SampleCard(
                index: index,
                imageUrl: items[index]["imageUrl"] as String, // 이미지 URL
                title: items[index]["title"] as String, // 제목
                content: items[index]["content"] as String, // 내용
                onDelete: () => _deleteItem(index), // 삭제 함수
              ),
            ),
          );
        },
      ),
    );
  }
}
