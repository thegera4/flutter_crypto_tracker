import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
              height: 150.0,
              color: Colors.blue,
            ),
          ),
      ],
      ),
    );
  }
}
