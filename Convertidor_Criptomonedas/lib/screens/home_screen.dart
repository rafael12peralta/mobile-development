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
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Converter'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                child: Text(
                  '1 $selectedCrypto = $exchangeRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Crypto: '),
              Platform.isIOS
                  ? getIOSPicker(criptoList, (index) {
                      setState(() {
                        selectedCrypto = criptoList[index];
                        getExchangeRate();
                      });
                    })
                  : getAndroidDropdown(criptoList, selectedCrypto, (value) {
                      setState(() {
                        selectedCrypto = value!;
                        getExchangeRate();
                      });
                    }),
              SizedBox(
                width: 20,
              ),
              Text('Currency: '),
              Platform.isIOS
                  ? getIOSPicker(currencyList, (index) {
                      setState(() {
                        selectedCurrency = currencyList[index];
                        getExchangeRate();
                      });
                    })
                  : getAndroidDropdown(currencyList, selectedCurrency, (value) {
                      setState(() {
                        selectedCurrency = value!;
                        getExchangeRate();
                      });
                    }),
            ],
          ),
          Container(
            height: 150,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30),
            color: Colors.lightBlue,
            child: ElevatedButton(
                onPressed: getExchangeRate,
                child: Text('Actualizar Tasa de Cambio')),
          )
        ],
      ),
    );
  }
}
