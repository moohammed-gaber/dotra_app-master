import 'package:dotra/app/screens/login/models/root.dart';
import 'package:dotra/app/screens/login/ui.dart';
import 'package:dotra/app/screens/root/logic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class DrawerLogic extends ChangeNotifier {
  Login get userInfo => Login.fromJson(Hive.box('login').get('login'));

  bool get userIsLogin => Hive.box('login').get('login') != null;

  Future<void> toLoginPage(BuildContext context) async =>
      Navigator.pushNamed(context, LoginUiRoot.route);

  Future<void> logout(BuildContext context) async {
    await Hive.box('login').put('login', null);
    Provider.of<RootLogic>(context, listen: false).removeAddPreviousOrders();
    notifyListeners();
  }
}
