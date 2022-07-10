import 'dart:convert';

import 'package:educanapp/models/all_stores_model.dart';
import 'package:educanapp/models/bookshop_model.dart';
import 'package:educanapp/views/product_details_page/product_details_page.dart';
import 'package:educanapp/views/products_list_page/products_list_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../models/all_products_model.dart';
import '../../product_details_page/ecom_product_details_page.dart';
import '../../products_list_page/product_list_page_2.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  String header;
  int code;
  String tag;
  String sort;
  bool _enabled = true;
  //  VoidCallback press;
  Color x;
  PopularProducts(this.header, this.code, this.x, this.tag, this.sort);

  var f = NumberFormat("###,###", "en_US");

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

  Future<List<ProductsData>> fetchEcom(String tag, String sort) async {
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

  Future<List<StoresData>> fetchStores() async {
    final response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/library/get_stores.php'));
    // if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    // print(jsonResponse);
    return jsonResponse.map((data) => StoresData.fromJson(data)).toList();
    // } else {
    //   throw Exception('Unexpected error occured!');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SectionTitle(
              title: header,
              press: () {
                if (code == 0088) {
                  Get.to(() => ProductsListPage2(
                        tag: "Book",
                        sort: "DESC",
                      ));
                } else {
                  Get.to(() => ProductsListPage(
                        tag: code.toString(),
                        sort: "DESC",
                      ));
                }
              },
              x: x),
        ),
        const SizedBox(height: 5),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              (code == 0088 || code == 00)
                  ? (code == 00)
                      ? FutureBuilder<List<StoresData>>(
                          future: fetchStores(),
                          builder: (context, snapshot) {
                            // print(snapshot.error);
                            if (snapshot.hasData) {
                              List<StoresData>? data = snapshot.data;
                              return SizedBox(
                                height: 50,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data!.length,
                                  itemBuilder: (context, index) {
                                    return _buildCard2(
                                        data[index].id!,
                                        "https://educanug.com/Educan/${data[index].image!}",
                                        false,
                                        false,
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
                          })
                      : FutureBuilder<List<BookshopData>>(
                          future: fetchData(tag, sort),
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
                                      88,

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
                          })
                  : FutureBuilder<List<ProductsData>>(
                      future: fetchEcom(code.toString(), "DESC"),
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

              const SizedBox(width: 5),
            ],
          ),
        ),
      ],
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
                      // SizedBox(height:10),

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
  Widget _buildCard2(
      String id, String imgPath, bool added, bool isFavorite, context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {

            },
            child: Container(
                width: 160,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0),
                    color: Colors.white),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height:10),

                      Stack(

                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Hero(
                                tag: imgPath,
                                child: Container(
                                    height: 50.0,
                                    width: 160.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            scale: 0.5,
                                            image: NetworkImage(imgPath),fit: BoxFit.fill
                                            )))),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15.0),
                    ]))));
  }

}
