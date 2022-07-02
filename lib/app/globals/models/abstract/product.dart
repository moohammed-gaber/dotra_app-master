import 'attribute.dart';

abstract class BasicProductEntity<E extends BasicAttribute, I> {
  // int id;
  String name;
  // List<E> attributes;
  // I images;

  String get mainImage;

  bool get haveDiscount;

  num get attributesPrice;

  num get attributesPriceAfterDiscount;

  num get totalOrderedQuantity;
  bool get isImagesEmpty;
}
