import 'package:educanapp/models/all_products_model.dart';
import 'package:educanapp/views/product_details_page/ecom_product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/cart_controller.dart';
import '../../models/bookshop_model.dart';
import '../product_details_page/product_details_page.dart';

class ProductsListItem2 extends StatelessWidget {
  ProductsData data;
  int code;
  bool added;
  bool isFav;
  ProductsListItem2(
      {Key? key,
        required this.data,
        required this.code,
        required this.added,
        required this.isFav})
      : super(key: key);
  var f = NumberFormat("###,###", "en_US");
    final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return  Obx(
                    () => _buildCardy(data, code, added, isFav, context));
    //     _buildProductItemCard(context),
    //   ],
    // );
  }


 Widget _buildCardy(ProductsData data,int code, bool added, bool isFavorite, context) {
    return Padding(
        padding:
        const EdgeInsets.only(top: 5.0, bottom: .0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EcomProductDetailsView(
                    code:code,
                    data: data,
                  )));


            },
            child: Container(
                width: 160,
                // height: 900,
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
                                    height: 150.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage("https://educanug.com/Educan/${data.pimage1!}"),
                                            fit: BoxFit.fitHeight)))),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    (((int.parse(data.pprice!.toString()) - int.parse(data.prprice!)) /
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
                                          color: const Color.fromARGB(255, 190, 241, 178).withOpacity(0.4)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          "-${(((int.parse(data.prprice!) - data.pprice!) / int.parse(data.prprice!)) * 100).round()}%",
                                          style: const TextStyle(
                                              color: Color(0xFF1A8F00),
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
                         Container(
                              alignment: Alignment.center,
                            
                                            height: 15,
                                            width: 65,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2.0),
                                                color:  const Color.fromARGB(255, 18, 55, 85)),
                                            child:   const Text(
                                              //  textAlign: TextAlign.center,
                                              "Official Store",
                                              style: TextStyle(fontSize: 10,
                                                  color: Colors.white,
                                                      fontWeight: FontWeight.bold),
                                            ),
                                          ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 2, right: 2),
                              child: Text(data.pname!,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style:  const TextStyle(
                                      // color: Colors.black,
                          
                                      // fontWeight: FontWeight.w100,
                                      fontSize: 15.0),
              
                                  ),
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
                                fontSize: 12.0)),
                      ),
                    
                      Padding(
                              padding:
                                  const EdgeInsets.only(left: 2, right: 2),
                              child: Text(
                                  'UGX ${f.format(int.parse(data.prprice!))}',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      // fontFamily: 'Varela',
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 13.0)),
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: RatingBar.builder(
                          initialRating: double.parse(data.prating!),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            // print(rating);
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                     cartController.checkProductExistsx(data)?
                        SizedBox(
                          height: 30,
                          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                IconButton(
                    onPressed: () {
                      cartController.removeProductx(data);
                    },
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Color(0xFF1A8F00),
                      // size: 20,
                    )),
                Container(
                    width: 30.0,
                    // height: 35.0,
                    padding: const EdgeInsets.only(top: 15.0),
                    // color: kAccentColor,
                    child: TextField(
                      enabled: false,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: cartController.checkProductTotalx(data),
                            hintStyle:
                            const TextStyle(color: Colors.black)),
                    )),

                IconButton(
                    onPressed: () {
                      cartController.addProductx(data);
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: Color(0xFF1A8F00),
                      // size: 20,
                    )),
              ],

            ),
                        )
        
                     :
                        SizedBox(
                          height: 30,
                          child: InkWell(
                            onTap: () {
                               cartController.addProductx(data);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A8F00),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: const Text(
                                'ADD TO CART',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                
                    ]))));
  }
 


  Widget _buildCardx(
      ProductsData data, int code, bool added, bool isFavorite, context) {
    return Padding(
        padding:
        const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EcomProductDetailsView(
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
                                "https://educanug.com/Educan/${data.pimage1!}",
                                child: Container(
                                    height: 100.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://educanug.com/Educan/${data.pimage1!}"),
                                            fit: BoxFit.fitHeight)))),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    (((int.parse(data.prprice!) -
                                        data.pprice!) /
                                        int.parse(data
                                            .prprice!)) *
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

                      const SizedBox(height: 8.0),
                      LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 2, right: 2),
                              child: Text(data.pname!,
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
                              child: Text('UGX ${f.format(data.pprice!)}',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      // fontFamily: 'Varela',
                                      fontSize: 15.0)),
                            ),
                           
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
