import 'dart:convert';

import 'package:educanapp/utils/constants_new.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:http/http.dart' as http;

import '../../controller/cart_controller.dart';
import '../../models/library_categories.dart';
import '../cart/cart_screen.dart';
import '../library_contents_page/library_conents_page.dart';
import '../topics_page/topics_page.dart';
import 'package:get/get.dart';
class LibraryCategoriesPage2 extends StatefulWidget {
  LibraryCategoriesPage2(
      {Key? key, required this.clas, required this.subid,required this.limit,required this.plan})
      : super(key: key);

  int clas;
  String subid;
  String limit;
  int plan;

  @override
  State<LibraryCategoriesPage2> createState() => _LibraryCategoriesPage2State();
}

Future<List<LibraryCategoriesData>> fetchCategories() async {
  final response = await http.get(Uri.parse(
      'https://educanug.com/educan_new/educan/api/library/get_library_categories_2.php'));
  // if (response.statusCode == 200) {
  List jsonResponse = json.decode(response.body);
  // print(jsonResponse);
  return jsonResponse.map((data) => LibraryCategoriesData.fromJson(data)).toList();
  // } else {
  //   throw Exception('Unexpected error occured!');
  // }
}
// final orientation = MediaQuery.of(context).orientation;
class _LibraryCategoriesPage2State extends State<LibraryCategoriesPage2> {
  final cartController = Get.put(CartController());
  // final ecomCartController = Get.put(EcomCartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        elevation: 0,

        title: const Text("Resource Categories"),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Ionicons.search_outline,
          //     color: Colors.white,
          //   ),
          // ),
          Stack(
            children: [
              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CartScreen(
                    )));
              }, icon: const Icon(Icons.shopping_cart_outlined)),
              Obx(()=>
                  Positioned(
                      top: 0,
                      right: 6,

                      child:cartController.products.length+cartController.productsx.length==0?
                      Container()
                          :
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            color: Colors.red,

                            shape: BoxShape.circle),
                        child:
                        Text(
                          '${cartController.products.length+cartController.productsx.length}',
                          style: const TextStyle(fontSize: 12),
                        ),

                      )

                  ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              "Select a Resource Category of your Interest",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<List<LibraryCategoriesData>>(
              future: fetchCategories(),
              builder: (context, snapshot) {
                // print(snapshot.error);
                if (snapshot.hasData) {
                  List<LibraryCategoriesData>? data = snapshot.data;
                  return   GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: data?.length,
                    physics: const ScrollPhysics(),
                    itemBuilder: (ctx, i) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LibraryContentsPage(
                                title: data![i].title!,
                                subid: widget.subid,
                                clas: widget.clas.toString(),
                                code: data[i].code!,
                                limit:widget.limit,
                                plan:widget.plan
                              )));
                        },
                        child: Card(
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        data![i].image!,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text(
                                      data[i].title!,
                                      style: const TextStyle(
                                        fontSize: 15,

                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },




                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait) ? 2 : 3),
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait) ? 2 : 3,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 5,
                      // mainAxisExtent: 100,
                    ),
                    // ),
                  );

                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ]),
      ),
    );
  }
}
