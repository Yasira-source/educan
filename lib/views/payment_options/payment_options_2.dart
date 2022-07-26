import 'package:educanapp/views/payment_options/payment_methods.dart';
import 'package:educanapp/views/payment_options/payment_methods_2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/cart_controller.dart';
import '../../controller/ecom_cart_controller.dart';
import '../cart/cart_screen.dart';
import 'package:get/get.dart';

import 'card_for_option.dart';

class PaymentOptions2 extends StatefulWidget {
  PaymentOptions2({Key? key,required this.amount,required this.planId
  }) : super(key: key);

  String amount;
  String planId;
  @override
  State<PaymentOptions2> createState() => _PaymentOptions2State();
}

class _PaymentOptions2State extends State<PaymentOptions2> {
  static String routeName = "/payment_options";
  String _pname = '';
  String upname = '';
  String uid = '';
  String email = '';
  final cartController = Get.put(CartController());
  final ecomCartController = Get.put(EcomCartController());
  @override
  void initState() {
    super.initState();
    _loadCounterx();
  }

  _loadCounterx() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = (prefs.getString('uid') ?? '');
      _pname = (prefs.getString('username') ?? '');
      email = (prefs.getString('email') ?? '');
      final x = _pname.split(" ");
      upname = x[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        title:
        const Text(
          "Payment Methods",
          style: TextStyle(color: Colors.white),
        ),

        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                  icon: const Icon(Icons.shopping_cart_outlined)),
              Obx(
                    () => Positioned(
                    top: 0,
                    right: 6,
                    child: cartController.products.length +
                        ecomCartController.products.length ==
                        0
                        ? Container()
                        : Container(
                      padding: EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Text(
                        '${cartController.products.length + ecomCartController.products.length}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15,),
            const Text("Select a Payment Option",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            const SizedBox(height: 20),
            OptionCard(
              text: "Flutter Wave",
              text2: "Click to Pay Using Flutterwave Method",
              icon: "assets/images/flutterwave.png",
              press: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TimePreferences2Widget(
widget.amount.toString(),widget.planId
                    ))),
              },
            ),
          ],
        ),
      ),
    );
  }
}
