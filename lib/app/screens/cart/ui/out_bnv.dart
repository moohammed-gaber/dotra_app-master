import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic.dart';
import 'in_bnv.dart';

class CartUiOutBnvRoot extends StatelessWidget {
  static const route = '/cart';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        child: CartUiOutBnv(),
        create: (BuildContext context) => CartLogic(context, null));
  }
}

class CartUiOutBnv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('السلة'),
      ),
      body: CartUiBnv(),
    );
  }
}
