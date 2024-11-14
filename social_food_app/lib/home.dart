import 'package:flutter/material.dart';
import 'package:social_food_app/screens/explore_screen.dart';
import 'package:social_food_app/screens/recipes_screen.dart';
import 'package:social_food_app/screens/tobuy_screen.dart';

import 'components/theme_button.dart';

class Home extends StatefulWidget {
   Home({super.key, required this.appTitle, required this.changeThemeMode});

  final appTitle;
  final void Function(bool useLightMode) changeThemeMode;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentScreen = 0;
  List<Widget> screens = [
    ExploreScreen(),
    RecipesScreen(),
    TobuyScreen(),
  ];

  void changeScreen(int index){
    setState(() {
      currentScreen = index;
    });
  }

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
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: currentScreen,
          onTap: (value) {
            changeScreen(value);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard),
                label: 'Recipes'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'To Buy'),
          ]),
      body: screens[currentScreen],
    );
  }
}
