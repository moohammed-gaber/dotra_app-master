import 'package:dotra/app/globals/methods/cart_methods.dart';
import 'package:dotra/app/screens/add_to_cart/logic.dart';
import 'package:dotra/app/screens/add_to_cart/ui.dart';
import 'package:dotra/app/screens/cart/ui/out_bnv.dart';
import 'package:dotra/app/screens/home/models/product.dart';
import 'package:dotra/res.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_carousel_slider.dart';

class ProductDetailsLogic extends ChangeNotifier {
  Product product;

  ProductDetailsLogic(this.product);

  void addToCart(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => AddToCartUiRoot(
              navigateToCart: navigate,
              product: product,
            )));
  }

  Widget header() {
    if (product.isImagesEmpty) {
      return Image.asset(Res.logo);
    } else {
      if (product.isSingleImage) {
        return Image.network(product.mainImage);
      } else {
        return MyCarouselSlider(
          images: product.images,
        );
      }
    }
  }

  Future<void> navigate(BuildContext context) async {
    await Navigator.pushNamed(context, CartUiOutBnvRoot.route);
    if (!CartMethods(product).isProductAvailable) {
      product.attributes.forEach((element) {
        element.textEditingController.clear();
      });

      Provider.of<AddToCartLogic>(context, listen: false).notifyListeners();
    }
  }
}
