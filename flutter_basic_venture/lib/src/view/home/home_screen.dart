import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/constants.dart';
import 'package:flutter_basic_venture/src/features/cart/widgets/cart_button.dart';
import 'package:flutter_basic_venture/src/styles.dart';
import 'package:flutter_basic_venture/src/features/products/products_container.dart';
import 'package:flutter_basic_venture/src/features/cart/cart_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsNotifier = ProductsContainer.of(context);
    final cartNotifier = CartContainer.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(appTitle, style: Styles.title),
        actions: [CartButton()],
      ),
      body: Padding(
        padding: Styles.bodyPadding,
        child: ListenableBuilder(
          listenable: productsNotifier,
          builder: (context, child) {
            final products = productsNotifier.products;

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: const RoundedRectangleBorder(
                    borderRadius: Styles.cardBorderRadius,
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/products',
                        arguments: {'productId': product.id},
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: Styles.primaryColor.shade100,
                      child: Text(
                        product.name.substring(0, 1),
                        style: TextStyle(
                          color: Styles.primaryColor.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(product.name, style: Styles.bold),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.description),
                        const SizedBox(height: 4),
                        Text(
                          '₩${product.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Styles.primaryColor,
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 24),
      ),
    );
  }
}