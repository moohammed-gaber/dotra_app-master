import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ShowDialog {

  static showDialogFun(context, title, content) {
    showDialog(context: content, child: AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        FlatButton(onPressed: () => Navigator.pop(context), child: Text("ok"))
      ],
    ));
  }
}