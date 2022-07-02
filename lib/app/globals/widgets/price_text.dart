import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceText extends StatelessWidget {
  final bool haveDiscount;
  final num price, priceAfterDiscount;

  const PriceText(
      {Key key, this.haveDiscount, this.price, this.priceAfterDiscount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var text = Text(
      '${(priceAfterDiscount).toStringAsFixed(2)} جم',
      style: TextStyle(
        fontSize: 16.sp,
        color: Colors.green,
        fontWeight: FontWeight.w700,
      ),
    );
    return haveDiscount && price != 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${price?.toStringAsFixed(2)} جم',
                style: TextStyle(
                    fontSize: 14.5.sp,
                    decorationColor: Colors.grey,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough),
              ),
              text
            ],
          )
        : text;
  }
}
