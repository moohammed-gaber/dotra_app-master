import 'package:dio/dio.dart';
import 'package:dotra/app/screens/cart/drodoen_model.dart';
import 'package:dotra/utilities_mso/setting_mso.dart';
import 'package:flutter/material.dart';

class DropDownSearchSellerServices {
  static Future<List<Datum>> feachData() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var response = await dio.get("http://hrm.pure-soft.com/api/users/t/1",
        options: Options(headers: headers));
    if (response.statusCode == 200) {
      final myData = UserModel.fromJson(response.data);
      print(myData.data.data.map((e) => e).toList());
      return myData.data.data.map((e) => e).toList();
    } else {
      throw Exception('Failed to load internet');
    }
  }
}
