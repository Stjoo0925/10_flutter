import 'package:flutter/material.dart';

class LikeSnack extends StatelessWidget {
  const LikeSnack({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "좋아요 버튼을 눌렀습니다!",
      style: TextStyle(color: Colors.white),
    );
  }
}

class UnLikeSnack extends StatelessWidget {
  const UnLikeSnack({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "좋아요 버튼을 취소 하셨습니다!",
      style: TextStyle(color: Colors.white),
    );
  }
}
