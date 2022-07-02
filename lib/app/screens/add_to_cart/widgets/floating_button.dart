import 'package:flutter/material.dart';

class FixedFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;

  final IconData icon;

  const FixedFloatingButton(
      {Key key, this.onPressed, this.backgroundColor, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        heroTag: null,
        disabledElevation: 0,
        child: Icon(icon),
        backgroundColor: backgroundColor,
        onPressed: onPressed);
  }
}
