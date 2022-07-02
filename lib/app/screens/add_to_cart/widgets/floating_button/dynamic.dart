import 'package:dotra/app/screens/add_to_cart/widgets/floating_button.dart';
import 'package:flutter/material.dart';

class DynamicFloatingButton extends StatelessWidget {
  final bool condition;
  final VoidCallback onPressed;
  final Color backgroundColor;

  final IconData icon;

  const DynamicFloatingButton({
    Key key,
    this.onPressed,
    this.backgroundColor,
    this.icon,
    this.condition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return condition
        ? FixedFloatingButton(
            backgroundColor: backgroundColor, icon: icon, onPressed: onPressed)
        : FixedFloatingButton(
            backgroundColor: Theme.of(context).primaryColorDark,
            icon: icon,
            onPressed: null);
  }
}
