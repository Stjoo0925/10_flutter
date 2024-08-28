import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/NumberViewModel.dart';
import '../widgets/CameraWidget.dart';
import '../widgets/FormWidget.dart';

class AddNumberScreen extends StatefulWidget {
  @override
  _AddNumberScreenState createState() => _AddNumberScreenState();
}

class _AddNumberScreenState extends State<AddNumberScreen> {
  final _numberForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NumberViewModel>(context);

    return ListView(
      children: [
        Form(
            key: _numberForm,
            child: Center(
                child: Column(
                  children: [
                    CameraWidget(
                        imagePath: viewModel.numberItem?.image,
                        setMethod: viewModel.setImage),
                    FormWidget(
                      value: viewModel.numberItem?.title ?? "",
                      setValue: viewModel.setTitle,
                      label: "이름을 입력하세요",
                      keyboardType: TextInputType.text,
                    ),
                    FormWidget(
                      value: viewModel.numberItem?.phoneNumber ?? "",
                      setValue: viewModel.setPhoneNumber,
                      label: "전화번호를 입력하세요",
                      keyboardType: TextInputType.phone,
                    ),
                    FormWidget(
                      value: viewModel.numberItem?.description ?? "",
                      setValue: viewModel.setDescription,
                      label: "설명을 입력하세요",
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          viewModel.saveForm(_numberForm, context);
                        },
                        child: const Text(
                          "저장",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
            )
        )
      ],
    );
  }
}
