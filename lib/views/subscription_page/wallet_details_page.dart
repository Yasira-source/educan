import 'dart:convert';

import 'package:educanapp/models/sub_plans.dart';
import 'package:educanapp/utils/constants_new.dart';
import 'package:educanapp/views/profile/components/daily_page.dart';
import 'package:educanapp/views/profile/components/wallet_desc.dart';
import 'package:educanapp/views/subscription_page/enter_topup_amount.dart';
import 'package:educanapp/views/subscription_page/subscription_page_second.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/cart_controller.dart';
import '../../models/sub_status_model.dart';
import '../cart/cart_screen.dart';

import 'package:http/http.dart' as http;

import '../profile/components/latest_transactions.dart';

class SubscriptionDetails2 extends StatefulWidget {
  const SubscriptionDetails2({Key? key}) : super(key: key);

  @override
  _SubscriptionDetails2State createState() => _SubscriptionDetails2State();
}

class _SubscriptionDetails2State extends State<SubscriptionDetails2> {
  String _pname = '';
  String upname = '';
  String uid = '';

  List balance = [];
  void secureScreen() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    await FlutterWindowManager.clearFlags(
        FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_FULLSCREEN);
  }

  @override
  void initState() {
       _loadCounter();
    super.initState();
   
    secureScreen();
  
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = (prefs.getString('uid') ?? '');
      // fetchSubStatus(uid);
    });
  }

  final cartController = Get.put(CartController());
  // final ecomCartController = Get.put(EcomCartController());

  Future<String> fetchSubStatus(String tag) async {
    var res = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/user/get_wallet_balance.php?user=$tag'));
    var resBody = json.decode(res.body);
     setState(() {
      balance = resBody;
    
    });
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 247, 225),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        elevation: 0,
        title: const Text("Wallet Details"),
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
            const SizedBox(
              height: 15,
            ),
            FutureBuilder<String>(
                future: fetchSubStatus(uid),
                builder: (context, snapshot) {
                  // print(snapshot.error);
                  if (snapshot.hasData) {
                    // List<SubStatusData>? data = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 235,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            Container(
                              height: 112,
                              decoration: const BoxDecoration(
                                  color: Color(0xFF1A8F00),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'My Wallet',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.info,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          onPressed: () {
                                            Get.to(WalletDescPage());
                                          },
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'UGX  ',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                         Text(
                                          balance[0]['balance'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.add_circle_outline_rounded,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          onPressed: () {
                                            Get.to(EnterDonationAmount2(
                                              id: '1',
                                            ));
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/1017280091582962144.svg',
                                        color: const Color(0xFF02182e),
                                        width: 22,
                                      ),
                                      const Text(
                                        'Send Money',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/1017280091582962144.svg',
                                        color: const Color(0xFF02182e),
                                        width: 22,
                                      ),
                                      const Text('Withdraw',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => DailyPage());
                                    },
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/1017280091582962144.svg',
                                          color: const Color(0xFF02182e),
                                          width: 22,
                                        ),
                                        const Text('Transactions',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/1017280091582962144.svg',
                                        color: const Color(0xFF02182e),
                                        width: 22,
                                      ),
                                      const Text('Pay',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 30,
                              width: MediaQuery.of(context).size.width - 30,
                              child: InkWell(
                                onTap: () {
                                  //  cartController.addProduct(data);
                                  Get.to(EnterDonationAmount2(
                                    id: '1',
                                  ));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A8F00),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/1017280091582962144.svg',
                                        color: Colors.white,
                                        width: 22,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'DEPOSIT MONEY',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            const SizedBox(height: 15.0),
            const Divider(),
            const SizedBox(height: 15.0),
            uid != '' ? LatestTransactions(uid) : Container(),
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
