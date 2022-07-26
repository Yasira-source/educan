import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../controller/ecom_cart_controller.dart';
import '../../controller/flutterwave_payments_controller.dart';
import '../../models/all_products_model.dart';
import '../../models/bookshop_model.dart';
import '../../utils/keyboard.dart';
import '../success/success.dart';

class CashOnDelivery extends StatefulWidget {
  CashOnDelivery(this.amount, this.pm,this.pmt,{Key? key}) : super(key: key);
  String amount;
  String pm;
  String pmt;
  @override
  CashOnDeliveryState createState() => CashOnDeliveryState();
}

class CashOnDeliveryState extends State<CashOnDelivery> {
  var f = NumberFormat("###,###", "en_US");

  var result;


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final controller = FlutterWavePaymentsController();
  final cartController = Get.put(CartController());
  final ecomCartController = Get.put(EcomCartController());
  String email = '';
  String uid = '';
  @override
  void initState() {
    super.initState();
    _loadCounterx();

  }

  _loadCounterx() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = (prefs.getString('email') ?? '');
      uid = (prefs.getString('uid') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        title: const Text("Cash On Delivery"),
      ),
      body: ListView(
        shrinkWrap: true,
        // scrollDirection: Axis.vertical,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Kindly Confirm the Total Cost and Submit your Order"),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF1A8F00))),
                onPressed: () async {
                  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                  Random _rnd = Random();

                  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
                      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

                  var rcode =getRandomString(15);
                     result = await controller.createOrder(uid,widget.pm,widget.pmt,0,rcode,widget.amount);

                  Get.to(Success(
                          sub: "Your Order has been made Successfully!",
                        ));

                  // }
                },
                child: Text(
                  ' CONFIRM ORDER NOW: UGX ${f.format(double.parse(widget.amount))}  ',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Failed!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Kindly try again '),
                Text('with the right details'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
