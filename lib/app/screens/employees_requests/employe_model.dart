// To parse this JSON data, do
//
//     final employeesRequiredModel = employeesRequiredModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

EmployeesRequiredModel employeesRequiredModelFromJson(String str) => EmployeesRequiredModel.fromJson(json.decode(str));

String employeesRequiredModelToJson(EmployeesRequiredModel data) => json.encode(data.toJson());

class EmployeesRequiredModel {
  EmployeesRequiredModel({
    this.result,
    this.errorMesage,
    this.errorMesageEn,
    this.data,
  });

  bool result;
  String errorMesage;
  String errorMesageEn;
  Data data;

  factory EmployeesRequiredModel.fromJson(Map<String, dynamic> json) => EmployeesRequiredModel(
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
    this.name,
    this.img,
    this.details,
    this.fields,
  });
  int id;
  String name;
  String img;
  String details;
  List<Field> fields;





  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    img: json["img"],
    details: json["details"],
    fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "img": img,
    "details": details,
    "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
  };
}

class Field {
  Field({
    this.id,
    this.name,
    this.fieldType,
    this.isRequired,
  });

  int id;
  String name;
  String fieldType;
  String isRequired;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    id: json["id"],
    name: json["name"],
    fieldType: json["field_type"],
    isRequired: json["is_required"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "field_type": fieldType,
    "is_required": isRequired,
  };

x(){

  if(fieldType=="textarea"){
    return Text("textarea");
  }else if( fieldType =="file"){
    return Text("file");
  }else if( fieldType =="number"){
    return Text("number");
  }else if( fieldType =="date"){
    return Text("date");
  }
}

}


