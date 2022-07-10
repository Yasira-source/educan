
import 'dart:convert';

import 'package:educanapp/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/constants_new.dart';
import '../address/address.dart';

import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  Cart({Key? key,required this.uid}) : super(key: key);
String uid;
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool _enabled = true;
  Future<List<CartData>> fetchUserCart(String tag) async {
    final response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/cart/get_user_cart.php?user=$tag'));
    // if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    // print(jsonResponse);
    return jsonResponse.map((data) => CartData.fromJson(data)).toList();
    // } else {
    //   throw Exception('Unexpected error occured!');
    // }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
      AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        elevation: 0,

        title: const Text("Your Cart"),

      ),
      bottomNavigationBar: Material(
        elevation: kLess,
        color: kWhiteColor,
        child: Row(
          children: [
            // const Expanded(
            //     child: Text("Total : UGX 975",
            //         textAlign: TextAlign.center, style: kSubTextStyle)),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: (){

              },
              child: Container(
                width: 50,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A8F00),
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(color: Colors.white),
                ),
                child: const Icon(
                  Ionicons.call,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FlatButton(
                padding: const EdgeInsets.symmetric(vertical: kLessPadding),
                color: kPrimaryColor,
                textColor: kWhiteColor,
                child: const Text("CHECKOUT (UGX 598,000)", style: TextStyle(fontSize: 16.0,fontFamily: 'Roboto',fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DeliveryAddress(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<CartData>>(
          future: fetchUserCart(widget.uid),
          builder: (context, snapshot) {
            // print(snapshot.error);
            if (snapshot.hasData) {
              List<CartData>? data = snapshot.data;
              return SizedBox(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration:
                        BoxDecoration(border: Border.all(color: kAccentColor)),
                        child: Row(
                          children: [
                            Image.network(data[index].thumbnail!,height: 110,width: 110,fit: BoxFit.cover,),
                            // Image(
                            //   image: Image.network(),
                            //   height: 110.0,
                            //   width: 110.0,
                            //   fit: BoxFit.cover,
                            // ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data[index].product_name!,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: kFixPadding)),
                                    Text(data[index].product_regular_price!,
                                        style: const TextStyle(decoration: TextDecoration.lineThrough,
                                            fontSize: 12.0, color: kLightColor)),
                                    Text("UGX ${data[index].product_sale_price.toString()}"),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        TextButton.icon(onPressed: (){

                                        },
                                            icon: const Icon(
                                              Icons.delete_outline_outlined,
                                              color: kPrimaryColor,
                                              size: 15,
                                            ),
                                            label: const Text("REMOVE",style: TextStyle(color: Color(0xFF1A8F00),fontSize: 13),)),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (int.parse(data[index].qty!) > 1) {
                                                  // int.parse(data[index].qty!)--;
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.remove_circle_outline,
                                              color: kPrimaryColor,
                                              size: 16,
                                            )),
                                        Container(
                                            width: 30.0,
                                            height: 40.0,
                                            padding: const EdgeInsets.only(top: 22.0),
                                            // color: kAccentColor,
                                            child: TextField(
                                              enabled: false,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: cartItems[index]
                                                      .quantity
                                                      .toString(),
                                                  hintStyle:
                                                  const TextStyle(color: kDarkColor)),
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                // Max 5
                                                if (cartItems[index].quantity <= 100) {
                                                  cartItems[index].quantity++;
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.add_circle_outline,
                                              color: kPrimaryColor,
                                              size: 16,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
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
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(2.0),
                                color: Colors.white),

                          ),
                        ),
                      ),
                    );
                  }
              );


            }
          }),
    );
  }
}
