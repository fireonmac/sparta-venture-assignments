import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/features/cart/cart_container.dart';
import 'package:flutter_basic_venture/src/styles.dart';
import 'package:flutter_basic_venture/src/utils/navigation.dart';
import 'package:flutter_basic_venture/src/view/cart/cart_list_item.dart';
import 'package:flutter_basic_venture/src/widgets/call_to_action_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static Route<dynamic> buildRoute(BuildContext context) {
    return buildScreenRoute(context, screen: const CartScreen());
  }

  @override
  Widget build(BuildContext context) {
    final cartNotifier = CartContainer.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('장바구니'),
      ),
      body: ListenableBuilder(
        listenable: cartNotifier,
        builder: (context, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (cartNotifier.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text('장바구니가 비어있습니다'),
                    ),
                  )
                else
                  ...(cartNotifier.items).map((cartItem) {
                    return CartListItem(productId: cartItem.productId);
                  }).toList(),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: ListenableBuilder(
        listenable: cartNotifier,
        builder: (context, _) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(),
              padding: Styles.bodyPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '총 ${cartNotifier.itemCount}개',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('|', style: TextStyle(fontSize: 16)),
                      ),
                      const Text('합계: ', style: TextStyle(fontSize: 16)),
                      Icon(Icons.diamond, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${cartNotifier.totalPrice.toInt().toString()}개',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: CallToActionButton(
                      text: '전부 구매하기',
                      onPressed: cartNotifier.isEmpty ? null : () {},
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
