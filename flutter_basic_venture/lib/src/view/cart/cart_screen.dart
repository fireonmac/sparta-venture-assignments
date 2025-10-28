import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/features/cart/cart_container.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartNotifier = CartContainer.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('장바구니')),
      body: ListView.builder(
        itemCount: cartNotifier.items.length,
        itemBuilder: (context, index) {
          final cartItem = cartNotifier.items[index];
          final product = cartNotifier.getProduct(cartItem.productId);
          return ListTile(
            title: Text(product?.name ?? '상품 정보가 없습니다.'),
            subtitle: Text('수량: ${cartItem.quantity}'),
          );
        },
      ),
    );
  }
}
