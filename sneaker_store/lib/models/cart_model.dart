import 'package:flutter/material.dart';
import 'package:sneaker_store/models/shoe_model.dart';

class Cart extends ChangeNotifier {
  //list of shoes for sale
  List<Shoe> shoeShop = [
    Shoe(
      name: 'Zoom FREAK',
      price: '236',
      imagePath: 'assets/images/sneakers-1.png',
      description: 'The foward-thinking design of lastest signature shoe',
    ),
    Shoe(
      name: 'Air Jordan',
      price: '220',
      imagePath: 'assets/images/sneakers-2.jpg',
      description:
          'You\'ve got the hops and the speed-lace up in shoes that enhanced all',
    ),
    Shoe(
      name: 'KD Treys',
      price: '240',
      imagePath: 'assets/images/sneakers-3.png',
      description: 'The foward-thinking design of lastest signature shoe',
    ),
    Shoe(
      name: 'Kyrie 6',
      price: '190',
      imagePath: 'assets/images/sneakers-4.png',
      description: 'Bouncy cushioning is paored with soft yet supportlive foam',
    ),
  ];

  //list of items in user cart
  List<Shoe> userCart = [];

  //get list of shoes for sale
  List<Shoe> getShoeList() {
    return shoeShop;
  }
  //get cart
  List<Shoe> getUserCart() {
    return userCart;
  }
  //add items to cart
  void addItemToCart(Shoe shoe){
    userCart.add(shoe);
    notifyListeners();
  }
  //remove items from cart
  void removeItemFromCart(Shoe shoe) {
    userCart.remove(shoe);
    notifyListeners();
  }
}
