import 'dart:convert';

import 'package:awesome_card/awesome_card.dart';
import 'package:educanapp/models/sub_plans_second_model.dart';
import 'package:educanapp/utils/constants_new.dart';
import 'package:educanapp/utils/widgets/stickyLabel.dart';
import 'package:educanapp/views/notification/components/defaultAppBar.dart';
import 'package:educanapp/views/notification/components/defaultBackButton.dart';
import 'package:educanapp/views/payment_options/payment_options_2.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import 'package:http/http.dart' as http;

import '../../controller/cart_controller.dart';
import '../../controller/ecom_cart_controller.dart';
import '../cart/cart_screen.dart';
import '../payment_options/payment_options.dart';
class SubscriptionSecond extends StatefulWidget {
  SubscriptionSecond({Key? key,required this.code,required this.name}) : super(key: key);

  int code;
  String name;
  @override
  _SubscriptionSecondState createState() => _SubscriptionSecondState();
}

class _SubscriptionSecondState extends State<SubscriptionSecond> {
  final cartController = Get.put(CartController());
  final ecomCartController = Get.put(EcomCartController());
  var f = NumberFormat("###,###", "en_US");

  Future<List<SubData>> fetchPlans(String tag) async {
    final response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/library/get_plans_second.php?access=$tag'));
    // if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    // print(jsonResponse);
    return jsonResponse.map((data) => SubData.fromJson(data)).toList();
    // } else {
    //   throw Exception('Unexpected error occured!');
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        elevation: 0,
      
        title: const Text("Subscription"),
        actions: [

          Stack(
            children: [
              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CartScreen(
                    )));
              }, icon: const Icon(Icons.shopping_cart_outlined)),
              Obx(()=>
                  Positioned(
                      top: 0,
                      right: 6,

                      child:cartController.products.length+ecomCartController.products.length==0?
                      Container()
                          :
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            color: Colors.red,

                            shape: BoxShape.circle),
                        child:
                        Text(
                          '${cartController.products.length+ecomCartController.products.length}',
                          style: const TextStyle(fontSize: 12),
                        ),

                      )

                  ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          
            const SizedBox(height: 15.0),
            // Divider(),
            // SizedBox(height: 15.0),
             Text(
                    "${widget.name} Plans",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
            //       SizedBox(height: 15.0,),
            // Divider(),

            const SizedBox(height: 15.0),

        FutureBuilder<List<SubData>>(
            future: fetchPlans(widget.code.toString()),
            builder: (context, snapshot) {
              // print(snapshot.error);
              if (snapshot.hasData) {
                List<SubData>? data = snapshot.data;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 5,
                    // mainAxisExtent: 264,
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return _buidCard(
                        data[index],

                        context);

                  },
                  // ),
                );
              } else {
                return const Center(child: CircularProgressIndicator(),);


              }
            }),

          ],
        ),
      ),
    );
  }

  Widget _buidCard(SubData x,context){
    // var f = NumberFormat("###,###", "en_US");
    return  GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PaymentOptions2(
amount: x.amount.toString(),
              planId: x.id.toString(),
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
        child:  Text(
          "${x.name}\nUGX ${f.format(int.parse(x.amount!))}",
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
    );
  }
}
