import 'package:dotra/app/screens/home/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'category_list.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeLogic homeLogic = Provider.of(context);
    return Container(
      height: 30.h,
      child: FutureBuilder(
          future: homeLogic.fetchCategoriesFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  var dataCategories = snapshot.data;
                  return Center(
                    child: CategoriesProductsList(
                      categories: dataCategories,
                    ),
                  );
                }
                break;
              default:
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                );
            }
          }),
    );
  }
}
