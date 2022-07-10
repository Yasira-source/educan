import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/bookshop_model.dart';
import '../product_details_page/product_details_page.dart';

class ProductsListItem extends StatelessWidget {
  BookshopData data;
  int code;
  bool added;
  bool isFav;
  ProductsListItem(
      {Key? key,
      required this.data,
      required this.code,
      required this.added,
      required this.isFav})
      : super(key: key);
  var f = NumberFormat("###,###", "en_US");
  @override
  Widget build(BuildContext context) {
    return _buildCardx(data, code, added, isFav, context);
    //     _buildProductItemCard(context),
    //   ],
    // );
  }

  Widget _buildCardx(
      BookshopData data, int code, bool added, bool isFavorite, context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetailsView(
                        code: code,
                        data: data,
                      )));
            },
            child: Container(
                // width: 160,
                // height: 800,
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
                                tag:
                                    "https://educanug.com/Educan/${data.filelogo!}",
                                child: Container(
                                    height: 100.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://educanug.com/Educan/${data.filelogo!}"),
                                            fit: BoxFit.fitHeight)))),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    (((int.parse(data.regularPrice!) -
                                                            data.price!) /
                                                        int.parse(data
                                                            .regularPrice!)) *
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

                      const SizedBox(height: 8.0),
                      LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 2, right: 2),
                              child: Text(data.title!,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      // fontFamily: 'Varela',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15.0)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 2, right: 2),
                              child: Text('UGX ${f.format(data.price!)}',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      // fontFamily: 'Varela',
                                      fontSize: 15.0)),
                            ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(left: 2, right: 2),
                            //   child: Text(
                            //       'UGX ${f.format(int.parse(data.regularPrice!))}',
                            //       textAlign: TextAlign.start,
                            //       overflow: TextOverflow.ellipsis,
                            //       style: const TextStyle(
                            //           color: Colors.grey,
                            //           fontWeight: FontWeight.bold,
                            //           // fontFamily: 'Varela',
                            //           decoration: TextDecoration.lineThrough,
                            //           fontSize: 13.0)),
                            // ),
                          ],
                        );
                      }),
                    ]))));
  }
  // _buildProductItemCard(BuildContext context) {
  //   return Padding(
  //       padding:
  //       const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
  //     child: InkWell(
  //       onTap: () {
  //         // Navigator.of(context).pushNamed("/ProductsList");
  //       },
  //       child: Card(
  //         elevation: 4.0,
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             SizedBox(
  //               height: 250.0,
  //               width: MediaQuery.of(context).size.width / 2.2,
  //               child: Image.network(
  //                 imageUrl,
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 8.0,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(
  //                 left: 8.0,
  //               ),
  //               child: SizedBox(
  //                 width: MediaQuery.of(context).size.width / 2.2,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: <Widget>[
  //                     Text(
  //                       name,
  //                       overflow: TextOverflow.ellipsis,
  //                       maxLines: 2,
  //                       style: const TextStyle(fontSize: 16.0, color: Colors.grey),
  //                     ),
  //                     const SizedBox(
  //                       height: 2.0,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: <Widget>[
  //                         Text(
  //                           "UGX $currentPrice",
  //                           style: const TextStyle(fontSize: 16.0, color: Colors.black),
  //                         ),
  //                         const SizedBox(
  //                           width: 8.0,
  //                         ),
  //                         Text(
  //                           "UGX $originalPrice",
  //                           style: const TextStyle(
  //                             fontSize: 12.0,
  //                             color: Colors.grey,
  //                             decoration: TextDecoration.lineThrough,
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           width: 8.0,
  //                         ),
  //                         Text(
  //                           "$discount\% off",
  //                           style: const TextStyle(fontSize: 12.0, color: Colors.grey),
  //                         ),
  //                       ],
  //                     ),
  //                     const SizedBox(
  //                       height: 8.0,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
