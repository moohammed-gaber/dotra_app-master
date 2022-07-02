import 'package:dotra/app/screens/use_policy/logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsePolicyUiRoot extends StatelessWidget {
  static const route = '/use_policy';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UsePolicyLogic(),
      child: UsePolicyUi(),
    );
  }
}

class UsePolicyUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('سياسه الإستخدام'),
      ),
    );
  }
}
