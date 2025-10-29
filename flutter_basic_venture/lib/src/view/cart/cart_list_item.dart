import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/features/cart/cart_container.dart';
import 'package:flutter_basic_venture/src/styles.dart';
import 'package:flutter_basic_venture/src/widgets/quantity_control.dart';

class CartListItem extends StatelessWidget {
  final String productId;

  const CartListItem({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final cartNotifier = CartContainer.of(context);
    final cartItem = cartNotifier.items.firstWhere(
      (item) => item.productId == productId,
      orElse: () => throw StateError('카트 아이템이 없습니다!'),
    );
    final product = cartNotifier.getProduct(productId);

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.only(top: 0, left: 0, right: 12.0, bottom: 0),
      decoration: BoxDecoration(
        borderRadius: Styles.cardBorderRadius,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: Styles.cardBorderRadius,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child:
                        (product?.imageUrl != null &&
                            product!.imageUrl.isNotEmpty)
                        ? Image.network(
                            product.imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              return progress == null
                                  ? child
                                  : const SizedBox.expand();
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.broken_image_outlined),
                              );
                            },
                          )
                        : Container(
                            color: Colors.grey.shade200,
                            child: const Icon(
                              Icons.shopping_bag_outlined,
                              size: 30,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product?.name ?? '상품명 없음',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.sunny, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      (product?.price ?? 0).toInt().toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                QuantityControl(
                  quantity: cartItem.quantity,
                  onIncrement: () {
                    cartNotifier.updateQuantity(
                      productId,
                      cartItem.quantity + 1,
                    );
                  },
                  onDecrement: () {
                    cartNotifier.updateQuantity(
                      productId,
                      cartItem.quantity - 1,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
