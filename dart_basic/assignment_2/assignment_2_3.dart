import 'assignemnt_data.dart';
import 'cart_util.dart';

void main() {
  const discountRate = 0.1;
  var subtotal = getSubtotal(cart, productPriceMap);
  var discountedPrice = getDiscountedPrice(subtotal, discountRate);
  var finalPrice = shouldApplyDiscount(subtotal, 20000)
      ? applyDiscount(subtotal, discountRate)
      : subtotal;

  print('''
----------------------------------------------
필수 문제 2번 
장바구니에 ${subtotal.round()}원 어치를 담으셨네요!
할인금액: ${discountedPrice.round()}원
최종적으로 결제하실 금액은 ${finalPrice.round()}원입니다!
----------------------------------------------
  ''');
}
