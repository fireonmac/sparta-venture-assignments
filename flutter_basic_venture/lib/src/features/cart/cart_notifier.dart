import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/features/cart/cart_item_model.dart';
import 'package:flutter_basic_venture/src/features/products/product_model.dart';

class CartNotifier with ChangeNotifier {
  final List<CartItem> _items = [];

  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_items);

  int get itemCount => _items.length;

  int get totalQuantity => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  bool get isEmpty => _items.isEmpty;

  bool get isNotEmpty => _items.isNotEmpty;

  void add(Product product, {int quantity = 1}) {
    
    notifyListeners();
  }

  void remove(int productId) {
  
    notifyListeners();
  }

  void updateQuantity(int productId, int newQuantity) {
    
    notifyListeners();
  }

  void increaseQuantity(int productId) {
    
    notifyListeners();
  }

  void decreaseQuantity(int productId) {
    
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}