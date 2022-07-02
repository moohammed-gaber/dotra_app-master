import 'package:dotra/app/globals/models/image.dart';
import 'package:dotra/app/screens/login/models/root.dart';
import 'package:dotra/app/screens/login/models/user.dart';
import 'package:hive/hive.dart';

class LoginUtilities {
  static Login get loginInfo => Login.fromJson(login);

  static User get userInfo => loginInfo.data;

  static String get userName => userInfo.name;
  static int get userId => userInfo.id;

  static Map get login => Hive.box('login').get('login');
  static bool get isLogin => login != null;

  static String get userEmail => userInfo.email;
  static String get userImage => ImageEntity.imageUrl(userInfo.img);
}
