import 'package:dotra/app/globals/methods/utility.dart';
import 'package:dotra/app/screens/previous_orders/models/product.dart';

List<PreviousOrdersEntity> previousOrdersEntityFromJson(List list) =>
    List<PreviousOrdersEntity>.from(
        list.map((x) => PreviousOrdersEntity.fromJson(x)));

class PreviousOrdersEntity {
  PreviousOrdersEntity({
    this.id,
    this.orderNum,
    this.paymentType,
    this.paymentOrderId,
    this.movingOrderId,
    this.movingPdf,
    this.orderTotalPrice,
    this.priceMove,
    this.status,
    this.deliverDate,
    this.reasonIfCancel,
    this.userAdded,
    this.deliverTime,
    this.userNotes,
    this.createdAt,
    this.products,
  });

  int id;
  String orderNum;
  int paymentType;
  dynamic paymentOrderId;
  dynamic movingOrderId;
  dynamic movingPdf;
  String orderTotalPrice;
  String priceMove;
  int status;
  dynamic deliverDate;
  dynamic reasonIfCancel;
  int userAdded;
  dynamic deliverTime;
  String userNotes;
  DateTime createdAt;
  List<ProductEntity> products;
  String get date => UtilityMethods.getFormattedDate(createdAt);

  bool get isHaveNote => userNotes.isNotEmpty;
  factory PreviousOrdersEntity.fromJson(Map<String, dynamic> json) =>
      PreviousOrdersEntity(
        id: json["id"],
        orderNum: json["order_num"],
        paymentType: json["payment_type"],
        paymentOrderId: json["payment_order_id"],
        movingOrderId: json["moving_order_id"],
        movingPdf: json["moving_pdf"],
        orderTotalPrice: json["order_total_price"],
        priceMove: json["price_move"],
        status: json["status"],
        deliverDate: json["deliver_date"],
        reasonIfCancel: json["reason_if_cancel"],
        userAdded: json["user_added"],
        deliverTime: json["deliver_time"],
        userNotes: json["user_notes"] == null ? "لايوجد ملاحظات" : json["user_notes"],
        createdAt: DateTime.parse(json["created_at"]),
        products: List<ProductEntity>.from(
            json["products"].map((x) => ProductEntity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_num": orderNum,
        "payment_type": paymentType,
        "payment_order_id": paymentOrderId,
        "moving_order_id": movingOrderId,
        "moving_pdf": movingPdf,
        "order_total_price": orderTotalPrice,
        "price_move": priceMove,
        "status": status,
        "deliver_date": deliverDate,
        "reason_if_cancel": reasonIfCancel,
        "user_added": userAdded,
        "deliver_time": deliverTime,
        "user_notes": userNotes == null ? null : userNotes,
        "created_at": createdAt.toIso8601String(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
