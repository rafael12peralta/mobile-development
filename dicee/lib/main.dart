import 'package:flutter/material.dart';

import 'home.dart';

void main() => runApp(Dicee());

class Dicee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          //useMaterial3: false,
          ),
      debugShowCheckedModeBanner: true,
      home: Home(),
    );
  }
}