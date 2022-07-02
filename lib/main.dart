import 'package:dio/dio.dart';
import 'package:dotra/app/screens/cart/drob_dowen_services.dart';
import 'package:dotra/app/screens/contact_us/ui.dart';
import 'package:dotra/app/screens/privacy_policy/ui.dart';
import 'package:dotra/app/screens/root/widgets/drawer/logic.dart';
import 'package:dotra/app/screens/use_policy/ui.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' hide Table;
import 'package:flutter_screenutil/screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/screens/cart/ui/out_bnv.dart';
import 'app/screens/cart/ui/widgets/note_dialog.dart';
import 'app/screens/employees_requests/employe_request_screen.dart';
import 'app/screens/home/logic.dart';
import 'app/screens/login/ui.dart';
import 'app/screens/previous_orders/logic.dart';
import 'app/screens/previous_orders/products.dart';
import 'app/screens/previous_orders/ui.dart';
import 'app/screens/product_details/ui.dart';
import 'app/screens/root/logic.dart';
import 'app/screens/root/ui.dart';
import 'utilities_mso/setting_mso.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {}
  if (message.containsKey('notification')) {}
}

BuildContext globalContext;
SharedPreferences sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
    },
    onBackgroundMessage: myBackgroundMessageHandler,
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    },
  );

  var dir = await getExternalStorageDirectory();
  await Hive.openBox(
    'cart',
    path: dir.path,
  );

  await Hive.openBox(
    'utility',
    path: dir.path,
  );

  await Hive.openBox('login', path: dir.path);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState

//    DropDownSearchSellerServices.feachData();
    HomeLogic.feach_cat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PreviousOrdersLogic()),
        ChangeNotifierProvider(create: (_) => RootLogic()),
        ChangeNotifierProvider(create: (_) => DrawerLogic()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, Widget widget) {
          globalContext = context;

          ScreenUtil.init(context, designSize: Size(360, 756));
          return Directionality(
              textDirection: TextDirection.rtl, child: SafeArea(child: widget));
        },
        title: appNameMso,
        theme: ThemeData(
          fontFamily: "cairo",
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: Colors.green,
            accentColor: Colors.green,
            primaryColorDark: Colors.grey.withOpacity(0.2),
            textTheme: TextTheme(
                button: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.accent,
            )),
        routes: {
          PreviousOrderAttributes.route: (_) => PreviousOrderAttributes(),
          PreviousOrdersUi.route: (_) => PreviousOrdersUi(),
          RootScreenUi.route: (context) => RootScreenUi(),
          ProductDetailsUiRoot.route: (_) => ProductDetailsUiRoot(),
          CartUiOutBnvRoot.route: (_) => CartUiOutBnvRoot(),
          LoginUiRoot.route: (_) => LoginUiRoot(),
          PrivacyPolicyUiRoot.route: (_) => PrivacyPolicyUiRoot(),
          ContactUsUiRoot.route: (_) => ContactUsUiRoot(),
          UsePolicyUiRoot.route: (_) => UsePolicyUiRoot(),
          EmployeesRequest.route: (_) => EmployeesRequest(),
        },
      ),
    );
  }
}
