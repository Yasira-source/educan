
import 'package:educanapp/models/all_products_model.dart';
import 'package:get/get.dart';


class EcomCartController extends GetxController {
  // Add a dict to store the products in the cart.
  var _products = {}.obs;

  void addProduct(ProductsData product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }

    Get.snackbar(
      "Product Added",
      "You have added ${product.pname} to your cart",
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );
  }

  void removeProduct(ProductsData product) {
    if (_products.containsKey(product) && _products[product] > 1) {
      // _products.removeWhere((key, value) => key == product);
      _products[product] -= 1;
    } else {

      // _products[product] -= 1;
    }
  }

  void removeProduct2(ProductsData product) {

    _products.removeWhere((key, value) => key == product);

  }

  void removeProduct3() {

    _products.clear();

  }

  get products => _products;

  get productSubtotal => _products.entries
      .map((product) => product.key.pprice * product.value)
      .toList();

  get total => _products.entries
      .map((product) => product.key.pprice * product.value)
      .toList()
      .reduce((value, element) => value + element)
      ;
}
