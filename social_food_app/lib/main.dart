import 'package:flutter/material.dart';
import 'package:social_food_app/components/theme_button.dart';
import 'package:social_food_app/food_theme.dart';
import 'package:social_food_app/home.dart';

void main() => runApp(FoodSocialApp());

class FoodSocialApp extends StatefulWidget {
  @override
  State<FoodSocialApp> createState() => _FoodSocialAppState();
}

class _FoodSocialAppState extends State<FoodSocialApp> {
  ThemeData theme = FoodTheme.light();

  void changeThemeMode(bool isLightMode) {
    setState(() {
      if (isLightMode) {
        theme = FoodTheme.light();
      } else {
        theme = FoodTheme.dark();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Food Social App';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      title: appTitle,
      home: Home(
        changeThemeMode: changeThemeMode,
        appTitle: appTitle,
      ),
    );
  }
}
