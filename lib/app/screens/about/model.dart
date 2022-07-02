class Data {
  int id;
  String name;
  String nameEn;
  dynamic img;
  String details;
  String detailsEn;

  Data({
    this.id,
    this.name,
    this.nameEn,
    this.img,
    this.details,
    this.detailsEn,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        nameEn: json["name_en"],
        img: json["img"],
        details: json["details"],
        detailsEn: json["details_en"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_en": nameEn,
        "img": img,
        "details": details,
        "details_en": detailsEn,
      };
}
