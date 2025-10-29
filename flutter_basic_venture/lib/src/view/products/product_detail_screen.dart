import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/features/cart/widgets/cart_button.dart';
import 'package:flutter_basic_venture/src/styles.dart';
import 'package:flutter_basic_venture/src/features/products/products_container.dart';
import 'package:flutter_basic_venture/src/features/cart/cart_container.dart';
import 'package:flutter_basic_venture/src/widgets/call_to_action_button.dart';
import 'package:flutter_basic_venture/src/utils/navigation.dart';
import 'package:flutter_basic_venture/src/widgets/quantity_control.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  static Route<dynamic> buildRoute(BuildContext context, String productId) {
    return buildScreenRoute(
      context,
      screen: ProductDetailScreen(productId: productId),
    );
  }

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final productsNotifier = ProductsContainer.of(context);
    final cartNotifier = CartContainer.of(context);
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final product = productsNotifier.getProductById(widget.productId);

    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('상품을 찾을 수 없습니다')),
        body: Center(
          child: Text(
            '존재하지 않는 상품입니다.',
            style: TextStyle(color: colorScheme.onSurface),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(actions: [CartButton()]),
      body: Padding(
        padding: Styles.bodyPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상품 이미지
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: Styles.cardBorderRadius,
                ),
                child: Icon(
                  Icons.image,
                  size: 100,
                  color: colorScheme.onPrimaryContainer.withOpacity(0.5),
                ),
              ),

              const SizedBox(height: 24),

              // 상품명
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 8),

              // 카테고리
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  product.category,
                  style: TextStyle(
                    color: colorScheme.onPrimaryContainer,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 가격
              Row(
                children: [
                  Icon(Icons.diamond, color: Styles.primaryColor, size: 28),
                  const SizedBox(width: 4.0),
                  Text(
                    '${product.price.toStringAsFixed(0)}개',
                    style: TextStyle(
                      color: Styles.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 상품 설명
              Text(
                '상품 설명',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.description,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),

              // 하단 여백
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 수량 선택
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '수량',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  QuantityControl(
                    quantity: _quantity,
                    onIncrement: () => setState(() => _quantity++),
                    onDecrement: () => setState(() => _quantity--),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // 총 가격
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '총 가격',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),

                  Row(
                    children: [
                      Icon(Icons.diamond, color: Styles.primaryColor, size: 20),
                      const SizedBox(width: 4.0),
                      Text(
                        '${product.price.toStringAsFixed(0)}개',
                        style: TextStyle(
                          color: Styles.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // 장바구니 추가 버튼
              CallToActionButton(
                text: '장바구니에 추가',
                icon: const Icon(Icons.shopping_cart, size: 20),
                onPressed: () {
                  cartNotifier.add(product, quantity: _quantity);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${product.name} $_quantity개가 장바구니에 추가되었습니다.',
                        style: TextStyle(color: colorScheme.onInverseSurface),
                      ),
                      backgroundColor: colorScheme.inverseSurface,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
