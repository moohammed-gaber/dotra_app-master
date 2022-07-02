import 'dart:async';

import 'package:dotra/app/globals/methods/cart_methods.dart';
import 'package:dotra/app/globals/models/attributes.dart';
import 'package:dotra/app/screens/home/models/product.dart';
import 'package:dotra/app/screens/root/logic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

typedef Future<void> NavigateToCart(BuildContext context);
Timer timer;
int start = 172800;

class AddToCartLogic extends ChangeNotifier {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  Product product;

  List<Attribute> attributes;

  int productId;
  int index;

  var formKey = GlobalKey<FormState>();
  BuildContext context;

  NavigateToCart cartNavigate;

  AddToCartLogic(this.context, this.cartNavigate, this.product) {
    attributes = product.attributes;
    productId = product.id;
    index = productIndexInCart;

    if (index != -1) {
      var x =
          Product.fromJson(Hive.box('cart').values.toList()[index]).attributes;
      for (int i = 0; i < x.length; i++) {
        if (x[i] != null) {
          attributes[i].textEditingController.text =
              x[i].orderedQuantity.toString();
        }
      }
    }
  }
  bool get isTextControllersEmpty =>
      attributes.every((element) => element.isTextControllerEmpty);
  void onChangedTextField(String text) {
    notifyListeners();
  }

  String get addOrEditButtonText {
    if (productIndexInCart == -1) return 'أضف للسله';

    return 'عدل السلة';
  }

  bool get availableInCart => CartMethods(product).isProductAvailable;

  int get productIndexInCart => CartMethods(product).productIndexInCart;

  num get savedTotalPrice {
    if (isProductAvailable)
      return Product.fromJson(
              Hive.box('cart').values.toList()[productIndexInCart])
          .attributesPrice;

    return 0;
  }

  bool get isProductAvailable => productIndexInCart == -1 ? false : true;

  num get savedTotalPriceAfterDiscount {
    if (isProductAvailable)
      return Product.fromJson(
              Hive.box('cart').values.toList()[productIndexInCart])
          .attributesPriceAfterDiscount;

    return 0;
  }

  num get totalPriceAfterDiscount => (attributes
      .map((e) => e.calculatedPriceAfterDiscount)
      .reduce((value, element) => value + element));

  num get totalPrice => (attributes
      .map((e) => e.calculatedPrice)
      .reduce((value, element) => value + element));

  int get getTotalOrderedQuantity => (attributes
      .map((e) => e.orderedQuantity)
      .reduce((value, element) => value + element));

  String validator(String input, Attribute attribute) {
    if (input.isEmpty) return null;
    var intInput = int.parse(input);
    var availableQuantity = attribute.availableQuantity;
    if (intInput > availableQuantity) {
      return 'متوفر ${attribute.availableQuantity}عبوه';
    }

    return null;
  }

  void notifyRootListeners(BuildContext context) {
    Provider.of<RootLogic>(context, listen: false).notifyListeners();
  }

  bool get isAddToCartButtonActive {
    var index =
        this.attributes.indexWhere((element) => element.orderedQuantity != 0);

    if (index == -1) {
      return false;
    }

    return true;
  }

  void delete(BuildContext context) {
    CartMethods.deleteProduct(CartMethods(product).productIndexInCart);
    notifyRootListeners(context);
    notifyListeners();
  }

  void clearTextFields() {
    attributes.forEach((element) {
      element.textEditingController.clear();
    });
    notifyListeners();
  }

  Future<void> addOrEditCart(BuildContext context) async {
    if (!formKey.currentState.validate()) return;

    var selected = product.toJson();
    int index = productIndexInCart;

    if (index == -1) {
      Hive.box('cart').add(selected);
    } else {
      Hive.box('cart').putAt(index, selected);
    }

    notifyRootListeners(context);

    notifyListeners();
  }
}
