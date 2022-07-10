import 'package:educanapp/utils/defaultButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../controller/ecom_cart_controller.dart';
import '../cart/cart_screen.dart';

class SharePage extends StatefulWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  final cartController = Get.put(CartController());
  final ecomCartController = Get.put(EcomCartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        title: const Text(
          "Share Educan App",
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
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Center(
            child: Column(
              children: const [
                SizedBox(height: 60),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/ic_launcher.png"),
                  // child: Image.asset("assets/images/ic_launcher.png"), //Text
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "EDUCAN UGANDA",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
//  Divider(color: Color(0xfffc0876),),

                SizedBox(
                    width: 200,
                    child: Divider(
                      color: Color(0xfffc0876),
                    )),
                Text(
                  "REFERRAL LINK",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
            //CircleAvatar
          ),
          const SizedBox(
            height: 20,
          ),
          const Card(
            child: ListTile(
              leading: Icon(
                Icons.download,
                color: Color(0xfffc0876),
              ),
              title: Text('Available on Google Play Store'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Card(
            color: Color(0xFF1A8F00),
            child: ListTile(
              leading: Icon(
                Icons.share,
                color: Colors.white,
              ),
              title: Text(
                'Share App',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Center(
            child: Text(
                "Thank you for Supporting Us\n       Earn as you learn\n  Values Beyond School"),
          ),
        ],
      ),
    );
  }
}
