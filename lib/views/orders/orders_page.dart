import 'dart:convert';

import 'package:educanapp/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/cart_controller.dart';
import '../../controller/ecom_cart_controller.dart';
import '../cart/cart_screen.dart';

class Buying extends StatefulWidget {
  Buying({Key? key}) : super(key: key);

  @override
  State<Buying> createState() => _BuyingState();
}

class _BuyingState extends State<Buying> {
  final cartController = Get.put(CartController());
  final ecomCartController = Get.put(EcomCartController());
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
    });
  }

  Future<List<OrdersData>> fetchOrders(String cl) async {
    final response;

    response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/user/get_orders.php?user=$cl'));

    // if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return jsonResponse.map((data) => OrdersData.fromJson(data)).toList();
    // } else {
    //   throw Exception('Unexpected error occured!');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f7f9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        elevation: 0,
        title: const Text('Orders'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Ionicons.search_outline,
              color: Colors.white,
            ),
          ),
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
        child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200]!,
                        blurRadius: 10,
                        spreadRadius: 3,
                        offset: Offset(3, 4))
                  ],
                ),
                child: FutureBuilder<List<OrdersData>>(
                    future: fetchOrders(uid),
                    builder: (context, snapshot) {
                      // print(snapshot.error);
                      if (snapshot.hasData) {
                        List<OrdersData>? data = snapshot.data;
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: data!.length,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Image.network(
                                  data[index].image!,
                                  fit: BoxFit.fitHeight,
                                  width: 90,
                                  height: 100,
                                ),
                                title: Text(
                                  data[index].name!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Order #${data[index].oid.toString()}"),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const SizedBox(width: 8),
                                        Text(
                                          data[index].status!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            background: Paint()
                                              ..color = Color(0xFF1A8F00)
                                              ..strokeWidth = 15
                                              ..style = PaintingStyle.stroke,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text("On " + data[index].date.toString()),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ])
            // .toList()),
            ),
      ),
    );
  }
}
