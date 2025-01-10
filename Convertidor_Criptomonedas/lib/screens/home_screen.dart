import 'dart:io';
import 'package:convertidor_criptomonedas/data.dart';
import 'package:convertidor_criptomonedas/services/converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCurrency = 'DOP';
  String selectedCrypto = 'BTC';
  String exchangeRate = '?';

  DropdownButton<String> getAndroidDropdown(
      List<String> items, String value, Function(String?) onChanged) {
    return DropdownButton(
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  CupertinoPicker getIOSPicker(
      List<String> items, Function(int) onSelectedItemChanged) {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: onSelectedItemChanged,
      children: items.map((item) => Text(item)).toList(),
    );
  }

  void getExchangeRate() async {
    CurrencyConverter converter = CurrencyConverter();
    var rate =
        await converter.getExchangeRate(selectedCrypto, selectedCurrency);

    setState(() {
      exchangeRate = rate != null ? rate.toStringAsFixed(2) : '?';
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.lightBlue;

    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Converter'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
            child: Card(
              color: primaryColor,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                child: Text(
                  '1 $selectedCrypto = $exchangeRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    color: primaryColor,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      title: Text(
                        'Select Crypto',
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Platform.isIOS
                          ? getIOSPicker(cryptoList, (index) {
                              setState(() {
                                selectedCrypto = cryptoList[index];
                                getExchangeRate();
                              });
                            })
                          : getAndroidDropdown(cryptoList, selectedCrypto,
                              (value) {
                              setState(() {
                                selectedCrypto = value!;
                                getExchangeRate();
                              });
                            }),
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    color: primaryColor,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      title: Text(
                        'Select Currency',
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Platform.isIOS
                          ? getIOSPicker(currencyList, (index) {
                              setState(() {
                                selectedCurrency = currencyList[index];
                                getExchangeRate();
                              });
                            })
                          : getAndroidDropdown(currencyList, selectedCurrency,
                              (value) {
                              setState(() {
                                selectedCurrency = value!;
                                getExchangeRate();
                              });
                            }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 15),
            color: Colors.white,
            child: ElevatedButton(
              onPressed: getExchangeRate,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                elevation: 5,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Update Exchange Rate',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
