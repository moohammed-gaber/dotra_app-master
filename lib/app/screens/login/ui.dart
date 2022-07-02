import 'package:dotra/app/screens/login/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';

class LoginUiRoot extends StatelessWidget {
  static const route = '/login';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: LoginUi(),
      create: (BuildContext context) => LoginLogic(),
    );
  }
}

class LoginUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginLogic logic = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('تسجيل الدخول'),
          centerTitle: true,
        ),
        body: FlutterLogin(
          theme: LoginTheme(
              buttonTheme: LoginButtonTheme(
                backgroundColor: Colors.green,
              ),
              cardTheme: CardTheme(),
              primaryColor: Colors.green,
              // pageColorLight: Colors.green,
              // pageColorDark: Colors.orange,
              accentColor: Colors.white),
          onSubmitAnimationCompleted: () => logic.onSubmit(context),
          showDebugButtons: false,
          emailValidator: logic.emailValidator,
          passwordValidator: logic.passwordValidator,
          title: 'تطبيق دوترا',
          logo: 'assets/images/logo.png',
          onLogin: (LoginData loginData) => logic.login(context, loginData),
          messages: LoginMessages(
            usernameHint: 'الايميل',
            passwordHint: 'كلمه السر',
            confirmPasswordHint: 'تأكيد',
            loginButton: 'دخول',
            signupButton: '',
            recoverPasswordButton: 'ارسال',
            goBackButton: 'رجوع',
            confirmPasswordError: 'غير متطابق!',
            recoverPasswordDescription: 'من فضلك ادخل الايميل الذي قمت بالتسجيل به من قبل',
            recoverPasswordSuccess: 'تم انقاذ كلمة المرور بنجاح',
          ),
        ));
  }
}
