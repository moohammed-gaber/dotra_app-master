import 'package:dotra/utilities_mso/setting_mso.dart';

class ImageEntity {
  int idImg;
  String img;
  String imgThumbnail;
  dynamic width;
  dynamic height;

  ImageEntity({
    this.idImg,
    this.img,
    this.imgThumbnail,
    this.width,
    this.height,
  });

  static String imageUrl(String imageName) =>
      '${appUrlUploads+imageName}';


  static String get logoUrl => imageUrl('logo.png');
  String get getImage => '${appUrlUploads+img}';

  factory ImageEntity.fromJson(Map json) => ImageEntity(
        idImg: json["id_img"],
        img: json["img"],
        imgThumbnail: json["img_thumbnail"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "id_img": idImg,
        "img": img,
        "img_thumbnail": imgThumbnail,
        "width": width,
        "height": height,
      };
}
