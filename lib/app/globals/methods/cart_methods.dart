import 'package:dotra/app/screens/home/models/product.dart';
import 'package:hive/hive.dart';

class CartMethods {
  Product product;

  CartMethods(this.product);

  static void deleteProduct(int index) {
    Hive.box('cart').deleteAt(index);
  }

  static bool get isEmptyCart => Hive.box('cart').values.isEmpty;

  bool get isProductAvailable => productIndexInCart == -1 ? false : true;

  int get productIndexInCart =>
      productsFromJsonList(Hive.box('cart').values.toList())
          .indexWhere((element) => element.id == product.id);
}
