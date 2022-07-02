import 'dart:io';

import 'package:dotra/app/screens/profile/logic.dart';
import 'package:dotra/app/screens/root/widgets/drawer/logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

/*


 */
class ProfileUiRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        child: ProfilePage(), create: (_) => ProfileLogic());
  }
}

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container();
//    return MyProfile();
  }
}



//class MyProfile extends StatelessWidget {
//  static String id = 'aboutUs';
//  String civilId, EMAIL, STATUSdESC, phoneNumber,birthDay, userId;
//  MyProfile({this.civilId, this.EMAIL, this.STATUSdESC, this.phoneNumber,this.birthDay, this.userId});
//
//
//  @override
//  Widget build(BuildContext context) {
//    //String birthDate = birthDay != null ? birthDay : birthDay.substring(0, 10)  ;
//
//    DrawerLogic logic = Provider.of(context);
//    var userInfo = logic.userInfo.data;
//
//
//    return Scaffold(
//        body: SingleChildScrollView(
//          child: Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 20),
//            child: Column(
//              children: <Widget>[
//                list_tile(
//                  title: 'الحساب',
//                  description: userInfo.email,
//                  icon: Icons.person_outline,
//                ),
//                list_tile(
//                  title: 'الاسم',
//                  description:userInfo.name,
//                  icon: Icons.contact_mail,
//                ),
//
//                list_tile(
//                  title: 'تاريخ الميلاد',
//                  description: DateFormat('yyyy-MM-dd').format(userInfo.dateBirth).toString(),
//                  icon: Icons.cake,
//                ),
//
//              ],
//            ),
//          ),
//        ));
//  }
//}
//
//
//class list_tile extends StatelessWidget {
//  IconData icon;
//  String title;
//  String description;
//
//  list_tile({this.icon, this.title, this.description});
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        ListTile(
//          leading: Icon(
//            icon,
//            color:Colors.green,
//          ),
//          title: Text(title),
//          subtitle: Text(description),
//        ),
//        Divider(
//          color: Colors.green,
//          height: 2,
//          indent: 10,
//          endIndent: 30,
//        ),
//      ],
//    );
//  }
//}
//
//
//
//


