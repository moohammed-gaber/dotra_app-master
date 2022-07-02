import 'package:dotra/app/screens/home/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'logic.dart';

class ProductDetailsUiRoot extends StatelessWidget {
  static const route = '/product_details';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        child: ProductDetailsUi(),
        create: (_) => ProductDetailsLogic(
            ModalRoute.of(context).settings.arguments as Product));
  }
}

class ProductDetailsUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductDetailsLogic logic = Provider.of(context);
    var product = logic.product;
    return Scaffold(
      floatingActionButton: Visibility(
          visible: product.isAvailable,
          child: FloatingActionButton(
            heroTag: null,
            child: Icon(FontAwesomeIcons.cartPlus),
            backgroundColor: Colors.green,
            onPressed: () => logic.addToCart(context),
          )),
      appBar: AppBar(
        centerTitle: true,
        title: Text('تفاصيل المنتج'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Hero(tag: '${product.id}', child: logic.header()),
            ),
            //ListOfColors(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    product.getDescription,
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
            Center(
              child: ButtonTheme(
                height: 55.h,
                child: FlatButton.icon(
                  color: Colors.white,
                  onPressed: () {
                    productDetailsLogic.addToCart(context);
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/shopping-bag.svg",
                    height: 18,
                    color: Colors.green,
                  ),
                  label: Text(
                    "Add to Cart",
                    style:
                        TextStyle(fontSize: fontSizeMso, color: Colors.green),
                  ),
                ),
              ),
            ),

 */
