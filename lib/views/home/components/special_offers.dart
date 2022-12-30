import 'dart:convert';

import 'package:educanapp/views/home/components/slider_design.dart';
import 'package:flutter/material.dart';

import '../../../models/adverts_model.dart';
import 'package:http/http.dart' as http;

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  Future<List<AdvertsData>> fetchAdvertsData() async {
    final response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/library/get_adverts.php'));
    // if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    // print(jsonResponse);
    return jsonResponse.map((data) => AdvertsData.fromJson(data)).toList();
    // } else {
    //   throw Exception('Unexpected error occured!');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FutureBuilder<List<AdvertsData>>(
                  future: fetchAdvertsData(),
                  builder: (context, snapshot) {
                    // print(snapshot.error);
                    if (snapshot.hasData) {
                      List<AdvertsData>? data = snapshot.data;
                      return SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: 
                             AdsCarouselSlider(
                              img1: data![0].image!,
                              img2: data[0].image!,
                              img3: data[0].image!,
                              img4: data[0].image!,
                              img5: data[0].image!,
                              l1: data[0].link!,
                              l2: data[0].link!,
                              l3: data[0].link!,
                              l4: data[0].link!,
                              l5: data[0].link!,
                            ),
                          // },
                          //   // ),
                        // ),
                      );
                    } else {
                      return Container(
                        height: 2,
                      );
                    }
                  }),
         
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}

