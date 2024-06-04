import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/coin_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String selectedCurrency = 'USD';

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
            print(selectedIndex);
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
              });
            },
          ),
        );
    } else {
      return const Text('Platform not supported');
    }
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
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 5.0,
                    color: Colors.lightBlueAccent,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          '1 BTC = 50,000 USD'
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 150.0,
              color: Colors.blue,
              child: getPicker(),
            ),
          ),
      ],
      ),
    );
  }
}