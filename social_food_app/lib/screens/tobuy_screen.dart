import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_food_app/components/card3.dart';
import 'package:social_food_app/models/grocery_manager.dart';
import 'package:social_food_app/screens/empty_grocery_screen.dart';

class TobuyScreen extends StatelessWidget {
  const TobuyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: buildGroceryScreen(),
    ); //buildGroceryScreen();
  }

  Consumer<GroceryManager> buildGroceryScreen() {
    return Consumer<GroceryManager>(
      builder: (context, manager, child) {
        if (manager.groceryItem.isNotEmpty) {
          return Container();
        } else {
          return EmptyGroceryScreen();
        }
      },
    );
  }
}
