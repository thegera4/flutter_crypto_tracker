import 'package:flutter_crypto_tracker/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {

  final String url;
  Map<String, String> headers = {
    'X-CoinAPI-Key': apiKey,
  };

  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      return "Error while fetching data";
    }
  }

}