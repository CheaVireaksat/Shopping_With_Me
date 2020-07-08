import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'White T-Shirt',
    //   description: 'A White shirt - it is pretty White!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://i.ibb.co/rHMLVk9/Screen-Shot-2020-07-04-at-12-37-32-AM.png',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'A Pairs of Joggers',
    //   description: 'A nice pair of Jogger.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://i.ibb.co/Ldnkv6k/Screen-Shot-2020-07-04-at-12-37-24-AM.png',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Jeans',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://i.ibb.co/Ch11yHv/Screen-Shot-2020-07-04-at-12-36-58-AM.png',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Hoodies',
    //   description: 'A warm Hoddies for winter',
    //   price: 49.99,
    //   imageUrl:
    //       'https://i.ibb.co/pWpC4vj/Screen-Shot-2020-07-04-at-12-37-12-AM.png',
    // ),
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

  Future<void> fetchAndSetProducts() async {
    //Error handling method
    const url = 'https://shopapp-c46c7.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite']));
      });
      _items = loadedProducts;
      notifyListeners();
      // print(json.decode(response.body));
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://shopapp-c46c7.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    try {
      if (prodIndex >= 0) {
        final url = 'https://shopapp-c46c7.firebaseio.com/products/$id.json';
        await http.patch(url,
            body: json.encode({
              'title': newProduct.title,
              'description': newProduct.description,
              'imageUrl': newProduct.imageUrl,
              'price': newProduct.price,
            }));
        _items[prodIndex] = newProduct;
        notifyListeners();
      } else {
        print('...');
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
