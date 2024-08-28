import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  final String? value;
  final Function(String?) setValue;
  final String label; // 라벨 텍스트
  final double labelFontSize; // 라벨 폰트 사이즈
  final TextInputType keyboardType; // 키보드 타입

  FormWidget({
    required this.value,
    required this.setValue,
    required this.label,
    this.labelFontSize = 16.0, // 기본 폰트 사이즈 설정
    this.keyboardType = TextInputType.text, // 기본값을 일반 텍스트 입력으로 설정
  });

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.value,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          fontSize: widget.labelFontSize, // 라벨의 폰트 크기 설정
          color: Colors.grey,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "값을 입력해주세요";
        }
        return null;
      },
      onSaved: widget.setValue,
      keyboardType: widget.keyboardType, // 키보드 타입 설정
    );
  }
}
