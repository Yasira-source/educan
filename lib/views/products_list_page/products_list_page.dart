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
import '../../controller/ecom_cart_controller.dart';
import '../../models/all_products_model.dart';
import '../cart/cart_screen.dart';

class ProductsListPage extends StatefulWidget {
  BuildContext? context;

  String? tag;
  String? sort;

  ProductsListPage({Key? key, this.tag, this.sort}) : super(key: key);

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  final cartController = Get.put(CartController());
  final ecomCartController = Get.put(EcomCartController());
  Future<List<ProductsData>> fetchEcomData(String tag, String sort) async {
    final response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/products/get_category_products.php?tag=$tag&sort=$sort'));
    // if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    // print(jsonResponse);
    return jsonResponse.map((data) => ProductsData.fromJson(data)).toList();
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
        title: const Text("E-commerce"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined)),
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
                        ecomCartController.products.length ==
                        0
                        ? Container()
                        : Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Text(
                        '${cartController.products.length + ecomCartController.products.length}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildFilterWidgets(screenSize),
            _buildProductsListPage(),
          ],
        ),
      ),
    );
  }

  _buildProductsListPage() {
    return FutureBuilder<List<ProductsData>>(
        future: fetchEcomData(widget.tag!, widget.sort!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductsData>? data = snapshot.data;
            return GridView.count(
              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2),
              crossAxisCount: 2,

              padding: const EdgeInsets.all(5.0),
              mainAxisSpacing: 4.0,
              shrinkWrap: true,
              crossAxisSpacing: 4.0,

              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              children: data!.map((ProductsData item) {
                return ProductsListItem2(
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
