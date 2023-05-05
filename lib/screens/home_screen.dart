import 'dart:ffi';

import 'package:bitcoin_tracker_app/screens/api/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final List<String> items = ['AUD'];
  final List<double> price = [];
  TextEditingController _priceController = TextEditingController(text: 'PRICE');

  @override
  void initState() {
    super.initState();
    ApiClient.fetchData().then((currencyRates) {
      currencyRates.forEach((currency, rate) {
        setState(() {
          items.add(currency);
          price.add(rate);
        });
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Center(
              child: Image.asset(
                'assets/logos/bitcoin.png',
                width: 100,
                height: 100,
              ),
            ),
          ),
          TextField(
  controller: _priceController,
  textAlign: TextAlign.center,
  style: TextStyle(
    fontSize: 30,
    color: Colors.white,
  ),
  // decoration: InputDecoration(
  //   hintText: 'PRICE',
  // ),
),

          SizedBox(height: 50),
          Container(
            height: 200,
            child: ListWheelScrollView.useDelegate(
              itemExtent: 40,
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedIndex = index;
                  if (selectedIndex == 0) {
                    _priceController.text = 'PRICE';
                  } else {
                    _priceController.text = price[selectedIndex - 1].toString();
                  }
                });
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  return ListTile(
                    title: Text(
                      textAlign: TextAlign.center,
                      items[index],
                      style: TextStyle(
                        fontSize: 20,
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    selectedTileColor: Colors.blue,
                    selected: selectedIndex == index,
                  );
                },
                childCount: items.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
