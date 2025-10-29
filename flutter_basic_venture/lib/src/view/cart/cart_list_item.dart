import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/features/cart/cart_container.dart';
import 'package:flutter_basic_venture/src/widgets/list_item_container.dart';
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

    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return ListItemContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: (product?.imageUrl != null &&
                              product!.imageUrl.isNotEmpty)
                          ? Image.network(
                              product.imageUrl,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                return progress == null
                                    ? child
                                    : const Center(
                                        child: CircularProgressIndicator());
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: colorScheme.surfaceContainer,
                                  child: Icon(
                                    Icons.broken_image_outlined,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                );
                              },
                            )
                          : Container(
                              color: colorScheme.surfaceContainer,
                              child: Icon(
                                Icons.shopping_bag_outlined,
                                size: 30,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product?.name ?? '상품명 없음',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.sunny,
                        size: 16,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        (product?.price ?? 0).toInt().toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
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
      ),
    );
  }
}
