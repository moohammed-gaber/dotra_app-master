import 'package:dotra/app/screens/root/widgets/drawer/logic.dart';
import 'package:dotra/app/screens/root/widgets/drawer/widgets/tiles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DrawerLogout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DrawerLogic logic = Provider.of(context);

    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(),
        ...tiles(context),
        ListTile(
          leading: Icon(FontAwesomeIcons.doorOpen),
          onTap: () => logic.toLoginPage(context),
          title: Text('تسجيل الدخول'),
        )
      ],
    );
  }
}
