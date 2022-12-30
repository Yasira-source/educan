// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:educanapp/views/product_details_page/product_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/cart_controller.dart';
import '../../models/all_products_model.dart';
import '../../models/bookshop_model.dart';
import '../../utils/constants.dart';

import 'package:http/http.dart' as http;

import '../cart/cart_screen.dart';
class EcomProductDetailsView extends StatelessWidget {
  EcomProductDetailsView(
      {Key? key,
        required this.code,
        required this.data

      })
      : super(key: key);

  int code;
  ProductsData data;

  bool _enabled = true;
  var f = NumberFormat("###,###", "en_US");

  // final ecomCartController = Get.put(EcomCartController());
  final cartController = Get.put(CartController());
  // final int index;

  Future<List<ProductsData>> fetchRelatedEcom(String tag, String sort) async {
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

                      child:cartController.products.length+cartController.productsx.length==0?
                      Container()
                          :
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.red,

                            shape: BoxShape.circle),
                        child:
                        Text(
                          '${cartController.products.length+cartController.productsx.length}',
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
            // height: MediaQuery.of(context).size.height * .35,
            padding: const EdgeInsets.only(bottom: 30, top: 20),
            width: double.infinity,
            child:ProductCarouselSlider(
              img1: data.pimage1!,
              img2: data.pimage2!,
              img3: data.pimage3!,
            ),
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
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      (((int.parse(data.prprice!) - data.pprice!) /
                                          int.parse(data.prprice!)) *
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
                                            "-${(((int.parse(data.prprice!) - data.pprice!) / int.parse(data.prprice!)) * 100).round()}%",
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
                                    SizedBox(width: 5,),
                                  data.pavailability=='1'?  Text('In Stock (${data.qty})',style: TextStyle(color: Colors.black),):Text('Out of Stock',style: TextStyle(color: Colors.red),),
                      
                          ],
                        ),
                        // Row(
                        //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        Text(
                          data.pname!,
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
                              'UGX ${f.format(data.pprice!)}',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),
                        Text(
                          data.pdesc!,
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
                          FutureBuilder<List<ProductsData>>(
                              future: fetchRelatedEcom(code.toString(), "DESC"),
                              builder: (context, snapshot) {
                                // print(snapshot.error);
                                if (snapshot.hasData) {
                                  List<ProductsData>? data = snapshot.data;
                                  return SizedBox(
                                    height: 310,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: data!.length,
                                      itemBuilder: (context, index) {
                                        return int.parse(data[index].pid!) == 0
                                            ?
                                        SizedBox(
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
                                        )
                                            : _buildCard(
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
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: '+256789684676',
                );
                launchUrl(launchUri);
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
                  cartController.addProductx(data);

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
                  // Obx(
                  //   () => productController.isAddLoading.value
                  //       ? SizedBox(
                  //           width: 20,
                  //           height: 20,
                  //           child: CircularProgressIndicator(
                  //             color: Colors.white,
                  //             strokeWidth: 3,
                  //           ),
                  //         )
                  //       :

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(ProductsData data,int code, bool added, bool isFavorite, context) {
    return Padding(
        padding:
        const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EcomProductDetailsView(code: code, data: data)

                  ));


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


                      Stack(

                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Hero(
                                tag: "https://educanug.com/Educan/${data.pimage1!}",
                                child: Container(
                                    height: 200.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage("https://educanug.com/Educan/${data.pimage1!}"),
                                            fit: BoxFit.fitWidth)))),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    (((int.parse(data.prprice!) - data.pprice!) /
                                        int.parse(data.prprice!)) *
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
                                          "-${(((int.parse(data.prprice!) - data.pprice!) / int.parse(data.prprice!)) * 100).round()}%",
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
                        child: Text(data.pname!,
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
                        child: Text('UGX ${f.format(data.pprice!)}',
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
                        child: Text('UGX ${f.format(int.parse(data.prprice!))}',
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
