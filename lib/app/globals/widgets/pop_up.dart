import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PopUpWidgets {
  static void showSnackBar(BuildContext context, String text,
      {Color color = Colors.green}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: color,
    ));
  }

  static ProgressDialog progressDialog(BuildContext context) {
    var progressDialog = ProgressDialog(
      context,
      isDismissible: false,
    );
    progressDialog.style(
        message: 'انتظر جاري التحميل',
        progressWidget: Center(
            child: SizedBox(
          child: CircularProgressIndicator(),
          width: 40.w,
          height: 40.h,
        )),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.h));
    return progressDialog;
  }
  // Future<void> showProgressDialog() async =>await progressDialog.show();
  // Future<void> hideProgressDialog() async =>await progressDialog.hide();

}
