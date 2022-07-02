import 'package:dotra/app/globals/widgets/product_tile.dart';
import 'package:dotra/app/screens/previous_orders/models/previous_order.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'logic.dart';

class PreviousOrdersUi extends StatefulWidget {
  static const route = '/previous_orders';

  @override
  _PreviousOrdersUiState createState() => _PreviousOrdersUiState();
}

class _PreviousOrdersUiState extends State<PreviousOrdersUi> {
  @override
  void initState() {
    super.initState();
    PreviousOrdersLogic logic = Provider.of(context, listen: false);
    logic.refreshIfNewOrderAdded();
  }

  @override
  Widget build(BuildContext context) {
    PreviousOrdersLogic logic = Provider.of(context);
    return Scaffold(
        body: FutureBuilder<List<PreviousOrdersEntity>>(
            future: logic.futureApiRequest,
            builder: (BuildContext context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('يوجد خطأ'),
                    );
                  } else {
                    logic.setPreviousOrders = snapshot.data;
                    var previousOrders = logic.previousOrders;
                    if (previousOrders.isEmpty)
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning_amber_sharp,
                              size: 100,
                              color: Colors.red,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Text('لم تقم بطلب اي اوردر إلي الآن'),
                            )
                          ],
                        ),
                      );

                    return SmartRefresher(
                      onRefresh: logic.onRefresh,
                      controller: logic.refreshController,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        itemCount: previousOrders.length,
                        itemBuilder: (BuildContext context, int index) {
                          var previousOrder = previousOrders[index];
                          return ExpandablePanel(
                            expanded: Column(
                              children: previousOrder.products
                                  .map(
                                    (e) => ProductTile(
                                      onTap: () => logic.toAttributes(
                                          context, e.attributes),
                                      product: e,
                                    ),
                                  )
                                  .toList(),
                            ),
                            header: Container(
                              padding: EdgeInsets.only(
                                  left: 20, right: 10, bottom: 20, top: 20),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(previousOrder.date.toString()),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text.rich(TextSpan(
                                        text:
                                            'الاوردر رقم ${previousOrder.orderNum} : ',
                                        children: [
                                          TextSpan(
                                              text:
                                                  '${previousOrder.orderTotalPrice} جم',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700))
                                        ])),
                                  ),
                                  Visibility(
                                      visible: previousOrder.isHaveNote,
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text.rich(
                                            TextSpan(children: [
                                              TextSpan(
                                                  text: previousOrder.userNotes,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700))
                                            ], text: 'الملاحظة : '),
                                          )))
                                ],
                              ),
                            ),
                          );
                          // return InkWell(
                          //   onTap: () => logic.toProducts(
                          //       context, previousOrder.products),
                          //   child: Container(
                          //     padding: EdgeInsets.only(
                          //         left: 20, right: 10, bottom: 20, top: 20),
                          //     child: Column(
                          //       children: [
                          //         Align(
                          //           alignment: Alignment.centerLeft,
                          //           child: Text(previousOrder.date.toString()),
                          //         ),
                          //         Align(
                          //           alignment: Alignment.centerRight,
                          //           child: Text.rich(TextSpan(
                          //               text:
                          //                   'الاوردر رقم ${previousOrder.orderNum} : ',
                          //               children: [
                          //                 TextSpan(
                          //                     text:
                          //                         '${previousOrder.orderTotalPrice} جم',
                          //                     style: TextStyle(
                          //                         fontSize: 30,
                          //                         color: Colors.green,
                          //                         fontWeight: FontWeight.w700))
                          //               ])),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          height: 0,
                        ),
                      ),
                    );
                  }
                  break;
                default:
                  return Center(child: CircularProgressIndicator());
                  break;
              }
            }),
        appBar: AppBar(title: Text('الاوردرات السابقة')));
  }
}
