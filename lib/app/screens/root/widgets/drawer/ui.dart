import 'package:dotra/app/screens/root/widgets/drawer/logic.dart';
import 'package:dotra/utilities_mso/setting_mso.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/log_out.dart';
import 'widgets/login.dart';

class DrawerUiRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerUi();
  }
}

class DrawerUi extends StatelessWidget {
  final processingData = ProcessingData();
  @override
  Widget build(BuildContext context) {
    DrawerLogic logic = Provider.of(context);
    return Drawer(child: logic.userIsLogin ? DrawerLogin() : DrawerLogout());
  }
}
