import 'dart:convert';

import 'package:dotra/app/globals/models/abstract/product.dart';
import 'package:dotra/app/globals/models/attributes.dart';

import '../../../globals/models/image.dart';

List<Product> productsFromJsonList(List data) =>
    List<Product>.from(data.map((x) => Product.fromJson(x)));

String productModelToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product extends BasicProductEntity<Attribute, List<ImageEntity>> {
  int id;
  int catId;
  String name;
  String tags;
  int countryId;
  int companyId;
  String description;
  String price;
  int discount;
  int quantity;
  int priceWithDiscount;
  String catName;
  String catNameEn;
  List<ImageEntity> images;
  List<Attribute> attributes;

  Product(
      {this.id,
      this.catId,
      this.name,
      this.tags,
      this.countryId,
      this.companyId,
      this.description,
      this.price,
      this.discount,
      this.quantity,
      this.priceWithDiscount,
      this.catName,
      this.catNameEn,
      this.images,
      this.attributes});

  @override
  bool get haveDiscount => attributes.any((element) => element.haveDiscount);

  bool get isAvailable =>
      attributes.any((element) => element.availableQuantity > 0) ? true : false;

  @override
  num get attributesPrice => attributes
      .map((e) => e.calculatedPrice)
      .reduce((value, element) => value + element);

  @override
  num get attributesPriceAfterDiscount => attributes
      .map((e) => e.calculatedPriceAfterDiscount)
      .reduce((value, element) => value + element);

  @override
  num get totalOrderedQuantity => attributes
      .map((e) => e.orderedQuantity)
      .reduce((value, element) => value + element);

  bool get isImagesEmpty => images.isEmpty;

  bool get isSingleImage => images.length == 1;

  @override
  String get mainImage => isImagesEmpty ? null : images[0].getImage;

  String get getDescription {
    return description ?? 'لا يوجد وصف';
  }

  factory Product.fromJson(json) {
    return Product(
      id: json["id"],
      catId: json["cat_id"],
      name: json["name"],
      tags: json["tags"],
      countryId: json["country_id"],
      companyId: json["company_id"],
      description: json["description"],
      price: json["price"],
      discount: json["discount"],
      quantity: json["quantity"],
      priceWithDiscount: json["price_with_discount"],
      catName: json["cat_name"],
      catNameEn: json["cat_name_en"],
      attributes: List<Attribute>.from(
          json["attributes"].map((x) => Attribute.fromJson(x))),
      images: json["imgs"] == null
          ? []
          : List<ImageEntity>.from(
              json["imgs"].map((x) => ImageEntity.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "name": name,
        "tags": tags,
        "country_id": countryId,
        "company_id": companyId,
        "description": description,
        "price": price,
        "discount": discount,
        "quantity": quantity,
        "price_with_discount": priceWithDiscount,
        "cat_name": catName,
        "cat_name_en": catNameEn,
        "imgs": List<dynamic>.from(images.map((x) => x.toJson())),
        "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
      };
}
