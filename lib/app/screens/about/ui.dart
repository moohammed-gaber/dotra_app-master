import 'package:dotra/utilities_mso/setting_mso.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'logic.dart';

class AboutUiRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: AboutUi(),
      create: (BuildContext context) => AboutLogic(),
    );
  }
}

class AboutUi extends StatelessWidget {
  final processingData = new ProcessingData();

  @override
  Widget build(BuildContext context) {
    AboutLogic logic = Provider.of(context);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: logic.fetchAboutsDataFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return processingData.loading();
                break;
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return processingData.error(snapshot.error.toString());
                } else {
                  var about = snapshot.data;
                  return SingleChildScrollView(
                    child: Text(
                      about.details.toString(),
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  );
                }
                break;
              default:
                return processingData.error('لا يوجد داتا');
            }
          },
        ),
      ),
    );
  }
}
