import 'package:flutter/material.dart';

class CategoriesProductsList extends StatelessWidget {
  final List categories;

  CategoriesProductsList({
    Key key,
    this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10),
        separatorBuilder: (_, __) =>
            Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              //transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              categories[index]['name'],
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }
}
