import 'package:flutter_crypto_tracker/services/networking.dart';
import 'constants.dart';

class CoinData {

  Future<Map<String, String>> getExchangeRates(String selectedCurrency) async {
    Map<String, String> cryptoRates = {};
    NetworkHelper networkHelper;
    for (String crypto in cryptoList) {
      networkHelper = NetworkHelper('$coinApiBaseURL/$crypto/$selectedCurrency');
      var data = await networkHelper.getData();
      double rate = data['rate'];
      cryptoRates[crypto] = rate.toStringAsFixed(2);
    }
    return cryptoRates;
  }

}