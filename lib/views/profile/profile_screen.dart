
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/cart_controller.dart';
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
  String pic = '';
  String pass = '';
  final cartController = Get.put(CartController());
  // final ecomCartController = Get.put(EcomCartController());
  @override
  void initState() {
    super.initState();
    _loadCounterx();
  }

  _loadCounterx() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = (prefs.getString('uid') ?? '');
       pic = (prefs.getString('pic') ?? '');
      _pname = (prefs.getString('username') ?? '');
      email = (prefs.getString('email') ?? '');
      pass = (prefs.getString('pass') ?? '');
      final x = _pname.split(" ");
      upname = x[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFeff5f3),
      appBar: AppBar(
        automaticallyImplyLeading: false,
         elevation: 0,
        backgroundColor: const Color(0xFF1A8F00),
        title:  const Text(
          "Account",
          style: TextStyle(color: Colors.white),
        ),
        
         
        actions: [
      // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
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
                child: cartController.products.length <= 0
                    ? Container()
                    : Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        child: Text(
                          '${cartController.products.length}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      )),
          ),
        ],
      )
        ],
      ),
      
      
      
      body: SingleChildScrollView(child: Body(uid: uid,pic: pic,upname: upname,email: email,pass: pass,),)
    );
  }
}
