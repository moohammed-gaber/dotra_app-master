import 'dart:convert';

import 'package:dotra/app/globals/error_messages.dart';
import 'package:dotra/app/screens/login/models/root.dart';
import 'package:dotra/app/screens/previous_orders/models/attribute.dart';
import 'package:dotra/app/screens/previous_orders/products.dart';
import 'package:dotra/utilities_mso/setting_mso.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'models/previous_order.dart';

class PreviousOrdersLogic extends ChangeNotifier {
  Future<List<PreviousOrdersEntity>> futureApiRequest;
  List<PreviousOrdersEntity> previousOrders;
  bool isNewOrderAdded = false;

  set setPreviousOrders(List<PreviousOrdersEntity> previousOrders) =>
      this.previousOrders = previousOrders;

  void addToPreviousOrders(PreviousOrdersEntity previousOrder) {
    this.previousOrders.add(previousOrder);
    notifyListeners();
  }

  void refreshIfNewOrderAdded() {
    if (isNewOrderAdded) {
      initializeApiRequest();
      this.isNewOrderAdded = false;
    }
  }

  var refreshController = RefreshController();

  void onRefresh() {
    refresh();

    refreshController.loadComplete();
  }

  PreviousOrdersLogic() {
    initializeApiRequest();
  }

  Future<List<PreviousOrdersEntity>> apiRequest() async {
    final unexpected = ErrorMessages.unexpected;

    try {
      final login = Login.fromJson(Hive.box('login').get('login'));


      print(login.data.id.toString());

      var response = await http.get(
          '${userOrderSaved+"${login.data.id}"}',
          headers: {
            'Authorization': 'Bearer ${login.success.token}',
            'Accept': 'application/json'
          });
      switch (response.statusCode) {
        case 200:
          final previousOrders =
              previousOrdersEntityFromJson(jsonDecode(response.body)['data']);
          return previousOrders;

          break;
        case 401:
          // token is not registered
          throw Exception('هذا المستخدم غير مسجل بشكل صحصيح فى التطبيق');
          break;
        default:
          throw Exception(unexpected);
          break;
      }
    } catch (e,x) {
print(x);
      print(e);
      throw Exception(unexpected);
    }
  }

  void initializeApiRequest() => futureApiRequest = apiRequest();

  void refresh() {
    initializeApiRequest();
    notifyListeners();
  }

  void toAttributes(
    BuildContext context,
    List<AttributeEntity> attributes,
  ) =>
      Navigator.pushNamed(context, PreviousOrderAttributes.route,
          arguments: attributes);
}
