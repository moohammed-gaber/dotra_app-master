import 'dart:convert';

import 'package:dotra/app/screens/root/logic.dart';
import 'package:dotra/app/screens/root/widgets/drawer/logic.dart';
import 'package:dotra/utilities_mso/setting_mso.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginLogic extends ChangeNotifier {
  var emailTextFieldController = TextEditingController();
  var passwordTextFieldController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  static Future<http.Response> postRequest(LoginData loginData) async =>
      await http.post(loginUrl, body: { 
        "email": loginData.name,
        "password": loginData.password,
      });
  Future<String> login(BuildContext context, LoginData loginData) async {
    try {
      http.Response response = await postRequest(loginData);
      Map<String, dynamic> decodedResponseBody = jsonDecode(response.body);

      bool isLoginSuccess = decodedResponseBody['result'];
      if (isLoginSuccess) {
        Hive.box('login').put('login', decodedResponseBody);
        Provider.of<RootLogic>(context, listen: false).addPreviousOrder();
        return null;
      } else {
        return 'البيانات المدخله بها خطأ راجعها وحاول مرة اخري';
      }
    } catch (e) {
      return ('خطأ فى خوادمنا نحن نسعي لحله');
    }
  }

  String emailValidator(String email) =>
      EmailValidator.validate(email) ? null : 'البريد الإلكتروني غير صحيح';

  String passwordValidator(String value) =>
      value.length >= 8 ? null : 'الرقم السري يجب ان يكون 8 حروف على الأقل';

  onSubmit(BuildContext context) {
    Provider.of<DrawerLogic>(context, listen: false).notifyListeners();
    Navigator.pop(context);
  }
}
