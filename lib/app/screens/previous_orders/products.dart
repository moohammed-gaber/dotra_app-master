import 'package:dotra/app/globals/widgets/attributes_table.dart';
import 'package:dotra/app/screens/previous_orders/models/product.dart';
import 'package:flutter/material.dart';

import 'models/attribute.dart';

class PreviousOrderAttributes extends StatelessWidget {
  static const route = '/previous_order_products';
  final List<ProductEntity> products;

  const PreviousOrderAttributes({Key key, this.products}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<AttributeEntity> attributes =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الطلب من المنتج'),
      ),
      body: AttributesTable(attributes,
          (i) => Center(child: Text(attributes[i].orderedQuantity.toString()))),
    );
    // return ProductTile(product: ,);
  }
}
