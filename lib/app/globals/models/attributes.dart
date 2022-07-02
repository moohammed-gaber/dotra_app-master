import 'package:dotra/app/globals/models/abstract/attribute.dart';
import 'package:flutter/material.dart';

class Attribute extends BasicAttribute {
  String name;
  num price, discount;
  int id, availableQuantity;
  TextEditingController textEditingController;

  Attribute(
      {this.id,
      this.name,
      this.price,
      this.availableQuantity,
      this.discount,
      this.textEditingController});
  bool get isTextControllerEmpty => textEditingController.text.isEmpty;
  int get getAvailableQuantity =>
      availableQuantity.isNegative ? 0 : availableQuantity;

  @override
  int get orderedQuantity => int.tryParse(textEditingController.text) ?? 0;

  @override
  num get calculatedPrice => orderedQuantity * price;

  factory Attribute.fromJson(Map<dynamic, dynamic> json) {
    Attribute attribute = Attribute(
        id: json['id_attribute'],
        name: json["attribute_name"],
        price: json["price"],
        availableQuantity: json['quantity'],
        discount: json['discount'],
        textEditingController: TextEditingController(
            text: json['orderedQuantity'] == null
                ? null
                : json['orderedQuantity'].toString()));

    return attribute;
  }

  Map<String, dynamic> toJson() => {
        'id_attribute': id,
        "attribute_name": name,
        "price": price,
        "quantity": availableQuantity,
        'discount': discount,
        'orderedQuantity': orderedQuantity,
        "calculatedPrice": calculatedPrice,
        "calculatedPriceAfterDiscount": calculatedPriceAfterDiscount,
      };
}
