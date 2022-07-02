abstract class BasicAttribute {
  num price, discount;
  int id, quantity;
  String name;
  bool get haveDiscount => discount > 0;
  num get calculatedPrice;
  int get orderedQuantity;
  num get calculatedPriceAfterDiscount =>
      calculatedPrice - ((discount * calculatedPrice) / 100);

  num get priceAfterDiscountPerOne => price - ((discount * price) / 100);
}
