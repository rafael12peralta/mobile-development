import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/models/cart_model.dart';
import 'package:sneaker_store/screens/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
      ),
    );
  }
}
