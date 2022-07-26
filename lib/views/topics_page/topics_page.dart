import 'dart:convert';

import 'package:educanapp/models/subjects_model.dart';
import 'package:educanapp/utils/constants_new.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:http/http.dart' as http;

import '../../models/all_topics.dart';
import '../features/presentation/pages/portfolio/portfolio_tutorials_sub_page.dart';
class TopicsPage extends StatefulWidget {
  TopicsPage({Key? key, required this.title, required this.catid,required this.subid,required this.limit,required this.plan})
      : super(key: key);
  String title;
  String catid;
  int subid;
String limit;
int plan;
  @override
  State<TopicsPage> createState() => _TopicsPageState();
}

Future<List<TopicsData>> fetchTopics(String tag,String subj) async {
  final response = await http.get(Uri.parse(
      'https://educanug.com/educan_new/educan/api/library/get_topics.php?class=$tag&subject=$subj'));
  // if (response.statusCode == 200) {
  List jsonResponse = json.decode(response.body);
  // print(jsonResponse);
  return jsonResponse.map((data) => TopicsData.fromJson(data)).toList();
  // } else {
  //   throw Exception('Unexpected error occured!');
  // }
}

class _TopicsPageState extends State<TopicsPage> {
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
        child:
        Column(
            children:
            [
              const SizedBox(height: 10,),
              const Center(

                child:Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines:1,
                  "Select a topic of your Interest",
                  style:  TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),

              ),
              const SizedBox(height: 10,),
              FutureBuilder<List<TopicsData>>(
                  future: fetchTopics(widget.subid.toString(),widget.catid),
                  builder: (context, snapshot) {
                    // print(snapshot.error);
                    if (snapshot.hasData) {
                      List<TopicsData>? data = snapshot.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: data!.length,
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
                                  maxLines:2,
                                  data[index].name!,
                                  style:  const TextStyle(fontSize: 15.0,),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                  color: Color(0xFF1A8F00),
                                ),
                                // subtitle:  Column(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: <Widget>[
                                //        Text(data[index].description!,
                                //           style: const TextStyle(
                                //               fontSize: 14.0, fontWeight: FontWeight.normal)),
                                //        Text('Population: ${data[index].id}',
                                //           style:  const TextStyle(
                                //               fontSize: 12.0, fontWeight: FontWeight.normal)),
                                //     ]),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PortfolioTutorialsSubPage(topid: data[index].id!,topname: data[index].name!,limit:widget.limit,plan:widget.plan,cla:widget.catid)));

                                },
                              )

                          );
                        },

                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ]
        ),

      ),
    );
  }


}