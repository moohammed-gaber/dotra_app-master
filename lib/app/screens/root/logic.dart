import 'dart:convert';

import 'package:dotra/app/globals/methods/user.dart';
import 'package:dotra/app/globals/widgets/send_cart_button.dart';
import 'package:dotra/app/screens/about/ui.dart';
import 'package:dotra/app/screens/cart/ui/in_bnv.dart';
import 'package:dotra/app/screens/contact_us/ui.dart';
import 'package:dotra/app/screens/employees_requests/employe_request_screen.dart';
import 'package:dotra/app/screens/home/models/product.dart';
import 'package:dotra/app/screens/home/ui.dart';
import 'package:dotra/app/screens/notifications/ui.dart';
import 'package:dotra/app/screens/previous_orders/ui.dart';
import 'package:dotra/app/screens/privacy_policy/ui.dart';
import 'package:dotra/app/screens/profile/ui.dart';
import 'package:dotra/app/screens/use_policy/ui.dart';
import 'package:dotra/main.dart';
import 'package:dotra/utilities_mso/setting_mso.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'models/screen.dart';

class RootLogic extends ChangeNotifier {
  Future<Map> fetchProductsFuture;
  var listController = ScrollController();

  List<Product> products;
  int page = 1;

  int selectedScreenIndex = 2;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<ScreenModel> screens;
  ScreenModel previousOrdersScreen;
  final previousOrdersIndex = 5;
  void removeAddPreviousOrders() {
    screens.removeAt(previousOrdersIndex);
    notifyListeners();
  }

  void addPreviousOrder() {
    screens.insert(previousOrdersIndex, previousOrdersScreen);
    notifyListeners();
  }

  RootLogic() {
    previousOrdersScreen = ScreenModel(
      PreviousOrdersUi(),
      Icons.history,
      'الاوردرات السابقة',
      onTabX,
      x: PreviousOrdersUi.route,
    );
    fetchProductsFuture = fetchProducts(page);

    screens = [
      ScreenModel(ProfileUiRoot(), Icons.perm_identity, 'الصفحة الشخصية',
          onTapBottomNavigation,
          x: 0),
      ScreenModel(NotificationUiRoot(), Icons.notifications, 'الإشعارات',
          onTapBottomNavigation,
          x: 1),
      ScreenModel(HomeUiRoot(), FontAwesomeIcons.shopify, 'المتجر',
          onTapBottomNavigation,
          x: 2),
      ScreenModel(CartUiBnVRoot(), Icons.shopping_basket, 'السلة',
          onTapBottomNavigation,
          x: 3, floatingActionButton: SendCartButton()),
      ScreenModel(
          AboutUiRoot(), Icons.info, 'عن التطبيق', onTapBottomNavigation,
          x: 4),
      if (LoginUtilities.isLogin) previousOrdersScreen,
      ScreenModel(PrivacyPolicyUiRoot(), Icons.assistant_photo,
          'سياسة الخصوصية', onTabX,
          x: PrivacyPolicyUiRoot.route),
      ScreenModel(UsePolicyUiRoot(), Icons.pan_tool, 'سياسة الإستخدام', onTabX,
          x: UsePolicyUiRoot.route),
      ScreenModel(ContactUsUiRoot(), Icons.call, 'اتصل بنا', onTabX,
          x: ContactUsUiRoot.route),

            ScreenModel(EmployeesRequest(), Icons.border_color, 'اضافة طلب', onTabX,
          x: EmployeesRequest.route),


      ];
  }

  void onTapBottomNavigation(params) {
    selectedScreenIndex = params;
    notifyListeners();
  }

  void onTabX(params) {
    navigatorKey.currentState.pushNamed(params);
  }

  Future<Map> fetchProducts(int page) async {
    var response = await http.get('$productsUrl?page=$page');
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return body;
    } else {
      throw Exception();
    }
  }

  ScreenModel get selectedScreen => screens[selectedScreenIndex];

  void refreshProducts() {
    fetchProductsFuture = null;
    fetchProductsFuture = fetchProducts(page);
    notifyListeners();
  }

  Future<bool> loadMore() async {
    page++;
    final data = await fetchProducts(page);
    final newProducts = productsFromJsonList(data['data']['data']);
    products.addAll(newProducts);
    notifyListeners();

    return true;
  }
}
