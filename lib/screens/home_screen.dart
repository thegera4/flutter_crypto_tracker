import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/coin_data.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String selectedCurrency = 'USD';
  String btcRate = '0';
  String ethRate = '0';
  String ltcRate = '0';
  String dogeRate = '0';
  String xrpRate = '0';
  String adaRate = '0';
  String usdtRate = '0';
  bool isLoading = false;

  // create the list of dropdown items for Android DropdownButton
  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> dropdownItemsList = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem<String>(
        value: currency,
        child: Text(currency),
      );
      dropdownItemsList.add(newItem);
    }
    return dropdownItemsList;
  }

  // create the list of dropdown items for  for iOS CupertinoPicker
  List<Widget> getPickerItems() {
    List<Text> pickerItemsList = [];
    for (String currency in currenciesList) {
      pickerItemsList.add(Text(
          currency,
          style: const TextStyle(color: Colors.white),
      ));
    }
    return pickerItemsList;
  }

  // display DropdownButton or CupertinoPicker based on platform
  Widget getPicker() {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return
        CupertinoPicker(
          selectionOverlay: Container(),
          itemExtent: 32.0,
          onSelectedItemChanged: (selectedIndex) {
            setState(() {
              selectedCurrency = currenciesList[selectedIndex];
              getRates(selectedCurrency);
            });
          },
          children: getPickerItems(),
        );
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      return
        Center(
          child: DropdownButton<String>(
            menuMaxHeight: 200.0,
            elevation: 8,
            dropdownColor: Colors.lightBlueAccent,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            iconEnabledColor: Colors.white,
            underline: Container(),
            value: selectedCurrency,
            items: getDropdownItems(),
            onChanged: (value) {
              setState(() {
                selectedCurrency = value!;
                getRates(selectedCurrency);
              });
            },
          ),
        );
    } else {
      return const Text('Platform not supported');
    }
  }

  // call the CoinData class to get exchange rates and update the UI
  Future<void> getRates(String selectedCurrency) async {
    setState(() { isLoading = true; });
    CoinData coinData = CoinData();
    var exchangeRateMap = await coinData.getExchangeRates(selectedCurrency);
    setState(() {
      btcRate = exchangeRateMap['BTC']!;
      ethRate = exchangeRateMap['ETH']!;
      ltcRate = exchangeRateMap['LTC']!;
      dogeRate = exchangeRateMap['DOGE']!;
      xrpRate = exchangeRateMap['XRP']!;
      adaRate = exchangeRateMap['ADA']!;
      usdtRate = exchangeRateMap['USDT']!;
      isLoading = false;
    });
  }

  // get the initial rates (in USD) when the app starts
  @override
  void initState() {
    super.initState();
    getRates(selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.monetization_on),
            const SizedBox(width: 8.0),
            Text(widget.title),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 150.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 5.0,
                        color: Colors.lightBlueAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            leading: const Image(
                              image: AssetImage('images/bitcoin_icon.png'),
                              width: 32.0,
                              height: 32.0,
                            ),
                            title: isLoading ?
                            const Center(
                                child: CircularProgressIndicator(color: Colors.white,)
                            ) :
                            Center(
                              child: Text(
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                '1 BTC = $btcRate $selectedCurrency',
                              ),
                            ),
                          )
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 5.0,
                        color: Colors.lightBlueAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            leading: const Image(
                              image: AssetImage('images/ethereum_logo.png'),
                              width: 32.0,
                              height: 32.0,
                            ),
                            title: isLoading ?
                            const Center(
                                child: CircularProgressIndicator(color: Colors.white,)
                            ) :
                            Center(
                              child: Text(
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                '1 ETH = $ethRate $selectedCurrency',
                              ),
                            ),
                          ),
                          )
                        ),
                      ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 5.0,
                        color: Colors.lightBlueAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            leading: const Image(
                              image: AssetImage('images/litecoin_logo.png'),
                              width: 32.0,
                              height: 32.0,
                            ),
                            title: isLoading ?
                            const Center(
                              child: CircularProgressIndicator(color: Colors.white,),
                            ) :
                            Center(
                              child: Text(
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                '1 LTC = $ltcRate $selectedCurrency',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 5.0,
                        color: Colors.lightBlueAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            leading: const Image(
                              image: AssetImage('images/litecoin_logo.png'),
                              width: 32.0,
                              height: 32.0,
                            ),
                            title: isLoading ?
                            const Center(
                              child: CircularProgressIndicator(color: Colors.white,),
                            ) :
                            Center(
                              child: Text(
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                '1 DOGE = $dogeRate $selectedCurrency',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 5.0,
                        color: Colors.lightBlueAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            leading: const Image(
                              image: AssetImage('images/litecoin_logo.png'),
                              width: 32.0,
                              height: 32.0,
                            ),
                            title: isLoading ?
                            const Center(
                              child: CircularProgressIndicator(color: Colors.white,),
                            ) :
                            Center(
                              child: Text(
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                '1 XRP = $xrpRate $selectedCurrency',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 5.0,
                        color: Colors.lightBlueAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            leading: const Image(
                              image: AssetImage('images/litecoin_logo.png'),
                              width: 32.0,
                              height: 32.0,
                            ),
                            title: isLoading ?
                            const Center(
                              child: CircularProgressIndicator(color: Colors.white,),
                            ) :
                            Center(
                              child: Text(
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                '1 ADA = $adaRate $selectedCurrency',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 5.0,
                        color: Colors.lightBlueAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            leading: const Image(
                              image: AssetImage('images/litecoin_logo.png'),
                              width: 32.0,
                              height: 32.0,
                            ),
                            title: isLoading ?
                            const Center(
                              child: CircularProgressIndicator(color: Colors.white,),
                            ) :
                            Center(
                              child: Text(
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                '1 USDT = $usdtRate $selectedCurrency',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              width: double.infinity,
              height: 150.0,
              child: getPicker(),
            ),
          ),
      ],
      ),
    );
  }
}