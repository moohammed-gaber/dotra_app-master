import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'logic.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/drawer/ui.dart';

class RootScreenUi extends StatelessWidget {
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    RootLogic rootLogic = Provider.of(context);
    return Scaffold(
      key: rootLogic.scaffoldKey,
      drawer: DrawerUiRoot(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          rootLogic.selectedScreen.appBarTitle,
        ),
      ),
      // drawer: MyDrawer(),
      body: IndexedStack(
        index: rootLogic.selectedScreenIndex,
        children: rootLogic.screens.map((e) => e.screenBody).toList(),
      ),
      bottomNavigationBar: BottomNavigationBarMso(),
    );
  }
}

/*
  Future<void> x() async {
    await Firebase.initializeApp();
    var auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
        phoneNumber: '+2001090373870',
        verificationCompleted: (x) {},
        verificationFailed: (x) {
          print(x);
        },
        codeSent: (x, y) {},
        codeAutoRetrievalTimeout: (x) {});
  }

 */
