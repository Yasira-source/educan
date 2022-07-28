import 'dart:convert';

import 'package:educanapp/models/subjects_model.dart';
import 'package:educanapp/utils/constants_new.dart';
import 'package:educanapp/views/consult/consultants.dart';
import 'package:educanapp/views/library_categories_page/library_categories_page.dart';
import 'package:educanapp/views/library_categories_page/library_categories_page_2.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../controller/cart_controller.dart';
import '../cart/cart_screen.dart';
import '../topics_page/topics_page.dart';

class SubjectsPage extends StatefulWidget {
  SubjectsPage(
      {Key? key, required this.title, required this.catid, required this.subid,required this.limit,required this.plan})
      : super(key: key);
  String title;
  int catid;
  int subid;
  String limit;
  int plan;

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

Future<List<SubjectsData>> fetchClass(String tag) async {
  final response = await http.get(Uri.parse(
      'https://educanug.com/educan_new/educan/api/library/get_subjects.php?class=$tag'));
  // if (response.statusCode == 200) {
  List jsonResponse = json.decode(response.body);
  // print(jsonResponse);
  return jsonResponse.map((data) => SubjectsData.fromJson(data)).toList();
  // } else {
  //   throw Exception('Unexpected error occured!');
  // }
}

class _SubjectsPageState extends State<SubjectsPage> {

  final cartController = Get.put(CartController());
  // final ecomCartController = Get.put(EcomCartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        elevation: 0,

        title: Text(widget.title),
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
          const Center(
            child: Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              "Select a subject of your Interest",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<List<SubjectsData>>(
              future: fetchClass(widget.subid.toString()),
              builder: (context, snapshot) {
                // print(snapshot.error);
                if (snapshot.hasData) {
                  List<SubjectsData>? data = snapshot.data;
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
                            // leading: data.image != null ? Image.network(
                            //     "https://docs.google.com/uc?export=view&id=" + data.image,
                            //     height: 250, fit: BoxFit.fill) : Image.asset(
                            //     "assets/images/700_x_350.jpg"),
                            dense: true,
                            leading: const Icon(
                              Ionicons.bookmark_sharp,
                              color: Color(0xFF1A8F00),
                            ),
                            title: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              data[index].name!,
                              style: const TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Color(0xFF1A8F00),
                            ),

                            onTap: () {
                              if (widget.catid == 2) {
                                //library
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LibraryCategoriesPage(

                                          subid: data[index].id!,
                                          clas: widget.subid,
                                      limit:widget.limit,
                                      plan:widget.plan
                                        )));
                              } else if (widget.catid == 1) {
                                //lessons
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TopicsPage(
                                          title: data[index].name!,
                                          catid: data[index].id!,
                                          subid: widget.subid,
                                        limit:widget.limit,
                                        plan:widget.plan
                                        )));
                              } else if (widget.catid == 3) {
                                //teacher resources
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LibraryCategoriesPage2(

                                      subid: data[index].id!,
                                      clas: widget.subid,
                                        limit:widget.limit,
                                        plan:widget.plan
                                    )));
                              }else if (widget.catid == 4) {
                                //teacher resources
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ConsultantsPage(
                                      title: data[index].name!,
                                      clas: widget.subid.toString(),
                                      subid: data[index].id!,

                                    )));
                              }
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
