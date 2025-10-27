import 'package:flutter/widgets.dart';
import 'package:flutter_basic_venture/src/features/cart/cart_notifier.dart';

class CartContainer extends InheritedWidget {
  final CartNotifier notifier;

  const CartContainer({
    super.key,
    required this.notifier,
    required super.child,
  });

  @override
  bool updateShouldNotify(CartContainer oldWidget) {
    return oldWidget.notifier != notifier;
  }

  static CartNotifier of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CartContainer>()!
        .notifier;
  }
}