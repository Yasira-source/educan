import 'dart:convert';
import 'package:educanapp/models/all_products_model.dart';
import 'package:http/http.dart' as http;

import '../../models/bookshop_model.dart';

class SearchPageApi {

 static Future<List<BookshopData>> fetchData(String tag, String sort,String query) async {
    final response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/library/get_libarary_books_search.php?type=$tag&sortOrder=$sort&strSearch=$query'));
    // if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    // print(jsonResponse);
    return jsonResponse.map((data) => BookshopData.fromJson(data)).toList();

  }

 static Future<List<ProductsData>> fetchDataEcom( String sort,String query) async {
   final response = await http.get(Uri.parse(
       'https://educanug.com/educan_new/educan/api/library/get_ecom_products_search.php?sortOrder=$sort&strSearch=$query'));
   // if (response.statusCode == 200) {
   List jsonResponse = json.decode(response.body);
   // print(jsonResponse);
   return jsonResponse.map((data) => ProductsData.fromJson(data)).toList();

 }
}