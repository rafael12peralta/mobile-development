import 'package:flutter/material.dart';

import 'components/theme_button.dart';

class Home extends StatefulWidget {
   Home({super.key, required this.appTitle, required this.changeThemeMode});

  final appTitle;
  final void Function(bool useLightMode) changeThemeMode;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.appTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          ThemeButton(changeTheme: widget.changeThemeMode)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'EXPLORE'),
            BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard),
                label: 'Recipes'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'To Buy'),
          ]),
      body: Center(
        child: Container(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
