import 'package:flutter/material.dart';

typedef void Tap(params);

class ScreenModel {
  final Widget screenBody, floatingActionButton;
  final String appBarTitle;
  final IconData bnvIconData;
  final Tap tap;
  final dynamic x;
  ScreenModel(this.screenBody, this.bnvIconData, this.appBarTitle, this.tap,
      {this.x, this.floatingActionButton});
}
