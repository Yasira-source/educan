import 'package:flutter/material.dart';

import '../../controller/cart_controller.dart';
import '../../controller/ecom_cart_controller.dart';
import '../cart/cart_screen.dart';
import 'package:get/get.dart';
class HelpPage extends StatefulWidget {
  const HelpPage({ Key? key }) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final cartController = Get.put(CartController());
  final ecomCartController = Get.put(EcomCartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        title: const Text(
          "Help",
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
  const SizedBox(height: 40,),
   Center(
          child: Column(
            children:const [
              SizedBox(height: 60,),
               CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              backgroundImage: AssetImage("assets/images/ic_launcher.png"),
              // child: Image.asset("assets/images/ic_launcher.png"), //Text
            ),
            SizedBox(height: 5,),
          Text("EDUCAN UGANDA",style: TextStyle(fontSize: 20, color: Colors.black),),
 SizedBox(width: 200,child: Divider(color: Color(0xfffc0876),)),
    Text("HELP DESK",style: TextStyle(fontSize: 20, color: Colors.black),),
             ],
           ),
            //CircleAvatar
        ),
  
const SizedBox(height: 20,),
 const Card(
      child: ListTile(
        leading: Icon(Icons.call,color:Color(0xfffc0876) ,),
        title: Text('+256-757438443'),
      ),
    ),
 
 const SizedBox(height: 10,),
 const Card(
      child: ListTile(
        leading: Icon(Icons.mail,color:Color(0xfffc0876) ,),
        title: Text('info@educanug.com'),
      ),
    ),
    const SizedBox(height: 10,),
 Card(
      child: ListTile(
        leading: Image.asset("assets/images/whats.png",width: 20,height: 20,),
        title: const Text('Whatsapp - Us'),
      ),
    ),
    const SizedBox(height:15),
    const Center(
      child:Text("Thank you for Supporting Us\nWe Pledge to Continue Offering you\nthe best Education Services"),
    ),
],
      ),
    );
  }
}