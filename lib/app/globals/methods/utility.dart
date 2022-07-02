import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:intl/intl.dart';

class UtilityMethods {
  static String getFormattedDate(DateTime dateTime) {
    var time = DateFormat.Hm();
    var date = DateFormat.yMd();

    return '  ${date.format(dateTime)} - ${time.format(dateTime)}';
  }

  static Future<bool> get hasInternetConnection async =>
      await DataConnectionChecker().hasConnection;

  void apiRequest() async {
    if (await hasInternetConnection) {
    } else
      throw Exception('هناك مشكل');
  }
}
