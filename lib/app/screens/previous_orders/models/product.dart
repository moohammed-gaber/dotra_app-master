import 'package:dotra/app/globals/models/abstract/product.dart';
import 'package:dotra/app/globals/models/image.dart';
import 'package:dotra/app/screens/previous_orders/models/attribute.dart';

class ProductEntity extends BasicProductEntity<AttributeEntity, String> {
  ProductEntity({
    this.productProductId,
    this.quantity,
    this.totalPrice,
    this.discount,
    this.attributes,
    this.userNotes,
    this.productId,
    this.name,
    this.image,
  });

  int productProductId;
  int quantity;
  num totalPrice;
  int discount;
  List<AttributeEntity> attributes;
  String userNotes;
  int productId;
  String name;
  String image;

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
        productProductId: json["product_id"],
        quantity: json["quantity"],
        totalPrice: num.parse(json["total_price"]),
        discount: json["discount"],
        attributes: List<AttributeEntity>.from(
            json["attributes"].map((x) => AttributeEntity.fromJson(x))),
        userNotes: json["user_notes"],
        productId: json["productId"],
        name: json["name"],
        image: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productProductId,
        "quantity": quantity,
        "total_price": totalPrice,
        "discount": discount,
        "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
        "user_notes": userNotes,
        "productId": productId,
        "name": name,
        "img": image,
      };

  @override
  // TODO: implement attributesPrice
  num get attributesPrice => totalPrice;

  @override
  // TODO: implement attributesPriceAfterDiscount
  num get attributesPriceAfterDiscount => totalPrice;

  @override
  // TODO: implement haveDiscount
  bool get haveDiscount => discount > 0;

  @override
  // TODO: implement totalOrderedQuantity
  num get totalOrderedQuantity => quantity;

  @override
  // TODO: implement mainImage
  String get mainImage => isImagesEmpty ? null : ImageEntity.imageUrl(image);

  @override
  // TODO: implement isImagesEmpty
  bool get isImagesEmpty => image == null ? true : image.isEmpty;
}
