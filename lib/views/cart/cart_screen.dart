import 'package:educanapp/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import '../../controller/cart_controller.dart';
import '../../controller/ecom_cart_controller.dart';
import '../../utils/constants_new.dart';
import 'components/body.dart';
import 'components/body_2.dart';
import 'components/check_out_card.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  final cartController = Get.put(CartController());
  final ecomCartController = Get.put(EcomCartController());
  // final CartController controller = Get.find();
  var f = NumberFormat("###,###", "en_US");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: cartController.products.length == 0 &&
              ecomCartController.products.length == 0
          ? const Center(child: Text("No Items"))
          : SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "BOOKSHOP ITEMS",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                cartController.products.length > 0?
                Body()
                :
                    Container(),
                const SizedBox(
                  height: 3,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("E-COMMERCE ITEMS",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                ecomCartController.products.length> 0?
                Body2()
                    :Container(),
              ],
            )),
      bottomNavigationBar: Obx(()=>
       Material(
          elevation: kLess,
          color: kWhiteColor,
          child: cartController.products.length == 0 &&
              ecomCartController.products.length == 0 ?
          Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [

              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Container(
                    width: 50,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      // border: Border.all(color: Colors.white),
                    ),
                    child: const Icon(
                      Ionicons.call,
                      size: 30,
                      color: Color(0xFF1A8F00),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),

               Expanded(
                    child: FlatButton(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: kPrimaryColor,
                        textColor: kWhiteColor,
                        child: const Text(
                            "Continue Shopping",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold)),
                        onPressed: () => () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                        }),
                  ),
              const SizedBox(width: 10),
            ],
          )
              :
          Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              // const Expanded(
              //     child: Text("Total : UGX 975",
              //         textAlign: TextAlign.center, style: kSubTextStyle)),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Container(
                    width: 50,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset:
                          const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      // border: Border.all(color: Colors.white),
                    ),
                    child: const Icon(
                      Ionicons.call,
                      size: 30,
                      color: Color(0xFF1A8F00),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              if (cartController.products.length > 0 &&
                  ecomCartController.products.length > 0)
                Obx(
                      () => Expanded(
                    child: FlatButton(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: kPrimaryColor,
                        textColor: kWhiteColor,
                        child: Text(
                            "CHECKOUT ( UGX ${f.format(cartController.total + ecomCartController.total ?? 0)})",
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold)),
                        onPressed: () => () {}),
                  ),
                )
              else if (cartController.products.length == 0 &&
                  ecomCartController.products.length > 0)
                Obx(
                      () => Expanded(
                    child: FlatButton(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: kPrimaryColor,
                        textColor: kWhiteColor,
                        child: Text(
                            "CHECKOUT ( UGX ${f.format(ecomCartController.total ?? 0)})",
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold)),
                        onPressed: () => () {}),
                  ),
                )
              else if (ecomCartController.products.length == 0 &&
                    cartController.products.length > 0)
                  Obx(
                        () => Expanded(
                      child: FlatButton(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          color: kPrimaryColor,
                          textColor: kWhiteColor,
                          child: Text(
                              "CHECKOUT ( UGX ${f.format(cartController.total ?? 0)})",
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold)),
                          onPressed: () => () {}),
                    ),
                  )
                else
                  Expanded(
                    child: Container(),
                  ),

              const SizedBox(width: 10),
            ],
          )
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1A8F00),
      title: Obx(()=>
        Column(
          children: [
            const Text(
              "Your Cart",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "${(cartController.products.length+ecomCartController.products.length)??0} items",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
