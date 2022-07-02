import 'package:flutter/material.dart';

class NavigationRout{

  static  navigatorTo(context,page){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page,));
  }
  static  navigatorOf(context,page){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => page,));
  }
  static  navigatorOfAll(context,page){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => page
        ),
        ModalRoute.withName("")
    );
  }


}