import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/cart_controller.dart';
import '../../controller/ecom_cart_controller.dart';
import '../cart/cart_screen.dart';
import 'components/body.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static String routeName = "/profile";
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Account",
              style: TextStyle(color: Colors.white),
            ),

            Text(" Welcome $upname!",
                style: const TextStyle(
                    color: Colors.deepOrangeAccent, fontSize: 16)),
            Text(email,
                style: const TextStyle(color: Colors.white, fontSize: 12)),
            const SizedBox(
              height: 6,
            ),
          ],
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
      body: SingleChildScrollView(child: Body()),
    );
  }
}
