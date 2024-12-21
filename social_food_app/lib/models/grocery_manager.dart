import 'package:flutter/cupertino.dart';
import 'package:social_food_app/models/grocery_item.dart';

class GroceryManager extends ChangeNotifier{
  final _groceryItems = <GroceryItem>[];

  List<GroceryItem> get groceryItem => List.unmodifiable(_groceryItems);

  void addItem(GroceryItem item) {
    _groceryItems.add(item);
    notifyListeners();
  }

  void deleteItem(int index) {
    _groceryItems.removeAt(index);
    notifyListeners();
  }

  void updateItem(GroceryItem item, int index) {
    _groceryItems[index] = item;
    notifyListeners();
  }

  void completeITem(int index, bool change) {
    final item = _groceryItems[index];
    _groceryItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}