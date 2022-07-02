import 'package:dotra/app/globals/models/abstract/product.dart';
import 'package:dotra/app/globals/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductTile extends StatelessWidget {
  final BasicProductEntity product;
  final Widget trailing;
  final VoidCallback onTap;
  // bool haveDiscount;

  const ProductTile(
      {Key key,
      this.product,
      this.trailing = const SizedBox.shrink(),
      this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(product.mainImage);
    return ListTile(
        subtitle: product.haveDiscount
            ? Row(
                children: [
                  Text(
                    '${product.attributesPriceAfterDiscount.toStringAsFixed(2)}جم ',
                    style: TextStyle(fontSize: 18.sp, color: Colors.orange),
                  ),
                  Text(
                    '${product.attributesPrice.toStringAsFixed(2)}جم ',
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                ],
              )
            : Text(
                '${product.attributesPrice.toStringAsFixed(2)}جم ',
                style: TextStyle(fontSize: 16.sp, color: Colors.green),
              ),
        onTap: this.onTap,
        title: Text('${product.totalOrderedQuantity} عبوة من ${product.name}'),
        leading: GlobalWidgets.image(
            product.isImagesEmpty, 50, 50, product.mainImage),
        trailing: trailing);
  }
}
