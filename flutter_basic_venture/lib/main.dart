import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/constants.dart';
import 'package:flutter_basic_venture/src/styles.dart';
import 'package:flutter_basic_venture/src/features/products/products_container.dart';
import 'package:flutter_basic_venture/src/features/products/products_notifier.dart';
import 'package:flutter_basic_venture/src/features/cart/cart_container.dart';
import 'package:flutter_basic_venture/src/features/cart/cart_notifier.dart';
import 'package:flutter_basic_venture/src/view/home/home_screen.dart';
import 'package:flutter_basic_venture/src/view/cart/cart_screen.dart';
import 'package:flutter_basic_venture/src/view/products/product_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ProductsNotifier _productsNotifier = ProductsNotifier();
  late final CartNotifier _cartNotifier = CartNotifier(_productsNotifier);

  ThemeData _createTheme(Brightness brightness) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Styles.primaryColor,
        brightness: brightness,
        primary: Styles.primaryColor,
        secondary: Styles.secondaryColor,
        error: Styles.errorColor,
      ),
      primarySwatch: Styles.primaryColor,
      useMaterial3: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProductsContainer(
      notifier: _productsNotifier,
      child: CartContainer(
        notifier: _cartNotifier,
        child: MaterialApp(
          title: appTitle,
          theme: _createTheme(Brightness.light),
          darkTheme: _createTheme(Brightness.dark),
          themeMode: ThemeMode.system,
          home: const HomeScreen(),
          routes: {
            '/cart': (context) => const CartScreen(),
            '/products': (context) {
              final args =
                  ModalRoute.of(context)!.settings.arguments
                      as Map<String, dynamic>;
              return ProductDetailScreen(productId: args['productId']);
            },
          },
        ),
      ),
    );
  }
}
