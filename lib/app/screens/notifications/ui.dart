import 'package:dotra/app/screens/home/ui/helpers/load_more_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'entity.dart';
import 'logic.dart';

class NotificationUiRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => NotificationLogic(),
      child: NotificationUi(),
    );
  }
}

class NotificationUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NotificationLogic logic = Provider.of<NotificationLogic>(context);
    return FutureBuilder<ApiResponse>(
        future: logic.futureApiRequest,
        builder: (BuildContext context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              {

                if (snapshot.hasError) return Text('error');

                final apiResponse = snapshot.data;
                final notifications = apiResponse.data.data;
                if (notifications.isEmpty)
                  return Center(
                    child: Text(''),
                  );
                logic.notifications = notifications;
                return LoadMore(
                  isFinish: apiResponse.data.lastPage == logic.page,
                  onLoadMore: logic.loadMore,
                  delegate: MyLoadMoreDelegate(logic.controller),
                  child: SmartRefresher(
                    onRefresh: logic.onRefresh,
                    controller: logic.refreshController,
                    child: ListView.separated(
                        controller: logic.controller,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        itemCount: logic.notifications.length,
                        itemBuilder: (BuildContext context, int index) {
                          final notification = logic.notifications[index];

                          return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        color: Colors.green)
                                  ]),
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 20, left: 10, right: 5),
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(notification.date)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Image.network(
                                            // 'https://i0.wp.com/www.middleeastmonitor.com/wp-content/uploads/2020/09/GettyImages-1228472794.jpg?resize=1200%2C800&quality=85&strip=all&zoom=1&ssl=1',
                                            notification.image,

                                            fit: BoxFit.cover,
                                            width: 60,
                                            height: 70,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              notification.name,
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              notification.details,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: notification.isHaveUrlLink,
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: FlatButton(
                                            onPressed: () => logic.openLink(
                                                context, notification.urlLink),
                                            child: Text('افتح الرابط'))),
                                  )
                                ],
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider()),
                  ),
                );
              }
              break;
          }
        });
  }
}

/*
    return Center(
      child: Container(
        child: Text(
          'لا يوجد اشعارات حاليه',
        ),
      ),
    );
*/
