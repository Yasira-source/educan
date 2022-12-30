import 'dart:convert';

import 'package:educanapp/models/check_subs.dart';
import 'package:educanapp/utils/constants_new.dart';
import 'package:educanapp/views/subjects_page/subjects_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/cart_controller.dart';
import '../cart/cart_screen.dart';

import 'package:http/http.dart' as http;
class ClassesPage extends StatefulWidget {
  ClassesPage({Key? key, required this.title, required this.catid,required this.package})
      : super(key: key);
  String title;
  int catid;
  int package;

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {

  final cartController = Get.put(CartController());
  // final ecomCartController = Get.put(EcomCartController());
String uid ='';

  List balance = [];
  // late Future<SubsData> futureAlbum;

  Future<String> fetchSubStatus(String tag) async {
    var res = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/user/get_wallet_balance.php?user=$tag'));
    var resBody = json.decode(res.body);
     setState(() {
      balance = resBody;
    
    });
    return '';
  }
  _loadCounterx() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = (prefs.getString('uid') ?? '');

    });
  }
  void secureScreen() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    await FlutterWindowManager.clearFlags(
        FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_FULLSCREEN);
  }

  @override
  void initState() {
    super.initState();
    secureScreen();
    _loadCounterx();
    // futureAlbum = fetchSubStatus(uid);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        elevation: 0,

        title: Text(widget.title),


        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Ionicons.search_outline,
          //     color: Colors.white,
          //   ),
          // ),
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
        child:FutureBuilder<String>(
    future: fetchSubStatus(uid),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
      // List<SubsData>? data = snapshot.data;
      return Column(
        children: [
          const SizedBox(height:20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                // SizedBox(width: 0.01,),
                Text(
                  "Primary Level",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Icon(Icons.arrow_forward_ios,color: Color(0xFF1A8F00),),
              ],
            ),
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  primary.length,
                  // 5,
                      (index) {

                    return _buildCard2( primary[index],primaryWords[index],primaryCount[index],context, balance[0]['balance'], int.parse( balance[0]['balance']));
                    // return _buildCard2( "assets/images/", context);

                    // return SizedBox
                    //     .shrink(); // here by default width and height is 0
                  },
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                // SizedBox(width: 0.01,),
                Text(
                  "Ordinary Level - Old Curriculum",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Icon(Icons.arrow_forward_ios,color: Color(0xFF1A8F00),),
              ],
            ),
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  olevel.length,
                  // 5,
                      (index) {

                    return _buildCard2( olevel[index],olevelWords[index],olevelCount[index],context, balance[0]['balance'], int.parse( balance[0]['balance']));
                    // return _buildCard2( "assets/images/", context);

                    // return SizedBox
                    //     .shrink(); // here by default width and height is 0
                  },
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                // SizedBox(width: 0.01,),
                Text(
                  "Ordinary Level - New Curriculum",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Icon(Icons.arrow_forward_ios,color: Color(0xFF1A8F00),),
              ],
            ),
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  olevel.length,
                  // 5,
                      (index) {

                    return _buildCard2( olevel[index],olevelWords[index],olevelnewCount[index],context, balance[0]['balance'], int.parse( balance[0]['balance']));
                    // return _buildCard2( "assets/images/", context);

                    // return SizedBox
                    //     .shrink(); // here by default width and height is 0
                  },
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                // SizedBox(width: 0.01,),
                Text(
                  "Advanced Level",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Icon(Icons.arrow_forward_ios,color: Color(0xFF1A8F00),),
              ],
            ),
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  alevel.length,
                  // 5,
                      (index) {

                    return _buildCard2( alevel[index],alevelWords[index],alevelCount[index],context, balance[0]['balance'], int.parse( balance[0]['balance']));
                    // return _buildCard2( "assets/images/", context);

                    // return SizedBox
                    //     .shrink(); // here by default width and height is 0
                  },
                ),
                const SizedBox(width: 20),
              ],
            ),
          )
        ],
      );
    }
    else{
      // By default, show a loading spinner.
      return  const Center(child: CircularProgressIndicator());
    }
    }
        ),


      ),
    );
  }

  Widget _buildCard2(String imgPath,String wor,int cla, context,String limit,int plan) {
    return Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SubjectsPage(title: wor, catid: widget.catid,subid: cla,limit: limit,plan: plan,package: widget.package,)));
            },
            child: Container(
                width: 90,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    // color: Colors.white,
                    ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height:10),

                      Stack(
                        // alignment: AlignmentDirectional.topStart,
                        // fit: StackFit.loose,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Hero(
                                tag: imgPath,
                                child: Container(
                                    height: 50.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(imgPath),
                                            fit: BoxFit.fitHeight)
                                            ))),
                          ),
                        ],
                      ),
                      SizedBox(height:10),
                      Text(wor),

                    ]))));
  }
}
