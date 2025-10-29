import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/constants.dart';
import 'package:flutter_basic_venture/src/features/cart/widgets/cart_button.dart';
import 'package:flutter_basic_venture/src/styles.dart';
import 'package:flutter_basic_venture/src/features/products/products_container.dart';
import 'package:flutter_basic_venture/src/view/products/product_create_screen.dart';
import 'package:flutter_basic_venture/src/features/products/widgets/products_list_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsNotifier = ProductsContainer.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(appTitle, style: Styles.title),
        actions: [CartButton()],
        centerTitle: false,
      ),
      body: ListenableBuilder(
        listenable: productsNotifier,
        builder: (context, child) {
          final products = productsNotifier.products;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return ProductsListItem(product: product);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Styles.primaryColor,
        onPressed: () {
          Navigator.push(context, ProductCreateScreen.buildRoute(context));
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 24),
      ),
    );
  }
}
