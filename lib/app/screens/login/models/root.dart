import 'user.dart';

class Login {
  Login({
    this.result,
    this.errorMesage,
    this.errorMesageEn,
    this.success,
    this.data,
  });

  bool result;
  String errorMesage;
  String errorMesageEn;
  Success success;
  User data;

  factory Login.fromJson(Map<dynamic, dynamic> json) => Login(
        result: json["result"],
        errorMesage: json["error_mesage"],
        errorMesageEn: json["error_mesage_en"],
        success: Success.fromJson(json["success"]),
        data: User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "error_mesage": errorMesage,
        "error_mesage_en": errorMesageEn,
        "success": success.toJson(),
        "data": data.toJson(),
      };
}

class Success {
  Success({
    this.token,
  });

  String token;

  factory Success.fromJson(Map<dynamic, dynamic> json) => Success(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
