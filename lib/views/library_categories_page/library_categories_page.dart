import 'dart:convert';

import 'package:educanapp/utils/constants_new.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:http/http.dart' as http;

import '../../models/library_categories.dart';
import '../library_contents_page/library_conents_page.dart';
import '../topics_page/topics_page.dart';

class LibraryCategoriesPage extends StatefulWidget {
  LibraryCategoriesPage(
      {Key? key, required this.clas, required this.subid})
      : super(key: key);

  int clas;
  String subid;

  @override
  State<LibraryCategoriesPage> createState() => _LibraryCategoriesPageState();
}

Future<List<LibraryCategoriesData>> fetchCategories() async {
  final response = await http.get(Uri.parse(
      'https://educanug.com/educan_new/educan/api/library/get_library_categories.php'));
  // if (response.statusCode == 200) {
  List jsonResponse = json.decode(response.body);
  print(jsonResponse);
  return jsonResponse.map((data) => LibraryCategoriesData.fromJson(data)).toList();
  // } else {
  //   throw Exception('Unexpected error occured!');
  // }
}
// final orientation = MediaQuery.of(context).orientation;
class _LibraryCategoriesPageState extends State<LibraryCategoriesPage> {
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
        title: const Text("Library Categories"),
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
          const Center(
            child: Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              "Select a Library Section of your Interest",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<List<LibraryCategoriesData>>(
              future: fetchCategories(),
              builder: (context, snapshot) {
                // print(snapshot.error);
                if (snapshot.hasData) {
                  List<LibraryCategoriesData>? data = snapshot.data;
                      return   GridView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: data?.length,
                          physics: const ScrollPhysics(),
                          itemBuilder: (ctx, i) {
                            return GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LibraryContentsPage(
                                      title: data![i].title!,
                                      subid: widget.subid,
                                      clas: widget.clas.toString(),
                                      code: data[i].code!,
                                    )));
                              },
                              child: Card(
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: Image.network(
                                              data![i].image!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Text(
                                            data[i].title!,
                                            style: const TextStyle(
                                              fontSize: 15,

                                            ),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },




                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait) ? 2 : 3),
                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait) ? 2 : 3,
                            childAspectRatio: 1.0,
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 5,
                            // mainAxisExtent: 100,
                          ),
                        // ),
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
