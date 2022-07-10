import 'dart:async';

import 'package:get/get.dart';

import '../models/bookshop_model.dart';
import 'all_products_controller.dart';

class ProductController extends GetxController {
  var isAddLoading = false.obs;
  // Add a list of Product objects.
  final products = <BookshopData>[].obs;

  @override
  void onInit() {
    // products.bindStream(CategoryProductsController().fetchData("Book", "ASC"));
    super.onInit();
  }
  void addToCart() {
    isAddLoading.value = true;
    update();
    Timer(const Duration(seconds: 2), () {
      isAddLoading.value = false;
      update();
    });
  }


  
}