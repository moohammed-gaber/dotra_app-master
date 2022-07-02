import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'navigation.dart';

class DonePage extends StatelessWidget {
  final String description;
  final routPage;

  DonePage(this.description, this.routPage);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                FontAwesomeIcons.thumbsUp,
                size: height / 3,
                color: Colors.black,
              ),
              Text(
                description,
                style: TextStyle(fontSize: width * .070),
              ),
              Container(
                color: Colors.green,
                child: FlatButton(onPressed: ()=> NavigationRout.navigatorOf(context, routPage), child: Text("متابعه",style: TextStyle(color: Colors.white),),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
