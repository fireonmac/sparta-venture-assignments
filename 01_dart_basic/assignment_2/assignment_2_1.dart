import 'assignemnt_data.dart';
import 'cart_util.dart';

void main() {
  var subtotal = getSubtotal(cart, productPriceMap);
  var finalPrice = shouldApplyDiscount(subtotal, 20000)
      ? applyDiscount(subtotal, 0.1)
      : subtotal;

  print('장바구니에 ${finalPrice.round()}원 어치를 담으셨네요 !');
}
