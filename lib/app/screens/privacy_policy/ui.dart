import 'package:dotra/app/screens/privacy_policy/logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyUiRoot extends StatelessWidget {
  static const route = '/privacy_policy';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        child: PrivacyPolicyUi(), create: (_) => PrivacyPolicyLogic());
  }
}

class PrivacyPolicyUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('سياسه الخصوصية'),
      ),
    );
  }
}
