import 'package:dotra/app/globals/widgets/product_tile.dart';
import 'package:dotra/app/screens/add_to_cart/ui.dart';
import 'package:dotra/app/screens/add_to_cart/widgets/total_tile.dart';
import 'package:dotra/app/screens/cart/ui/widgets/empty.dart';
import 'package:dotra/app/screens/home/models/product.dart';
import 'package:dotra/app/screens/root/logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../logic.dart';

class CartUiBnVRoot extends StatelessWidget {
  void toEdit(BuildContext context, int index) {
    var cartElement = Hive.box('cart').values.toList()[index];
    var product = Product.fromJson(cartElement);

    showDialog(
        context: context,
        builder: (_) => AddToCartUiRoot(
              navigateToCart: (BuildContext context) async =>
                  Navigator.pop(context),
              product: product,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        child: CartUiBnv(),
        create: (BuildContext context) => CartLogic(context, toEdit));
  }
}

class CartUiBnv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RootLogic rootLogic = Provider.of(
      context,
    );

    CartLogic cartLogic = Provider.of(context);
    cartLogic.cart =
        Hive.box('cart').values.map((e) => Product.fromJson(e)).toList();
    var cart = cartLogic.cart;
    return cartLogic.cart.length == 0
        ? EmptyCart()
        : Column(
            children: [
              ButtonTheme(
                  height: 50.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          onPressed: () => cartLogic.sendCart(context),
                          child: Text(
                            'طلب السلة',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.orange,),
                      ),
                      Expanded(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          onPressed: () => cartLogic.clearCart(),
                          child: Text(
                            'مسح السلة',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.red,
                        ),
                      ),
                    ],
                  )),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: cart.length,
                  itemBuilder: (BuildContext context, int index) {
                    // print(cart[0].toJson());
                    return ProductTile(
                      onTap: cartLogic.tapCart == null
                          ? null
                          : () => cartLogic.tapCart(context, index),
                      product: cart[index],
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.remove_circle_outline,
                                size: 28,
                                color: Colors.red,
                              ),
                              onPressed: () => cartLogic.deleteProduct(index)),
                        ],
                      ),
                    );
                  },
                ),
              ),
              TotalTile(
                price: cartLogic.getOrderPrice,
                priceAfterDiscount: cartLogic.getOrderPriceAfterDiscount,
                text: 'السعر الاجمالي لطلب ${cartLogic.getOrderQuantity} عبوه ',
                haveDiscount: cartLogic.haveDiscount,
              ),
            ],
          );
  }
}
