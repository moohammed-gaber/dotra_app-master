import 'dart:async';
import 'dart:convert';

import 'package:dotra/app/globals/widgets/pop_up.dart';
import 'package:dotra/app/screens/cart/ui/widgets/note_dialog.dart';
import 'package:dotra/app/screens/home/models/product.dart';
import 'package:dotra/app/screens/login/models/root.dart';
import 'package:dotra/app/screens/login/ui.dart';
import 'package:dotra/app/screens/previous_orders/logic.dart';
import 'package:dotra/app/screens/root/logic.dart';
import 'package:dotra/utilities_mso/setting_mso.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

typedef void TapCart(BuildContext context, int index);

class CartLogic extends ChangeNotifier {
  var noteTextFieldController = TextEditingController();
  List<Product> cart;
  TapCart tapCart;
  BuildContext context;

  CartLogic(this.context, this.tapCart);
  void clearNote() => noteTextFieldController.clear();
  bool get isClearButtonVisible => noteTextFieldController.text.isNotEmpty;
  void deleteProduct(int index) {
    Hive.box('cart').deleteAt(index);
    Provider.of<RootLogic>(context, listen: false).notifyListeners();
    notifyListeners();
  }

  void onChangedNote(String input) {
    print('Ee');
    notifyListeners();
  }

  void clearCart() async {
    await Hive.box('cart').clear();
    notifyListeners();
  }

  Map<String, dynamic> get cartBody => {
        "user_id": Login.fromJson(Hive.box('login').get('login')).data.id,
        "order_total_price": getOrderPriceAfterDiscount,
        "payment_type": 0,
        "user_notes": noteTextFieldController.text,
        "products": cart
            .map((e) => {
                  "product_id": e.id,
                  "company_id": e.companyId,
                  "total_price": e.attributesPriceAfterDiscount,
                  "total_quantity": e.totalOrderedQuantity,
                  "attributes": e.attributes
                      .map((e) {
                        if (e.orderedQuantity > 0)
                          return {
                            "attribute_id": e.id,
                            "quantity": e.orderedQuantity,
                            "price4one": e.price,
                            "discount": e.discount,
                            "price4all": e.calculatedPriceAfterDiscount
                          };
                      })
                      .where((element) => element != null)
                      .toList()
                })
            .toList()
      };

  num get getOrderPriceAfterDiscount => cart
      .map((e) => e.attributesPriceAfterDiscount)
      .reduce((value, element) => value + element);

  num get getOrderPrice => cart
      .map((e) => e.attributesPrice)
      .reduce((value, element) => value + element);

  int get getOrderQuantity => cart
      .map((e) => e.attributes
          .map((e) => e.orderedQuantity)
          .reduce((value, element) => value + element))
      .reduce((value, element) => value + element);

  bool get haveDiscount =>
      cart.map((e) => e.haveDiscount).any((element) => element == true);

  void showNoteDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return NoteDialog(context);
        });
  }

  Future<void> sendCartApiRequest(BuildContext context) async {
    RootLogic rootLogic = Provider.of(context, listen: false);

    var progressDialog = PopUpWidgets.progressDialog(context);

    try {
      progressDialog.show();
      var response =
          await http.post(userOrder,
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'Authorization':
                    'Bearer ${Login.fromJson(Hive.box('login').get('login')).success.token}'
              },
              body: jsonEncode(cartBody));

      progressDialog.hide();
      Provider.of<PreviousOrdersLogic>(context, listen: false).isNewOrderAdded =
          true;
      var cart = Hive.box('cart');

      await cart.clear();
      rootLogic.notifyListeners();
      rootLogic.refreshProducts();
      notifyListeners();

      PopUpWidgets.showSnackBar(context, 'تمت العملية بنجاح',
          color: Colors.orange);
    } catch (e) {
      progressDialog.hide();

      PopUpWidgets.showSnackBar(context, 'هناك خطأ ما', color: Colors.red);
    }
  }

  Future<void> sendCart(BuildContext context) async {
    var loginBox = Hive.box('login');
    if (loginBox.get('login') == null) {
      await Navigator.pushNamed(context, LoginUiRoot.route);
      if (loginBox.get('login') != null) {
        showNoteDialog(context);
      }
      return;
    }
    showNoteDialog(context);
  }

  Future<void> submitNoteDialog(BuildContext context) async {
    Navigator.pop(context);
    await sendCartApiRequest(context);
  }
}
