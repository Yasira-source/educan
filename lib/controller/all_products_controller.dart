import 'dart:convert';

import 'package:educanapp/controller/base_controller.dart';
import 'package:educanapp/models/all_products_model.dart';
import 'package:educanapp/services/base_client.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../models/bookshop_model.dart';

class CategoryProductsController extends GetxController with BaseController {
  // var loginData = <Data>[].obs;

  Future<List<ProductsData>> fetchProducts(String tag, String sort) async {
    showLoading('Fetching Items...');
    var response = await BaseClient()
        .get('https://educanug.com/educan_new/educan/api',
            '/products/get_category_products.php?tag=$tag&sort=$sort')
        .catchError(handleError);
    // if (response != null)
    // print(response);
    List jsonResponse = json.decode(response.body);
    hideLoading();
    return jsonResponse.map((data) => ProductsData.fromJson(data)).toList();
  }


    Future<List<ProductsData>> fetchEcomBookshop(String tag, String sort) async {
    showLoading('Fetching Items...');
    var response = await BaseClient()
        .get('https://educanug.com/educan_new/educan/api',
            '/library/get_libarary_books.php?type=$tag&sortOrder=$sort')
        .catchError(handleError);
    // if (response != null)
    // print(response);
    List jsonResponse = json.decode(response.body);
    hideLoading();
    return jsonResponse.map((data) => ProductsData.fromJson(data)).toList();
  }


}
