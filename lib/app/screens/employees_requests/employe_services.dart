import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotra/app/globals/widgets/pop_up.dart';
import 'package:dotra/app/screens/employees_requests/employe_model.dart';
import 'package:dotra/app/screens/login/models/root.dart';
import 'package:dotra/app/screens/login/ui.dart';
import 'package:dotra/utilities_mso/setting_mso.dart';
import 'package:dotra/utilities_mso/widget_utill.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';

class EmployeesRequestServices {
  static Future<EmployeesRequiredModel> fetchRequestsTypes(context) async {
    Response response = await dio.get(requestsTypes);

    try {
      if (response.statusCode == 200) {
        return EmployeesRequiredModel.fromJson(response.data);
      } else {
        ShowDialog.showDialogFun(
            context, "Error", response.statusCode.toString());
      }
    } catch (e) {
      ShowDialog.showDialogFun(context, "Error", e);
    }
  }




 static Future<void> ChecktosendRequest(BuildContext context,Map<String, dynamic> value) async {
    var loginBox = Hive.box('login');
    if (loginBox.get('login') == null) {
      await Navigator.pushNamed(context, LoginUiRoot.route);
      if (loginBox.get('login') != null) {
        sendRequest( context,value);      }
      return;
    }
    sendRequest( context,value);
  }





  static Future<FormData> sendRequest(context,Map<String, dynamic> value) async {
    var progressDialog = PopUpWidgets.progressDialog(context);


    FormData formData = FormData.fromMap({
      "request_type": "1",
      "field_id[1]": "${value["reson"]}",
      "field_id[2]": await MultipartFile.fromFile( value["image"][0].path, filename: value["image"][0].path.split('/').last),
      "field_id[3]": "${value["dayes"].toString()}",
      "field_id[4]": value["dateTime"].toString(),
    });

    Map<String, dynamic> header = {
      "Accept": "application/json",
      "Content-Type": "multipart/form-data",
      'Authorization':
          'Bearer ${Login.fromJson(Hive.box('login').get('login')).success.token}'
    };
    progressDialog.show();
    final url = postRequestsTypes(
      request_type: "1",
      fields1: "${value["reson"]}",
      fields2: await  MultipartFile.fromFile( value["image"][0].path, filename: value["image"][0].path.split('/').last),
      fields3: "${value["dayes"].toString()}",
      fields4:  value["dateTime"].toString(),
    );
    Response response = await dio
        .post(url, data: formData, options: Options(headers: header))
        .catchError((e) => print(e.response.data));
    progressDialog.hide();




    try {
      if (response.statusCode == 200) {
        PopUpWidgets.showSnackBar(context, 'تمت العملية بنجاح',
            color: Colors.orange);
        Future.delayed(Duration(seconds: 2),(){
          Navigator.pop(context);
        });

      } else {
//      print(response.statusCode);
        print(response.statusCode);
        PopUpWidgets.showSnackBar(context, 'هناك خطأ ما', color: Colors.red);

      }
    } catch (e) {
//  print(response.statusCode);
//  print(e);
      PopUpWidgets.showSnackBar(context, 'هناك خطأ ما', color: Colors.red);

      progressDialog.hide();


    }
  }
}
