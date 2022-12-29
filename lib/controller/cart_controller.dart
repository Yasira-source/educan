import 'package:get/get.dart';

import '../models/all_products_model.dart';
import '../models/bookshop_model.dart';

class CartController extends GetxController {
  // Add a dict to store the products in the cart.
  final _products = {}.obs;

  final _productsx = {}.obs;

  void addProductx(ProductsData productx) {
    if (_productsx.containsKey(productx)) {
      _productsx[productx] += 1;
    } else {
      _productsx[productx] = 1;
    }

    Get.snackbar(
      "Product Added",
      "You have added ${productx.pname} to your cart",
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );
  }

  void removeProductx(ProductsData productx) {
    if (_productsx.containsKey(productx) && _productsx[productx] > 1) {
      // _products.removeWhere((key, value) => key == product);
      _productsx[productx] -= 1;
    } else {
      // _products[product] -= 1;
    }
  }

  void removeProduct2x(ProductsData productx) {
    _productsx.removeWhere((key, value) => key == productx);
  }

  void removeProduct3x() {
    _productsx.clear();
  }

  get productsx => _productsx;

  get productSubtotalx => _productsx.entries
      .map((productx) => productx.key.pprice * productx.value)
      .toList();

  get totalx => _productsx.entries
      .map((productx) => productx.key.pprice * productx.value)
      .toList()
      .reduce((value, element) => value + element);
  //bookshop
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

  bool checkProductExists(BookshopData product) {
    if (_products.containsKey(product)) {
      return true;
    } else {
      return false;
    }
  }

  String checkProductTotal(BookshopData product) {
    if (_products.containsKey(product)) {
     return  _products[product].toString();
    } else {
      return '0';
    }
  }

  
  bool checkProductExistsx(ProductsData product) {
    if (_products.containsKey(product)) {
      return true;
    } else {
      return false;
    }
  }

  String checkProductTotalx(ProductsData product) {
    if (_products.containsKey(product)) {
     return  _products[product].toString();
    } else {
      return '0';
    }
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

  void removeProduct3() {
    _products.clear();
  }

  get products => _products;

  get productSubtotal => _products.entries
      .map((product) => product.key.price * product.value)
      .toList();

  get total => _products.entries
      .map((product) => product.key.price * product.value)
      .toList()
      .reduce((value, element) => value + element);
}
