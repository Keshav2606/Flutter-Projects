import 'package:currency_converter/models/all_currencies.dart';
import 'package:currency_converter/utils/app_id.dart';
import 'package:currency_converter/models/rates_model.dart';
import 'package:http/http.dart' as http;

Future<RatesModel> fetchRates() async {
  String url =
      'https://openexchangerates.org/api/latest.json?base=usd&app_id=$appId';
  
  var response = await http.get(Uri.parse(url));

  final result = ratesModelFromJson(response.body);

  return result;
}

Future<Map> fetchCurrencies() async {
  String url =
      'https://openexchangerates.org/api/currencies.json?app_id=$appId';

  var response = await http.get(Uri.parse(url));

  final allCurrencies = allCurrenciesFromJson(response.body);

  return allCurrencies;
}
