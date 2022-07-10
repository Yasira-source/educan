
import 'package:get/get.dart';

import '../models/bookshop_model.dart';

class CartController extends GetxController {
  // Add a dict to store the products in the cart.
  var _products = {}.obs;

  void addProduct(BookshopData product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }

    Get.snackbar(
      "Product Added",
      "You have added ${product.title} to your cart",
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );
  }

  void removeProduct(BookshopData product) {
    if (_products.containsKey(product) && _products[product] > 1) {
      // _products.removeWhere((key, value) => key == product);
      _products[product] -= 1;
    } else {

      // _products[product] -= 1;
    }
  }

  void removeProduct2(BookshopData product) {

      _products.removeWhere((key, value) => key == product);

  }
  get products => _products;

  get productSubtotal => _products.entries
      .map((product) => product.key.price * product.value)
      .toList();

  get total => _products.entries
      .map((product) => product.key.price * product.value)
      .toList()
      .reduce((value, element) => value + element)
     ;
}
