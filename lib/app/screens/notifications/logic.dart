import 'package:dotra/app/globals/models/abstract/api.dart';
import 'package:dotra/app/globals/widgets/pop_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utilities_mso/setting_mso.dart';
import 'entity.dart';

abstract class H {
  void x();
}

class NotificationLogic extends ChangeNotifier with Api {
  Future<ApiResponse> futureApiRequest;
  List<NotificationEntity> notifications;
  var refreshController = RefreshController();
  final controller = ScrollController();
  var page = 1;

  NotificationLogic() {
    initializeApiRequest();
  }

  Future<void> openLink(BuildContext context, String url) async {
    try {
      await launch(url);
    } catch (e) {
      PopUpWidgets.showSnackBar(context, 'هناك خطأ فى هذا الرابط',
          color: Colors.red);
    }
  }

  Future<ApiResponse> apiRequest(int page) async {
    try {
      var response = await http
          .get(notification);
      var notifications = notificationEntityFromJson(response.body);
      return notifications;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> loadMore() async {
    page++;
    final response = await apiRequest(page);
    notifications.addAll(response.data.data);
    notifyListeners();
    return true;
  }

  @override
  void refresh() {
    super.refresh();
    notifyListeners();
  }

  @override
  void initializeApiRequest() {
    futureApiRequest = apiRequest(page);
  }
}
