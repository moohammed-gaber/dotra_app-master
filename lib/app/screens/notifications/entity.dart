import 'dart:convert';

import 'package:dotra/app/globals/methods/utility.dart';
import 'package:dotra/app/globals/models/image.dart';

ApiResponse notificationEntityFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

String notificationEntityToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  ApiResponse({
    this.result,
    this.errorMesage,
    this.errorMesageEn,
    this.data,
  });

  bool result;
  String errorMesage;
  String errorMesageEn;
  Data data;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        result: json["result"],
        errorMesage: json["error_mesage"],
        errorMesageEn: json["error_mesage_en"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "error_mesage": errorMesage,
        "error_mesage_en": errorMesageEn,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<NotificationEntity> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<NotificationEntity>.from(
            json["data"].map((x) => NotificationEntity.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class NotificationEntity {
  NotificationEntity({
    this.id,
    this.type,
    this.withId,
    this.name,
    this.details,
    this.urlLink,
    this.toUsers,
    this.img,
    this.createdAt,
  });

  final int id;
  final int type;
  final int withId;
  final String name;
  final String details;
  final String urlLink;
  final String toUsers;
  final String img;
  final DateTime createdAt;
  bool get isHaveUrlLink => urlLink == null ? false : urlLink.isNotEmpty;

  String get image => ImageEntity.imageUrl(img);

  String get date => UtilityMethods.getFormattedDate(createdAt);
  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      NotificationEntity(
        id: json["id"],
        type: json["type"],
        withId: json["with_id"],
        name: json["name"],
        details: json["details"],
        urlLink: json["url_link"] == null ? null : json["url_link"],
        toUsers: json["to_users"],
        img: json["img"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "with_id": withId,
        "name": name,
        "details": details,
        "url_link": urlLink == null ? null : urlLink,
        "to_users": toUsers,
        "img": img,
        "created_at": createdAt.toIso8601String(),
      };
}
