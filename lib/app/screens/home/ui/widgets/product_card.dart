import 'package:dotra/app/globals/methods/cart_methods.dart';
import 'package:dotra/app/globals/widgets/widgets.dart';
import 'package:dotra/app/screens/home/logic.dart';
import 'package:dotra/app/screens/home/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

class BanneredProductCard extends StatelessWidget {
  final Product product;
  final bool isEven;

  const BanneredProductCard({Key key, this.product, this.isEven})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productCard = ProductsCard(product: product, isEven: isEven);
    return product.isAvailable
        ? product.haveDiscount
            ? Banner(
                location: BannerLocation.topEnd,
                message: 'يوجد خصم',
                color: Colors.green,
                child: productCard)
            : productCard
        : Banner(
            child: productCard,
            message: 'غير متوفر',
            color: Colors.red,
            location: BannerLocation.topEnd);
  }
}

class ProductsCard extends StatelessWidget {
  final Product product;
  final bool isEven;

  const ProductsCard({Key key, this.product, this.isEven}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeLogic homeLogic = Provider.of(context);

    return Container(
      height: 140.h,
      child: InkWell(
        onTap: () => homeLogic.toProductDetails(context, product),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: isEven ? kBlueColor : kSecondaryColor,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    Hero(
                      tag: '${product.id.toString()}',
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: GlobalWidgets.image(product.isImagesEmpty, 80,250, product.mainImage)),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            product.name.toString(),
                            style: TextStyle(
                              fontSize: 20.sp,
                            ),
                          ),
                          Text(
                            product.getDescription,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.button,
                          ),

                          // it use the available space
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: CartMethods(product).isProductAvailable,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
