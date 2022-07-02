import 'package:dotra/app/globals/models/abstract/attribute.dart';

class AttributeEntity extends BasicAttribute {
  AttributeEntity({
    this.attributeId,
    this.quantity,
    this.price,
    this.discount,
    this.price4All,
  });

  int attributeId;
  int quantity;
  num price;
  num discount;
  num price4All;

  factory AttributeEntity.fromJson(Map<String, dynamic> json) =>
      AttributeEntity(
        attributeId: json["attribute_id"],
        quantity: json["quantity"],
        price: json["price4one"],
        discount: json["discount"],
        price4All: json["price4all"],
      );

  Map<String, dynamic> toJson() => {
        "attribute_id": attributeId,
        "quantity": quantity,
        "price4one": price,
        "discount": discount,
        "price4all": price4All,
      };

  @override
  // TODO: implement calculatedPrice
  num get calculatedPrice => price4All;

  @override
  // TODO: implement orderedQuantity
  int get orderedQuantity => quantity;
}
