import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';

class MyLoadMoreDelegate extends LoadMoreDelegate {
  final ScrollController controller;

  const MyLoadMoreDelegate(this.controller);

  double widgetHeight(LoadMoreStatus status) =>
      200; // the loadMore height. default is 80.0

  Duration loadMoreDelay() => Duration(milliseconds: 0);

  @override
  Widget buildChild(LoadMoreStatus status,
      {builder = DefaultLoadMoreTextBuilder.chinese}) {
    if (status == LoadMoreStatus.loading || status == LoadMoreStatus.idle) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      );
    } else if (status == LoadMoreStatus.nomore) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('إنتهت النتائج'),
            FlatButton(
                color: Colors.green,
                onPressed: () => this.controller.animateTo(0,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeOutBack),
                child: Text(
                  'العودة للاعلي',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      );
    } else {
      return Text('فشل');
    }
  }
}
