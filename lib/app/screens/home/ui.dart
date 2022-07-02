import 'package:dotra/app/screens/home/ui/helpers/load_more_delegate.dart';
import 'package:dotra/app/screens/home/ui/widgets/categories_screen.dart';
import 'package:dotra/app/screens/root/logic.dart';
import 'package:dotra/utilities_mso/setting_mso.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'logic.dart';
import 'models/product.dart';
import 'ui/helpers/scroll_behaviour.dart';
import 'ui/widgets/product_card.dart';
import 'ui/widgets/search_box.dart';

class HomeUiRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeLogic(),
      child: HomeUi(),
    );
  }
}

class HomeUi extends StatelessWidget {
  final processingData = new ProcessingData();

  @override
  Widget build(BuildContext context) {
    RootLogic rootLogic = Provider.of(
      context,
    );
    return Container(
      color: kPrimaryColor,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            child: SearchBox(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h, bottom: 30.h),
            child: Categories(),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 70.h),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                FutureBuilder(
                  future: rootLogic.fetchProductsFuture,
                  builder: (BuildContext context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          snapshot.error;
                          return processingData
                              .error(snapshot.error.toString());
                        } else {
                          final rootData = snapshot.data;
                          var data = rootData['data'];
                          if (rootLogic.products == null) {
                            rootLogic.products =
                                productsFromJsonList(data['data']);
                          }
                          return ScrollConfiguration(
                            behavior: MyBehavior(),
                            child: LoadMore(
                              delegate:
                                  MyLoadMoreDelegate(rootLogic.listController),
                              onLoadMore: rootLogic.loadMore,
                              isFinish: rootLogic.page == data['last_page'],
                              child: ListView.builder(
                                  controller: rootLogic.listController,
                                  itemCount: rootLogic.products.length,
                                  itemBuilder: (_, int index) => Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 10,
                                            right: 3),
                                        child: BanneredProductCard(
                                          product: rootLogic.products[index],
                                          isEven: index.isEven,
                                        ),
                                      )),
                            ),
                          );
                        }
                        break;
                      default:
                        return processingData.loading();
                        break;
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
