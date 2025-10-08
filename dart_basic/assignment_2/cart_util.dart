double getSubtotal(List<String> cart, Map<String, num> productPriceMap) {
  return cart.fold(0, (total, product) {
    var productPrice = productPriceMap[product] ?? 0;
    return total + productPrice;
  });
}

bool shouldApplyDiscount(num subtotal, num threshold) {
  return subtotal >= threshold;
}

double getDiscountedPrice(num price, double discountRate) {
  return price * discountRate;
}

double applyDiscount(num price, discountRate) {
  return price - getDiscountedPrice(price, discountRate);
}
