import 'package:currency_converter/utils/custom_text.dart';
import 'package:currency_converter/widgets/usd_to_any.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(txt: 'Flutter Currency Converter', size: 25),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: const Column(
        children: [UsdToAny()],
      ),
    );
  }
}
