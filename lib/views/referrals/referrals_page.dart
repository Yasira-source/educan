import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/cart_controller.dart';
import '../../models/consultants_model.dart';
import '../../models/library_topic_items.dart';
import '../../models/referrals_model.dart';
import '../cart/cart_screen.dart';
import '../pdf_viewer_page/pdf_viewer_page.dart';
import 'package:get/get.dart';
class ReferralsPage extends StatefulWidget {
  ReferralsPage(
      {Key? key})
      : super(key: key);


  @override
  State<ReferralsPage> createState() => _ReferralsPageState();
}

Future<List<ReferralsData>> fetchReferrals(String cl) async {
  final response;

  response = await http.get(Uri.parse(
      'https://educanug.com/educan_new/educan/api/user/get_referrals.php?user=$cl'));


  // if (response.statusCode == 200) {
  List jsonResponse = json.decode(response.body);
  print(jsonResponse);
  return jsonResponse.map((data) => ReferralsData.fromJson(data)).toList();
  // } else {
  //   throw Exception('Unexpected error occured!');
  // }
}

class _ReferralsPageState extends State<ReferralsPage> {
  final cartController = Get.put(CartController());
  // final ecomCartController = Get.put(EcomCartController());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        elevation: 0,

        title: const Text('Referrals'),
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
              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CartScreen(
                    )));
              }, icon: const Icon(Icons.shopping_cart_outlined)),
              Obx(()=>
                  Positioned(
                      top: 0,
                      right: 6,

                      child:cartController.products.length+cartController.productsx.length==0?
                      Container()
                          :
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            color: Colors.red,

                            shape: BoxShape.circle),
                        child:
                        Text(
                          '${cartController.products.length+cartController.productsx.length}',
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
        scrollDirection: Axis.vertical,
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),

          FutureBuilder<List<ReferralsData>>(
              future: fetchReferrals(uid),
              builder: (context, snapshot) {
                // print(snapshot.error);
                if (snapshot.hasData) {
                  List<ReferralsData>? data = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: data!.length,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                          elevation: 1,
                          margin: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: ListTile(
                            leading: ClipOval(
                              child: Image.asset(
                                  "assets/images/dp.png"),
                            ),
                            dense: true,

                            title: Text(

                              data[index].fname!,
                              style: const TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            // trailing: const Icon(
                            //   Icons.arrow_forward_ios,
                            //   size: 15,
                            //   color: Color(0xFF1A8F00),
                            // ),
                            subtitle:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(data[index].phone!,

                                      style: const TextStyle(
                                          fontSize: 14.0, fontWeight: FontWeight.normal)),

                                ]),
                            onTap: () {

                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => PDFDoc(
                              //
                              //       link: data[index].link!,
                              //       title: data[index].title!,
                              //
                              //
                              //     )));

                            },
                          ));
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ]),
      ),
    );
  }

}
