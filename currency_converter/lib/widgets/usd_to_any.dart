import 'package:currency_converter/functions/fetch_currencies.dart';
import 'package:currency_converter/utils/custom_text.dart';
import 'package:flutter/material.dart';

class UsdToAny extends StatefulWidget {
  const UsdToAny({super.key});

  @override
  State<UsdToAny> createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {
  late Future<Map> currencies;

  @override
  void initState() {
    super.initState();

    setState(() {
      currencies = fetchCurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      color: Colors.amber,
      child: Column(
        children: [
          const CustomText(txt: 'USD to Any Currency', size: 18),
          TextField(
            decoration: InputDecoration(
                hintText: 'Enter Amount',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
        ],
      ),
    );
  }
}
