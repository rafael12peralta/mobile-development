import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_food_app/models/tab_manager.dart';
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
  List<Widget> screens = [
    ExploreScreen(),
    RecipesScreen(),
    TobuyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, tabManager, child) => Scaffold(),
      child: Scaffold(
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
          currentIndex: TabManager().selectedTab,
            onTap: (value) {
              TabManager().goToTab(value);
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
        body: screens[TabManager().selectedTab],
      ),
    );
  }
}
