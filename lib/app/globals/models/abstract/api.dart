import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class Api {
  var refreshController = RefreshController();

  void onRefresh() {
    refresh();
    refreshController.loadComplete();
  }

  void initializeApiRequest();
  void refresh() {
    initializeApiRequest();
  }
}
