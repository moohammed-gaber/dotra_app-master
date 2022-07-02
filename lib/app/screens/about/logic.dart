import 'dart:convert';

import 'package:dotra/utilities_mso/setting_mso.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class AboutLogic extends ChangeNotifier {
  Future<Data> fetchAboutsDataFuture;
  Future<Data> fetchAboutsData() async {
    http.Response response = await http.get(aboutUrl + '1');
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return Data.fromJson(responseBody['data']);
    } else {
      throw Exception();
    }
  }

  AboutLogic() {
    fetchAboutsDataFuture = fetchAboutsData();
  }
}
