import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:http/http.dart' as http;

import '../../models/library_topic_items.dart';
import '../pdf_viewer_page/pdf_viewer_page.dart';

class LibraryContentsPage extends StatefulWidget {
  LibraryContentsPage(
      {Key? key, required this.title, required this.clas, required this.subid,required this.code})
      : super(key: key);
  String title;
  String clas;
  String subid;
  String code;

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
  print(jsonResponse);
  return jsonResponse.map((data) => LibraryTopicItems.fromJson(data)).toList();
  // } else {
  //   throw Exception('Unexpected error occured!');
  // }
}

class _LibraryContentsPageState extends State<LibraryContentsPage> {
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
                      return Card(
                          elevation: 1,
                          margin: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: ListTile(
                            leading: data[index].logo != null ? Image.network(
                                 data[index].logo!,

                            ) : Image.asset(
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
                                       overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                      style: const TextStyle(
                                          fontSize: 14.0, fontWeight: FontWeight.normal)),
                                   // Text('Population: ${data[index].id}',
                                   //    style:  const TextStyle(
                                   //        fontSize: 12.0, fontWeight: FontWeight.normal)),
                                ]),
                            onTap: () {

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PDFDoc(

                                      link: data[index].link!,
                                      title: data[index].title!,


                                    )));

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
