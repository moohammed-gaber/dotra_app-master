import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../logic.dart';

class BottomNavigationBarMso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RootLogic rootLogic = Provider.of(context);
    return CurvedNavigationBar(
      index: rootLogic.selectedScreenIndex,
      height: 50.0.h,
      items: rootLogic.screens
          .getRange(0, 5)
          .map((e) => Icon(
                e.bnvIconData,
                size: 30,
                color: Colors.white,
              ))
          .toList(),
      color: Theme.of(context).primaryColor,
      buttonBackgroundColor: Theme.of(context).primaryColor,
      backgroundColor: kBlueColor,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: (i) => rootLogic.onTapBottomNavigation(i),
    );
  }
}
