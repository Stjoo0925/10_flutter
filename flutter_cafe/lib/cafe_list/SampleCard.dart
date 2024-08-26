import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SampleCard extends StatefulWidget {
  final int index;
  final String imageUrl;
  final String title;
  final String content;
  final int productId;  // 서버에서의 제품 ID
  final VoidCallback onDelete;

  const SampleCard({
    required this.index,
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.productId,  // 서버에서의 제품 ID
    required this.onDelete,
    super.key,
  });

  @override
  _SampleCardState createState() => _SampleCardState();
}

class _SampleCardState extends State<SampleCard> {
  bool isFavorite = false;
  bool isOrderable = true;

  Future<void> _updateOrderableStatus(bool newStatus) async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:8001/products/${widget.productId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'orderablestatus': newStatus}),
    );

    if (response.statusCode == 200) {
      setState(() {
        isOrderable = newStatus;
      });

      final snackBar = SnackBar(
        content: Text(
          newStatus ? "주문 가능 상태로 변경되었습니다." : "주문 불가능 상태로 변경되었습니다.",
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      throw Exception('Failed to update orderable status');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Text(
          '${widget.index + 1}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              widget.imageUrl,
              width: 60,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.content,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });

                final snackBar = SnackBar(
                  content: Text(
                    isFavorite ? "좋아요를 눌렀습니다!" : "좋아요를 취소했습니다.",
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
            IconButton(
              icon: Transform.rotate(
                angle: 45 * 3.141592653589793238 / 180,
                child: const Icon(Icons.add_circle),
              ),
              onPressed: () {
                _updateOrderableStatus(false);  // 주문 가능 상태를 false로 업데이트
              },
            ),
          ],
        ),
      ),
    );
  }
}
