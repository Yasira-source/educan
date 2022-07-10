// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:educanapp/controller/ecom_cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

import '../../controller/cart_controller.dart';
import '../../models/all_products_model.dart';
import '../../models/bookshop_model.dart';
import '../../utils/constants.dart';

import 'package:http/http.dart' as http;

import '../cart/cart_screen.dart';
class ProductDetailsView extends StatelessWidget {
  ProductDetailsView(
      {Key? key,
        required this.code,
        required this.data

     })
      : super(key: key);

int code;
BookshopData data;

  bool _enabled = true;
  var f = NumberFormat("###,###", "en_US");

 final cartController = Get.put(CartController());
  final ecomCartController = Get.put(EcomCartController());
  // final int index;
  Future<List<BookshopData>> fetchRelated(String tag, String sort) async {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF1A8F00),
        elevation: 0,

        title: Text("Product Details"),
        actions: [

        Stack(
          children: [
            IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CartScreen(
                  )));
            }, icon: Icon(Icons.shopping_cart_outlined)),
            Obx(()=>
            Positioned(
                  top: 0,
                  right: 6,

                  child:cartController.products.length+ecomCartController.products.length==0?
                      Container()
                  :
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.red,

                    shape: BoxShape.circle),
                    child:
                       Text(
                        '${cartController.products.length+ecomCartController.products.length}',
                        style: TextStyle(fontSize: 12),
                      ),

                  )

              ),
            ),
          ],
        )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
            padding: const EdgeInsets.only(bottom: 30, top: 20),
            width: double.infinity,
            child: Image.network("https://educanug.com/Educan/${data.filelogo!}"),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40, right: 14, left: 14),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(


                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  (((int.parse(data.regularPrice!) - data.price!) /
                                                      int.parse(data.regularPrice!)) *
                                                  100)
                                              .round() >
                                          0
                                      ? Container(
                                          height: 30,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2.0),
                                              color: const Color(0xFF1A8F00)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              "-${(((int.parse(data.regularPrice!) - data.price!) / int.parse(data.regularPrice!)) * 100).round()}%",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(
                                          height: 5,
                                          width: 5,
                                        )
                                ])),
                        // Row(
                        //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                            Text(
                              data.title!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "By Educan Shop",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'UGX ${f.format(data.price!)}',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),
                        Text(
                          data.detail!,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Related Items',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 320,
                          child:
                          FutureBuilder<List<BookshopData>>(
                              future: fetchRelated("Book", "ASC"),
                              builder: (context, snapshot) {
                                // print(snapshot.error);
                                if (snapshot.hasData) {
                                  List<BookshopData>? data = snapshot.data;
                                  return SizedBox(
                                    height: 310,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: data!.length,
                                      itemBuilder: (context, index) {
                                        return _buildCardx(
                                          data[index],
                                          code,

                                            false,
                                            true,
                                            context);

                                        // return _buildCard("Biological Science", "UGX 1000,000",
                                        // "assets/images/bk2.jpg", false, true, context);
                                      },
                                      // ),
                                    ),
                                  );
                                } else {
                                  return SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 4,
                                        itemBuilder: (context, index) {
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey,
                                            highlightColor: const Color(0xFFF5F5F5),
                                            enabled: _enabled,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0,
                                                  bottom: 5.0,
                                                  left: 5.0,
                                                  right: 5.0
                                              ),
                                              child: InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  width: 160,
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(2.0),
                                                      color: Colors.white),

                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  );


                                }
                              }),

                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: kGreyColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){

              },
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFF1A8F00),
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(color: Colors.white),
                ),
                child: Icon(
                  Ionicons.call,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () {
                  cartController.addProduct(data);

                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFF1A8F00),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '+ Add to Cart',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),


                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardx(BookshopData data,int code, bool added, bool isFavorite, context) {
    return Padding(
        padding:
        const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetailsView(
                    code:code,
                    data: data,
                  )));


            },
            child: Container(
                width: 160,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0),

                    color: Colors.white),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height:10),

                      Stack(
                        // alignment: AlignmentDirectional.topStart,
                        // fit: StackFit.loose,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Hero(
                                tag: "https://educanug.com/Educan/${data.filelogo!}",
                                child: Container(
                                    height: 200.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage("https://educanug.com/Educan/${data.filelogo!}"),
                                            fit: BoxFit.fitHeight)))),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    (((int.parse(data.regularPrice!) - data.price!) /
                                        int.parse(data.regularPrice!)) *
                                        100)
                                        .round() >
                                        0
                                        ? Container(
                                      height: 30,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(2.0),
                                          color: const Color(0xFF1A8F00)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          "-${(((int.parse(data.regularPrice!) - data.price!) / int.parse(data.regularPrice!)) * 100).round()}%",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ),
                                    )
                                        : const SizedBox(
                                      height: 5,
                                      width: 5,
                                    )
                                  ])),
                        ],
                      ),

                      const SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Text(data.title!,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.black,
                                // fontFamily: 'Varela',
                                fontWeight: FontWeight.normal,
                                fontSize: 15.0)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Text('UGX ${f.format(data.price!)}',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                // fontFamily: 'Varela',
                                fontSize: 15.0)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Text('UGX ${f.format(int.parse(data.regularPrice!))}',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                // fontFamily: 'Varela',
                                decoration: TextDecoration.lineThrough,
                                fontSize: 13.0)),
                      ),
                    ]))));
  }
}
