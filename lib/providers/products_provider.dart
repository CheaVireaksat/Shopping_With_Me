import 'package:flutter/material.dart';

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'White T-Shirt',
      description: 'A White shirt - it is pretty White!',
      price: 29.99,
      imageUrl:
          'https://i.ibb.co/rHMLVk9/Screen-Shot-2020-07-04-at-12-37-32-AM.png',
    ),
    Product(
      id: 'p2',
      title: 'Joggers',
      description: 'A nice pair of Jogger.',
      price: 59.99,
      imageUrl:
          'https://i.ibb.co/Ldnkv6k/Screen-Shot-2020-07-04-at-12-37-24-AM.png',
    ),
    Product(
      id: 'p3',
      title: 'Jeans',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://i.ibb.co/Ch11yHv/Screen-Shot-2020-07-04-at-12-36-58-AM.png',
    ),
    Product(
      id: 'p4',
      title: 'Hoodies',
      description: 'A warm Hoddies for winter',
      price: 49.99,
      imageUrl:
          'https://i.ibb.co/pWpC4vj/Screen-Shot-2020-07-04-at-12-37-12-AM.png',
    ),
  ];
  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}
