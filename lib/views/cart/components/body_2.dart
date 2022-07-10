import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../../controller/cart_controller.dart';
import '../../../controller/ecom_cart_controller.dart';
import '../../../size_config.dart';
import 'package:get/get.dart';

import 'cart_card_2.dart';
class Body2 extends StatefulWidget {
  @override
  _Body2State createState() => _Body2State();
}

class _Body2State extends State<Body2> {

  final ecomCartController = Get.put(EcomCartController());
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 20),
          child:
          ListView.builder(
            shrinkWrap: true,
                itemCount: ecomCartController.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return CartCard2(
                    controller: ecomCartController,
                    cart: ecomCartController.products.keys.toList()[index],
                    quantity: ecomCartController.products.values.toList()[index],
                    index: index,
                  );
                }),

        )
      // CartCard(cart: demoCarts[index]),


    );
  }
}
