import 'dart:async';

import 'package:flutter/material.dart';
import 'package:g_provider_with_status_manager/modelAndView/CounterViewModel.dart';
import 'package:provider/provider.dart';

class ProviderScreen extends StatelessWidget {

  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("---------------------");
    print("상태관리를 하는 경우");
    print("---------------------");

    return Center(
      child: Consumer<CounterViewModel>(
        child: _ProviderText(),
        builder: (context, counterViewModel, child){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              child?? Text("null"),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: counterViewModel.increment, child: Text("증가")),
              ElevatedButton(onPressed: counterViewModel.decrement, child: Text("감소")),
            ],
          );
        }
      )
    );
  }
}

class _ProviderText extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    print("---------------------");
    print("_ProviderText");
    print("---------------------");

    final counterViewModel = Provider.of<CounterViewModel>(context);

    return Text(
      "Counter : ${counterViewModel.count}",
      style: const TextStyle(fontSize: 24),
    );
  }
}