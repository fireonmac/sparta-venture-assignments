import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/features/products/product_model.dart';

class ProductsNotifier with ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '1',
      name: '꼬질꼬질 발냄새나는 신발',
      description: '3년 신고 한 번도 안빨았다고 합니다.',
      price: 100,
      imageUrl: 'https://via.placeholder.com/300x300/7B68EE/FFFFFF?text=AirPods+Pro',
      category: '의류',
    ),
    Product(
      id: '2',
      name: '목 늘어난 난닝구',
      description: '목이 너무 늘어나서 목 사이로 볼링공도 쏙 들어가겠어요!',
      price: 400,
      imageUrl: 'https://via.placeholder.com/300x300/FF1744/FFFFFF?text=Nike+AF1',
      category: '의류',
    ),
  ];

  UnmodifiableListView<Product> get products => UnmodifiableListView(_products);

  List<String> get categories {
    return _products.map((product) => product.category).toSet().toList();
  }

  List<Product> getProductsByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  Product? getProductById(int id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  void add(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void remove(String productId) {
    _products.removeWhere((product) => product.id == productId);
    notifyListeners();
  }
}