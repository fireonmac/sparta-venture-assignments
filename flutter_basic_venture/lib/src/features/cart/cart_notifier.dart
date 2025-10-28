import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/features/cart/cart_item_model.dart';
import 'package:flutter_basic_venture/src/features/products/product_model.dart';
import 'package:flutter_basic_venture/src/features/products/products_notifier.dart';

class CartNotifier with ChangeNotifier {
  final ProductsNotifier _productsNotifier;

  CartNotifier(this._productsNotifier);

  final List<CartItem> _items = [CartItem(productId: '1', quantity: 1)];

  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_items);

  int get itemCount => _items.length;

  int get totalQuantity => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice {
    double total = 0.0;
    for (final item in _items) {
      final product = _productsNotifier.getProductById(item.productId);
      if (product != null) {
        total += item.getTotalPrice(product);
      }
    }
    return total;
  }

  bool get isEmpty => _items.isEmpty;

  bool get isNotEmpty => _items.isNotEmpty;

  Product? getProduct(String productId) {
    return _productsNotifier.getProductById(productId);
  }

  void add(Product product, {int quantity = 1}) {
    final existingIndex = _items.indexWhere(
      (item) => item.productId == product.id,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(productId: product.id, quantity: quantity));
    }
    notifyListeners();
  }

  void remove(String productId) {
    _items.removeWhere((item) => item.productId == productId);
    notifyListeners();
  }

  void updateQuantity(String productId, int newQuantity) {
    final index = _items.indexWhere((item) => item.productId == productId);
    if (index >= 0) {
      if (newQuantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = newQuantity;
      }
      notifyListeners();
    }
  }

  void increaseQuantity(String productId) {
    final index = _items.indexWhere((item) => item.productId == productId);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(String productId) {
    final index = _items.indexWhere((item) => item.productId == productId);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
