import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../controller/cart_controller.dart';
import '../../models/consultants_model.dart';
import '../../models/library_topic_items.dart';
import '../cart/cart_screen.dart';
import '../pdf_viewer_page/pdf_viewer_page.dart';
import 'package:get/get.dart';
class ConsultantsPage extends StatefulWidget {
  ConsultantsPage(
      {Key? key, required this.title, required this.clas, required this.subid})
      : super(key: key);
  String title;
  String clas;
  String subid;

  @override
  State<ConsultantsPage> createState() => _ConsultantsPageState();
}

Future<List<ConsultantsData>> fetchConsultants(String cl,String sub) async {
  final response;

    response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/library/get_consultants.php?class=$cl&subject=$sub'));


  // if (response.statusCode == 200) {
  List jsonResponse = json.decode(response.body);
  // print(jsonResponse);
  return jsonResponse.map((data) => ConsultantsData.fromJson(data)).toList();
  // } else {
  //   throw Exception('Unexpected error occured!');
  // }
}

class _ConsultantsPageState extends State<ConsultantsPage> {
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

          FutureBuilder<List<ConsultantsData>>(
              future: fetchConsultants(widget.clas,widget.subid),
              builder: (context, snapshot) {
                // print(snapshot.error);
                if (snapshot.hasData) {
                  List<ConsultantsData>? data = snapshot.data;
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
                            leading: data[index].image != null ? ClipOval(
                              // radius: 40,
                              child:Image.network(
                                    "https://educanug.com/Educan/${data[index].image!}",
                              ),
                            ) : ClipOval(
                              child: Image.asset(
                                  "assets/images/dp.png"),
                            ),
                            dense: true,

                            title: Text(

                              data[index].name!,
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
                                  Text(data[index].description!,

                                      style: const TextStyle(
                                          fontSize: 14.0, fontWeight: FontWeight.normal)),
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      TextButton(
                                        style: TextButton.styleFrom(
                                          primary:  Colors.white,
                                          backgroundColor: const Color(0xFF1A8F00),// Text Color
                                        ),
                                        // style: ButtonStyle(
                                        //   backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                        //   foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                        // ),
                                        onPressed: () {
                                          final Uri launchUri = Uri(
                                            scheme: 'tel',
                                            path: '${data[index].phone!}',
                                          );
                                          launchUrl(launchUri);
                                        },
                                        child: const Text('CALL'),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          primary:  Colors.white,
                                          backgroundColor: const Color(0xFF1A8F00),// Text Color
                                        ),
                                        // style: ButtonStyle(
                                        //   backgroundColor:  Color(0xFF1A8F00),
                                        //   foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                        // ),
                                        onPressed: () {
                                          if( canLaunch(openWhatsapp(data[index].phone!)) != null){
                                            launch(openWhatsapp(data[index].phone!));
                                          }
                                          else {
                                            throw 'Could not launch ${openWhatsapp(data[index].phone!)}';
                                          }


                                        },
                                        child: const Text('CHAT'),
                                      )
                                    ],

                                  ),
                                  // Text('Population: ${data[index].id}',
                                  //    style:  const TextStyle(
                                  //        fontSize: 12.0, fontWeight: FontWeight.normal)),
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

  openWhatsapp(String phon) {
    var phone = "+256$phon";
    var message ="Hello, Educan APP";
    if (Platform.isAndroid) {
      // add the [https]
      return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
    } else {
      // add the [https]
      return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
    }
  }
}
