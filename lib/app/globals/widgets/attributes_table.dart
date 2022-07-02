import 'package:dotra/app/globals/models/abstract/attribute.dart';
import 'package:dotra/app/globals/widgets/price_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef Widget Hello(int index);

class AttributesTable extends StatelessWidget {



  final List<BasicAttribute> attributes;
  // final Widget quantity;
  final Hello hello;
  AttributesTable(this.attributes, this.hello);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DataTable(
          dataRowHeight: 60.h,
          columnSpacing: 0,
          columns: [
            DataColumn(
              label: Text(
                'اسم العبوة',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            DataColumn(
                label: Text(
              'سعر العبوة',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            )),
            DataColumn(
                label: Text(
              'سعر الطلب',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            )),
            DataColumn(
              label: Text(
                'عدد العبوات',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
          rows: [
            for (int i = 0; i < attributes.length; i++)
              DataRow(cells: [
                DataCell(Text(
                  attributes[i].name ?? '',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                )),
                DataCell(PriceText(
                  haveDiscount: attributes[i].haveDiscount,
                  price: attributes[i].price,
                  priceAfterDiscount: attributes[i].priceAfterDiscountPerOne,
                )),
                DataCell(PriceText(
                  haveDiscount: attributes[i].haveDiscount,
                  price: attributes[i].calculatedPrice,
                  priceAfterDiscount:
                      attributes[i].calculatedPriceAfterDiscount,
                )),
                DataCell(SizedBox.fromSize(
                    size: Size.fromWidth(80.w), child: hello(i))),
              ])
          ],
        ),
      ],
    );
  }
}
/*
                                  visible: attributes[i]
                      .textEditingController
                      .text
                      .isNotEmpty,

                 */
