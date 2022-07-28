import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../controller/cart_controller.dart';
import '../../../size_config.dart';
import 'package:get/get.dart';

import 'cart_card_2.dart';
class Body2 extends StatefulWidget {
  @override
  _Body2State createState() => _Body2State();
}

class _Body2State extends State<Body2> {

  final ecomCartController = Get.put(CartController());
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
                itemCount: ecomCartController.productsx.length,
                itemBuilder: (BuildContext context, int index) {
                  return CartCard2(
                    controller: ecomCartController,
                    cart: ecomCartController.productsx.keys.toList()[index],
                    quantity: ecomCartController.productsx.values.toList()[index],
                    index: index,
                    uid: uid,
                  );
                }),

        )
      // CartCard(cart: demoCarts[index]),


    );
  }
}
