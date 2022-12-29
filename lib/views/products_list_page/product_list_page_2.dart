import 'dart:convert';

import 'package:educanapp/controller/all_products_controller.dart';
import 'package:educanapp/models/bookshop_model.dart';
import 'package:educanapp/views/products_list_page/product_list_item.dart';
import 'package:educanapp/views/products_list_page/product_list_item_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../models/all_products_model.dart';
import '../cart/cart_screen.dart';
import '../home/components/search_field.dart';

class ProductsListPage2 extends StatefulWidget {
  BuildContext? context;

  String? tag;
  String? sort;

  ProductsListPage2({this.tag, this.sort});

  @override
  State<ProductsListPage2> createState() => _ProductsListPage2State();
}

class _ProductsListPage2State extends State<ProductsListPage2> {
  final cartController = Get.put(CartController());
  // final ecomCartController = Get.put(EcomCartController());
  Future<List<BookshopData>> fetchData(String tag, String sort) async {
    final response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/library/get_libarary_books.php?type=$tag&sortOrder=$sort'));
    // if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    // print(jsonResponse);
    return jsonResponse.map((data) => BookshopData.fromJson(data)).toList();
    // } else {
    //   throw Exception('Unexpected error occured!');
    // }
  }

  @override
  Widget build(BuildContext context) {
    widget.context = context;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        elevation: 0,
        title: const Text("Bookshop"),
        actions: [
          IconButton(onPressed: () {
            showSearch(context: context, delegate: EducanSearch());
          }, icon: const Icon(Icons.search_outlined)),
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                  icon: const Icon(Icons.shopping_cart_outlined)),
              Obx(
                () => Positioned(
                    top: 0,
                    right: 6,
                    child: cartController.products.length +
                        cartController.productsx.length ==
                            0
                        ? Container()
                        : Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                            child: Text(
                              '${cartController.products.length + cartController.productsx.length}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          )),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // _buildFilterWidgets(screenSize),
            const SizedBox(height: 10,),
            _buildProductsListPage(),
          ],
        ),
      ),
    );
  }

  _buildProductsListPage() {
    return FutureBuilder<List<BookshopData>>(
        future: fetchData(widget.tag!, widget.sort!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<BookshopData>? data = snapshot.data;
            return GridView.count(
              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2),
              crossAxisCount: 2,

              padding: const EdgeInsets.all(5.0),
              mainAxisSpacing: 4.0,
              shrinkWrap: true,
              crossAxisSpacing: 4.0,
childAspectRatio: 0.68,
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              children: data!.map((BookshopData item) {
                return ProductsListItem(
                  data: item,
                  code: 88,
                  added: false,
                  isFav: true,
                );
              }).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  _buildFilterWidgets(Size screenSize) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      width: screenSize.width,
      child: Card(
        elevation: 4.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildFilterButton("SORT"),
              Container(
                color: const Color(0xFF1A8F00),
                width: 2.0,
                height: 24.0,
              ),
              _buildFilterButton("FILTER"),
            ],
          ),
        ),
      ),
    );
  }

  _buildFilterButton(String title) {
    return InkWell(
      onTap: () {
        // print(title);
      },
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.arrow_drop_down,
            color: Color(0xFF1A8F00),
          ),
          const SizedBox(
            width: 2.0,
          ),
          Text(title,
              style: const TextStyle(
                color: Color(0xFF1A8F00),
              )),
        ],
      ),
    );
  }
}
