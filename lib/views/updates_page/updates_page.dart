import 'dart:convert';

import 'package:educanapp/views/consult/consultants.dart';
import 'package:educanapp/views/library_categories_page/library_categories_page.dart';
import 'package:educanapp/views/scholarship_page/scholarship_details_page.dart';
import 'package:educanapp/views/subscription_page/subscription_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../controller/cart_controller.dart';
import '../../controller/ecom_cart_controller.dart';
import '../../models/scholarships_model.dart';
import '../cart/cart_screen.dart';
import '../topics_page/topics_page.dart';

class UpdatesPage extends StatefulWidget {
  UpdatesPage(
      {Key? key})
      : super(key: key);


  @override
  State<UpdatesPage> createState() => _UpdatesPageState();
}

Future<List<ScholarshipData>> fetchScholarships() async {
  final response = await http.get(Uri.parse(
      'https://educanug.com/educan_new/educan/api/library/get_schools.php'));
  // if (response.statusCode == 200) {
  List jsonResponse = json.decode(response.body);
  print(jsonResponse);
  return jsonResponse.map((data) => ScholarshipData.fromJson(data)).toList();
  // } else {
  //   throw Exception('Unexpected error occured!');
  // }
}

class _UpdatesPageState extends State<UpdatesPage> {
  final cartController = Get.put(CartController());
  final ecomCartController = Get.put(EcomCartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        title: const Text(
          "Scholarships & Awards",
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [


          const SizedBox(
            height: 10,
          ),
          FutureBuilder<List<ScholarshipData>>(
              future: fetchScholarships(),
              builder: (context, snapshot) {
                // print(snapshot.error);
                if (snapshot.hasData) {
                  List<ScholarshipData>? data = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: data!.length,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                          elevation: 3,
                          margin: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            leading: data[index].image != null ? Image.network(
                                data[index].image!,
                                height: 250, fit: BoxFit.fill) : Image.asset(
                                "assets/images/dp.png"),
                            dense: true,

                            title: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              data[index].title!,
                              style: const TextStyle(
                                fontSize: 15.0,
                              ),
                            ),

                            subtitle:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(data[index].description!,overflow: TextOverflow.ellipsis,maxLines: 3,
                                      style: const TextStyle(
                                          fontSize: 14.0, fontWeight: FontWeight.normal)),

                                ]),
                            onTap: () {

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>ScholarshipDetails(
                                      image: data[index].image!, title: data[index].title!, website: data[index].website!, email: data[index].email!, address: data[index].address!, description: data[index].description!, phone: data[index].phone!)));

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
