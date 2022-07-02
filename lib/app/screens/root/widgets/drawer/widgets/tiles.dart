import 'package:dotra/app/screens/root/logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<Widget> tiles(BuildContext context) {
  RootLogic logic = Provider.of(context, listen: false);
  var screens = logic.screens;

  return [
    for (int i = 0; i < screens.length; i++)
      Container(
        color: logic.selectedScreenIndex == i
            ? Colors.grey.withOpacity(0.1)
            : Colors.transparent,
        child: ListTile(
          onTap: () {
            Navigator.pop(context);

            screens[i].tap(screens[i].x);
          },
          title: Text(screens[i].appBarTitle),
          leading: Icon(screens[i].bnvIconData),
        ),
      )
  ];
}

class Tile extends StatelessWidget {
  final bool selected;
  final Widget tile;

  const Tile({Key key, this.selected, this.tile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        color: selected ? Colors.grey.withOpacity(0.1) : Colors.transparent,
        child: tile);
  }
}
