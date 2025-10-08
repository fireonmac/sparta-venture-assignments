import 'assignemnt_data.dart';
import 'cart_util.dart';

void main() {
  var subtotal = getSubtotal(cart, productPriceMap);

  if (shouldApplyDiscount(subtotal, 20000)) {
    var finalPrice = applyDiscount(subtotal, 0.1);
    print('장바구니에 $finalPrice원 어치를 담으셨네요 !');
  }
}
