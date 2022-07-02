import 'package:dotra/app/globals/models/attributes.dart';
import 'package:dotra/app/globals/widgets/attributes_table.dart';
import 'package:dotra/app/screens/add_to_cart/widgets/floating_button/dynamic.dart';
import 'package:dotra/app/screens/add_to_cart/widgets/total_tile.dart';
import 'package:dotra/app/screens/home/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'logic.dart';
import 'widgets/floating_button.dart';

class AddToCartUiRoot extends StatelessWidget {
  final Product product;
  final NavigateToCart navigateToCart;

  const AddToCartUiRoot({
    Key key,
    this.product,
    @required this.navigateToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: AddToCartUi(
        product: product,
      ),
      create: (_) => AddToCartLogic(
        context,
        navigateToCart,
        product,
      ),
    );
  }
}

class AddToCartUi extends StatelessWidget {
  final Product product;

  const AddToCartUi({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddToCartLogic logic = Provider.of(context);
    List<Attribute> attributes = logic.attributes;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: ButtonTheme(
        disabledColor: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 45.h,
        minWidth: 200.w,
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Form(
                key: logic.formKey,
                child: AttributesTable(
                  attributes,
                  (i) => TextFormField(
                    validator: (String input) =>
                        logic.validator(input, logic.attributes[i]),
                    onChanged: logic.onChangedTextField,
                    controller: logic.attributes[i].textEditingController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.deny(RegExp(r'^0'))
                    ],
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ),
            TotalTile(
              haveDiscount: product.haveDiscount,
              price: logic.totalPrice,
              priceAfterDiscount: logic.totalPriceAfterDiscount,
              text: 'مجموع السعر حسب القيم الحالية',
            ),
            Divider(),
            TotalTile(
              haveDiscount: product.haveDiscount,
              price: logic.savedTotalPrice,
              priceAfterDiscount: (logic.savedTotalPriceAfterDiscount),
              text: 'مجموع السعر حسب القيم المحفوظة',
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DynamicFloatingButton(
                  condition: logic.isAddToCartButtonActive,
                  icon: (Icons.add),
                  backgroundColor: Colors.green,
                  onPressed: () => logic.addOrEditCart(context),
                ),
                FixedFloatingButton(
                    icon: (Icons.shopping_cart),
                    backgroundColor: Colors.green,
                    onPressed: () => logic.cartNavigate(context)),
                DynamicFloatingButton(
                  condition: logic.availableInCart,
                  icon: (Icons.delete),
                  backgroundColor: Colors.red,
                  onPressed: () => logic.delete(context),
                ),
                DynamicFloatingButton(
                  condition: !logic.isTextControllersEmpty,
                  icon: Icons.clear,
                  backgroundColor: Colors.red,
                  onPressed: logic.clearTextFields,
                ),
              ],
            ),
            Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
