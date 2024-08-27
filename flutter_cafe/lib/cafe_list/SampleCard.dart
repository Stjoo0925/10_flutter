import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SampleCard extends StatefulWidget {
  final int index;
  final String imageUrl;
  final String title;
  final String content;
  final VoidCallback onDelete;

  const SampleCard({
    required this.index,
    required this.imageUrl,
    required this.title,
    required this.content,
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
    // UI를 즉각적으로 업데이트
    setState(() {
      isOrderable = newStatus;
    });

    final response = await http.put(
      Uri.parse('http://10.0.2.2:8001/products/${widget.index}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'orderablestatus': newStatus}),
    );

    if (response.statusCode != 200) {
      // 요청 실패 시 상태를 복원
      setState(() {
        isOrderable = !newStatus;
      });
      throw Exception('Failed to update orderable status');
    }

    final snackBar = SnackBar(
      content: Text(
        newStatus ? "주문 가능 상태로 변경되었습니다." : "주문 불가능 상태로 변경되었습니다.",
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _updateFavoriteStatus(bool newStatus) async {
    // UI를 즉각적으로 업데이트
    setState(() {
      isFavorite = newStatus;
    });

    try {
      if (newStatus) {
        // 좋아요를 추가하는 경우
        final favoriteData = {
          'index': widget.index,
          'imageUrl': widget.imageUrl,
          'title': widget.title,
          'content': widget.content,
        };

        final response = await http.post(
          Uri.parse('http://10.0.2.2:8001/cafe_favorite'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(favoriteData),
        );

        if (response.statusCode != 200 && response.statusCode != 201) {
          throw Exception('Failed to add favorite');
        }

        final snackBar = SnackBar(content: Text("좋아요를 눌렀습니다!"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        // 좋아요를 취소하는 경우
        final response = await http.delete(
          Uri.parse('http://10.0.2.2:8001/cafe_favorite/${widget.index}'),
        );

        if (response.statusCode != 200 && response.statusCode != 204) {
          throw Exception('Failed to remove favorite');
        }

        final snackBar = SnackBar(content: Text("좋아요를 취소했습니다."));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      // 요청 실패 시 상태를 복원
      setState(() {
        isFavorite = !newStatus;
      });

      final snackBar = SnackBar(content: Text("좋아요 상태 변경에 실패했습니다."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                _updateFavoriteStatus(!isFavorite);
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
