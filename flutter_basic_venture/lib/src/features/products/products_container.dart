import 'package:flutter/widgets.dart';
import 'package:flutter_basic_venture/src/features/products/products_notifier.dart';

class ProductsContainer extends InheritedWidget {
  final ProductsNotifier notifier;

  const ProductsContainer({
    super.key,
    required this.notifier,
    required super.child,
  });

  @override
  bool updateShouldNotify(ProductsContainer oldWidget) {
    return oldWidget.notifier != notifier;
  }

  static ProductsNotifier of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProductsContainer>()!
        .notifier;
  }
}