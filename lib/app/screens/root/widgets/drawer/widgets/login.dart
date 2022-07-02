import 'package:dotra/app/globals/models/image.dart';
import 'package:dotra/app/screens/root/widgets/drawer/widgets/tiles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../logic.dart';

class DrawerLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DrawerLogic logic = Provider.of(context);

    var userInfo = logic.userInfo.data;

    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage:
                NetworkImage(ImageEntity.imageUrl(logic.userInfo.data.img)),
          ),
          accountName: Text(userInfo.name),
          accountEmail: Text(userInfo.email),
        ),
        ...tiles(context),
        ListTile(
          leading: Icon(FontAwesomeIcons.doorClosed),
          onTap: () => logic.logout(context),
          title: Text('تسجيل الخروج'),
        )
      ],
    );
  }
}
