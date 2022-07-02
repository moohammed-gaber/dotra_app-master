
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.result,
    this.errorMesage,
    this.errorMesageEn,
    this.data,
  });

  bool result;
  String errorMesage;
  String errorMesageEn;
  Data data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
  List<Datum> data;
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
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  Datum({
    this.id,
    this.type,
    this.userLevel,
    this.name,
    this.midName,
    this.lName,
    this.email,
    this.mobile,
    this.img,
    this.department,
    this.country,
    this.city,
    this.region,
    this.address,
    this.gender,
    this.nationalId,
    this.dateBirth,
    this.userBalance,
  });

  int id;
  int type;
  int userLevel;
  String name;
  String midName;
  String lName;
  String email;
  String mobile;
  String img;
  int department;
  int country;
  int city;
  dynamic region;
  String address;
  String gender;
  String nationalId;
  DateTime dateBirth;
  int userBalance;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
    userLevel: json["user_level"],
    name: json["name"],
    midName: json["mid_name"] == null ? null : json["mid_name"],
    lName: json["l_name"],
    email: json["email"],
    mobile: json["mobile"],
    img: json["img"] == null ? null : json["img"],
    department: json["department"],
    country: json["country"] == null ? null : json["country"],
    city: json["city"] == null ? null : json["city"],
    region: json["region"],
    address: json["address"] == null ? null : json["address"],
    gender: json["gender"],
    nationalId: json["national_id"] == null ? null : json["national_id"],
    dateBirth: json["date_birth"] == null ? null : DateTime.parse(json["date_birth"]),
    userBalance: json["user_balance"],
  );

  @override
  String toString() => name;







  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "user_level": userLevel,
    "name": name,
    "mid_name": midName == null ? null : midName,
    "l_name": lName,
    "email": email,
    "mobile": mobile,
    "img": img == null ? null : img,
    "department": department,
    "country": country == null ? null : country,
    "city": city == null ? null : city,
    "region": region,
    "address": address == null ? null : address,
    "gender": gender,
    "national_id": nationalId == null ? null : nationalId,
    "date_birth": dateBirth == null ? null : "${dateBirth.year.toString().padLeft(4, '0')}-${dateBirth.month.toString().padLeft(2, '0')}-${dateBirth.day.toString().padLeft(2, '0')}",
    "user_balance": userBalance,
  };
}



