import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LikeSnack.dart'; // LikeSnack.dart를 임포트

class SampleCard extends StatefulWidget {
  const SampleCard({super.key});

  @override
  _SampleCardState createState() => _SampleCardState();
}

class _SampleCardState extends State<SampleCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double imageWidth = constraints.maxWidth * 0.25;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/coffee.jpg',
                width: imageWidth,
                height: imageWidth,
              ),
              const SizedBox(width: 20),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '제목 : 커피',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    Text(
                      '내용 : 맛있는 커피',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    Text(
                      '이 커피는 맛 있습니다',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
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

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.blueAccent,
                          content: isFavorite
                              ? const LikeSnack()
                              : const UnLikeSnack(),
                          duration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(2),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
