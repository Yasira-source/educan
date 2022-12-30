import 'dart:convert';

import 'package:educanapp/models/sub_plans_second_model.dart';
import 'package:educanapp/utils/constants_new.dart';
import 'package:educanapp/utils/widgets/stickyLabel.dart';
import 'package:educanapp/views/notification/components/defaultAppBar.dart';
import 'package:educanapp/views/notification/components/defaultBackButton.dart';
import 'package:educanapp/views/payment_options/payment_options_2.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import 'package:http/http.dart' as http;

import '../../controller/cart_controller.dart';
import '../cart/cart_screen.dart';
import '../classes_page/classes_page.dart';
import '../payment_options/payment_options.dart';

class PackageCards extends StatefulWidget {
  PackageCards({Key? key, required this.catid, required this.title})
      : super(key: key);

  int catid;
  String title;

  @override
  _PackageCardsState createState() => _PackageCardsState();
}

class _PackageCardsState extends State<PackageCards> {
  final cartController = Get.put(CartController());
  // final ecomCartController = Get.put(EcomCartController());
  var f = NumberFormat("###,###", "en_US");

  List plans = ['Basic (Free Tier)', 'Premium (Paid Tier)'];

  @override
  void initState() {
    super.initState();

    // _loadCounterx();
    // futureAlbum = fetchSubStatus(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        elevation: 0,
        title: const Text("Subscription Packages"),
        actions: [
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
                                cartController.productsx.length ==
                            0
                        ? Container()
                        : Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                            child: Text(
                              '${cartController.products.length + cartController.productsx.length}',
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
            // const SizedBox(height: 15.0),
            // Divider(),
            const SizedBox(height: 15.0),
            const Text(
              "Select a Plan",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            //       SizedBox(height: 15.0,),
            // Divider(),

            const SizedBox(height: 30.0),

            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 5,
                // mainAxisExtent: 264,
              ),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 2,
              itemBuilder: (context, index) {
                return _buidCard(plans[index], index, context);
              },
              // ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buidCard(String name, int id, context) {
    // var f = NumberFormat("###,###", "en_US");
    return GestureDetector(
      onTap: () {
       
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ClassesPage(
                  title: widget.title,
                  catid: widget.catid,
                  package: id+1,
                )));
      },
      child: Container(
        alignment: Alignment.center,
        // height: 90,
        // width: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.7),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          // borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
    );
  }
}
