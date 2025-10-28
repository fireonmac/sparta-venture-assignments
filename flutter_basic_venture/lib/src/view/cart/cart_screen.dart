import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/features/cart/cart_container.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartNotifier = CartContainer.of(context);
    final count = cartNotifier.items.length;

    return Scaffold(
      appBar: AppBar(title: const Text('장바구니')),
      body: Center(child: Text('장바구니에 담은 아이템 갯수: $count')),
    );
  }
}
