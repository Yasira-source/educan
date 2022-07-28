import 'dart:convert';

import 'package:educanapp/views/products_list_page/product_list_item_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../models/all_products_model.dart';
import '../cart/cart_screen.dart';
import '../product_details_page/ecom_product_details_page.dart';
import '../search_pages/api_search_page.dart';

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
  // final ecomCartController = Get.put(EcomCartController());
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
          IconButton(onPressed: () {
            showSearch(context: context, delegate: EducanSearchEcom());
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
        child: Column(
          children: [
            // _buildFilterWidgets(screenSize),
            SizedBox(height: 10,),
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

class EducanSearchEcom extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          Get.back();
        } else {
          query = '';
          showSuggestions(context);
        }
      },
    )
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => Get.back(),
  );

  @override
  Widget buildSuggestions(BuildContext context) => Container(
    color: Colors.white,
    child: FutureBuilder<List<ProductsData>>(
      future: SearchPageApi.fetchDataEcom( 'ASC', query),
      builder: (context, snapshot) {
        if (query.isEmpty) return buildNoSuggestions();

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError || snapshot.data!.isEmpty) {
              return buildNoSuggestions();
            } else {
              return buildSuggestionsSuccess(snapshot.data!);
            }
        }
      },
    ),
  );

  Widget buildNoSuggestions() => const Center(
    child: Text(
      'No suggestions!',
      style: TextStyle(fontSize: 28, color: Colors.black),
    ),
  );

  Widget buildSuggestionsSuccess(List<ProductsData> suggestions) =>
      ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          // final queryText = suggestion.substring(0, query.length);
          final queryText = suggestion.pname;
          // final remainingText = suggestion.substring(query.length);
          final remainingText = suggestion.pname;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () {
                query = suggestion.pname!;

                // 1. Show Results
                // showResults(context);

                // 2. Close Search & Return Result
                // close(context, suggestion);

                // 3. Navigate to Result Page
                //  Navigato
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => ResultPage(suggestion),
                //   ),
                // );

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EcomProductDetailsView(
                      code: 88,
                      data: suggestion,
                    )));
              },
              leading: Image.network("https://educanug.com/Educan/${suggestion.pimage1!}"),
              // title: Text(suggestion),
              title: RichText(
                text: TextSpan(
                  text: queryText,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  children: const [
                    TextSpan(
                      text: '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }
}