import 'dart:convert';

import 'package:awesome_card/awesome_card.dart';
import 'package:educanapp/models/sub_plans.dart';
import 'package:educanapp/utils/constants_new.dart';
import 'package:educanapp/views/subscription_page/subscription_page_second.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/cart_controller.dart';
import '../../controller/ecom_cart_controller.dart';
import '../../models/sub_status_model.dart';
import '../cart/cart_screen.dart';

import 'package:http/http.dart' as http;

class SubscriptionDetails extends StatefulWidget {
  const SubscriptionDetails({Key? key}) : super(key: key);

  @override
  _SubscriptionDetailsState createState() => _SubscriptionDetailsState();
}

class _SubscriptionDetailsState extends State<SubscriptionDetails> {
  String _pname = '';
  String upname = '';
  String uid = '';

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = (prefs.getString('uid') ?? '');
      _pname = (prefs.getString('username') ?? '');
      final x = _pname.split(" ");
      upname = x[0];
    });
  }

  final cartController = Get.put(CartController());
  final ecomCartController = Get.put(EcomCartController());

  String cardNumber = "5450 7879 4864 7854",
      cardExpiry = "10/25",
      cardHolderName = "John Travolta",
      bankName = "Educan Virtual Card",
      cvv = "456";

  Future<List<SubStatusData>> fetchSubStatus(String tag) async {
    final response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/library/get_status.php?user=$tag'));
    // if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    // print(jsonResponse);
    return jsonResponse.map((data) => SubStatusData.fromJson(data)).toList();
    // } else {
    //   throw Exception('Unexpected error occured!');
    // }
  }

  static const List<SubPlans> plans = [
    SubPlans(
      name: 'Primary',
      code: 3,
    ),
    SubPlans(
      name: 'Secondary',
      code: 2,
    ),
    SubPlans(
      name: 'Both Levels',
      code: 1,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        elevation: 0,
        title: const Text("Subscription Details"),
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
                                ecomCartController.products.length ==
                            0
                        ? Container()
                        : Container(
                            padding: const EdgeInsets.all(4),
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
            const SizedBox(
              height: 15,
            ),
            FutureBuilder<List<SubStatusData>>(
                future: fetchSubStatus(uid),
                builder: (context, snapshot) {
                  // print(snapshot.error);
                  if (snapshot.hasData) {
                    List<SubStatusData>? data = snapshot.data;
                    return CreditCard(
                      cardNumber: '${data![0].plan} -  ${data![0].planLevel}',
                      cardExpiry: data![0].end,
                      cardHolderName:
                          '${data![0].left} left ( ${data![0].status == 'F' ? 'Expired' : 'Active'} )',
                      bankName: _pname,
                      cvv: cvv,
                      // showBackSide: true,
                      frontBackground: CardBackgrounds.custom(0xFF1A8F00),
                      backBackground: CardBackgrounds.white,
                      cardType: CardType.other,
                      showShadow: true,
                    );
                  } else {
                    return CreditCard(
                      cardNumber: '-',
                      cardExpiry: '-',
                      cardHolderName: '-',
                      bankName: _pname,
                      cvv: '-',
                      // showBackSide: true,
                      frontBackground: CardBackgrounds.custom(0xFF1A8F00),
                      backBackground: CardBackgrounds.white,
                      cardType: CardType.other,
                      showShadow: true,
                    );
                  }
                }),
            const SizedBox(height: 15.0),
            const Divider(),
            const SizedBox(height: 15.0),
            const Text(
              "Subscription Plans",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Divider(),
            const SizedBox(height: 15.0),
            Center(
              child: GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                itemCount: 3,
                itemBuilder: (ctx, i) {
                  return SizedBox(height:20,child: _buildCard(plans[i]));
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 5,
                  // mainAxisExtent: 264,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(SubPlans x) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SubscriptionSecond(
                  code: x.code,
                  name: x.name,
                )));
      },
      child: Card(
        child: Center(
          child: Container(
            height: 20,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            // margin: const EdgeInsets.all(5),
            // padding: const EdgeInsets.all(5),
            child: Text(
              x.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
