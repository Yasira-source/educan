import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../controller/cart_controller.dart';
import '../../../controller/ecom_cart_controller.dart';
import '../../../size_config.dart';
import 'cart_card.dart';
import 'package:get/get.dart';
class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final cartController = Get.put(CartController());
  final ecomCartController = Get.put(EcomCartController());

  String uid = '';

  @override
  void initState() {
    super.initState();
    _loadCounterx();

  }

  _loadCounterx() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      uid = (prefs.getString('uid') ?? '');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
      Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 20),
       child:
               ListView.builder(
                 shrinkWrap: true,
                      itemCount: cartController.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CartCard(
                          controller: cartController,
                          cart: cartController.products.keys.toList()[index],
                          quantity: cartController.products.values.toList()[index],
                          index: index,
                          uid: uid,
                        );
                      }),

              )
              // CartCard(cart: demoCarts[index]),


    );
  }
}
