import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/features/products/product_model.dart';
import 'package:flutter_basic_venture/src/styles.dart';
import 'package:flutter_basic_venture/src/view/products/product_detail_screen.dart';

class ProductsListItem extends StatelessWidget {
  final Product product;

  const ProductsListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final Color cardColor = product.isSoldOut
        ? Colors.grey.shade200
        : Theme.of(context).colorScheme.surface;
    final Color textColor = product.isSoldOut
        ? Colors.grey.shade600
        : Colors.black;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            ProductDetailScreen.buildRoute(context, product.id),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: Styles.cardBorderRadius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: product.isSoldOut
                            ? Colors.grey.shade300
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text(
                          product.name.substring(0, 1),
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: product.isSoldOut
                                ? Colors.grey.shade500
                                : Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            product.name,
                            style: Styles.bold.copyWith(color: textColor),
                          ),
                          if (!product.isSoldOut) ...[
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                Icon(
                                  Icons.diamond,
                                  color: Styles.primaryColor,
                                  size: 16,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  '${product.price.toStringAsFixed(0)}개',
                                  style: TextStyle(
                                    color: Styles.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (product.isSoldOut)
                Positioned(
                  top: 25,
                  right: 25,
                  child: Transform.rotate(
                    angle: -0.2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: Styles.errorColor.shade500,
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                          color: Styles.errorColor.shade700,
                          width: 1.5,
                        ),
                      ),
                      child: const Text(
                        '품절',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
