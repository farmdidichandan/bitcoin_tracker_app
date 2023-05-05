import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static Future<Map<String, double>> fetchData() async {
    var url = Uri.parse('https://api.coindesk.com/v1/bpi/currentprice.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Successful response
      var jsonResponse = json.decode(response.body);
      Map<String, double> currencyRates = {};
      for (var currency in jsonResponse['bpi'].keys) {
        currencyRates[currency] = jsonResponse['bpi'][currency]['rate_float'];
      }
      print(currencyRates);
      return currencyRates;
    } else {
      // Error response
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}
