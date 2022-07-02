import 'package:dotra/app/globals/widgets/price_text.dart';
import 'package:flutter/material.dart';

class TotalTile extends StatelessWidget {
  final num price;
  final num priceAfterDiscount;

  final String text;
  final bool haveDiscount;

  const TotalTile(
      {Key key,
      this.price,
      this.text,
      this.haveDiscount,
      this.priceAfterDiscount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: PriceText(
        priceAfterDiscount: (priceAfterDiscount),
        price: price,
        haveDiscount: haveDiscount,
      ),
      title: Text(
        text,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
      ),
    );
  }
}
