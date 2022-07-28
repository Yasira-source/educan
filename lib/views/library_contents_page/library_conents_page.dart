import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:ionicons/ionicons.dart';

import 'package:http/http.dart' as http;

import '../../models/library_topic_items.dart';
import '../pdf_viewer_page/pdf_viewer_page.dart';
import '../success/subs_check_page.dart';

class LibraryContentsPage extends StatefulWidget {
  LibraryContentsPage(
      {Key? key, required this.title, required this.clas, required this.subid,required this.code,required this.limit,required this.plan})
      : super(key: key);
  String title;
  String clas;
  String subid;
  String code;
String limit;
int plan;
  @override
  State<LibraryContentsPage> createState() => _LibraryContentsPageState();
}

Future<List<LibraryTopicItems>> fetchContents(String cl,String sub,String c) async {
  final response;
  if(c=="BK"){
     response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/library/get_topic_books.php?class=$cl&subject=$sub'));
  }else if(c=="AN"){
     response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/library/get_topic_answers.php?class=$cl&subject=$sub'));
  }else if(c=="TST"){
     response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/library/get_topic_tests.php?class=$cl&subject=$sub'));
  }else if(c=="EX"){
     response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/library/get_topic_exam.php?class=$cl&subject=$sub'));
  }else if(c=="UNEB"){
     response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/library/get_topic_uneb.php?class=$cl&subject=$sub'));
  }else if(c=="RN"){
    response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/library/get_topic_notes.php?class=$cl&subject=$sub'));
  }
  else{
     response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/library/get_topic_others.php?class=$cl&subject=$sub'));
  }

  // if (response.statusCode == 200) {
  List jsonResponse = json.decode(response.body);
  // print(jsonResponse);
  return jsonResponse.map((data) => LibraryTopicItems.fromJson(data)).toList();
  // } else {
  //   throw Exception('Unexpected error occured!');
  // }
}

class _LibraryContentsPageState extends State<LibraryContentsPage> {

  void secureScreen() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    // await FlutterWindowManager.addFlags(
    //     FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
    // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_FULLSCREEN);
  }

  @override
  void initState() {
    super.initState();
    secureScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A8F00),
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(
        //     Ionicons.chevron_back,
        //     color: Colors.white,
        //   ),
        // ),
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Ionicons.search_outline,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Ionicons.cart_outline,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),

          FutureBuilder<List<LibraryTopicItems>>(
              future: fetchContents(widget.clas,widget.subid,widget.code),
              builder: (context, snapshot) {
                // print(snapshot.error);
                if (snapshot.hasData) {
                  List<LibraryTopicItems>? data = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: data!.length,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          if(data[index].forsubscribe=='T') {
                            if (widget.plan == 1) {
                              var cl;
                              if (int.parse(widget.clas) <= 7 &&
                                  int.parse(widget.clas) > 0) {
                                cl = '3';
                              } else {
                                cl = '2';
                              }
                              if (widget.limit == '1' || widget.limit == cl) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        PDFDoc(

                                          link: data[index].link!,
                                          title: data[index].title!,


                                        )));
                              }else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                    const SubscribeMessage(


                                    )));
                              }
                            }else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                  const SubscribeMessage(


                                  )));
                            }
                          }else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    PDFDoc(

                                      link: data[index].link!,
                                      title: data[index].title!,


                                    )));
                          }
                             },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: Container(
                            height: 120,
                            padding: const EdgeInsets.all(0),
                            child: Row(children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              data[index].logo!
                                          ),
                                          fit: BoxFit.fill)),
                                ),
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                flex: 14,
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                          maxLines: 2, data[index].title!,
                                          style: const TextStyle(
                                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                                      Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(data[index].description!,overflow: TextOverflow.ellipsis,maxLines: 4,
                                                style: const TextStyle(
                                                    fontSize: 14.0, fontWeight: FontWeight.normal)),
                                            const SizedBox(height: 2,)

                                          ]),



                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      );

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
