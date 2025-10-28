import 'package:flutter_basic_venture/src/features/products/product_model.dart';

class CartItem {
  final String productId;
  int quantity;

  CartItem({
    required this.productId,
    this.quantity = 1,
  });

  double getTotalPrice(Product product) => product.price * quantity;
}