import 'dart:convert';

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
        // Padding(
        //   padding:
        //       const EdgeInsets.symmetric(horizontal: 20),
        //   child: SectionTitle(
        //     title: "Special for you",
        //     press: () {},
        //   ),
        // ),
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
                      return  SizedBox(
                        height: 180,
                        child: ListView.builder(
                          shrinkWrap:true,
                          scrollDirection: Axis.horizontal,
                          itemCount: data!.length,
                          itemBuilder: (context, index) {

                            return  SpecialOfferCard(
                              image: data[index].image,
                              category: data[index].id,
                              numOfBrands: 18,
                              press: () {},
                            );


                          },
                          // ),
                        ),
                      );
                    } else {
                      return  Container(
                        height: 2,
                      );
                    }
                  }),
              // SpecialOfferCard(
              //   image: "assets/images/Image Banner 2.png",
              //   category: "Smartphone",
              //   numOfBrands: 18,
              //   press: () {},
              // ),
              // SpecialOfferCard(
              //   image: "assets/images/download.jpg",
              //   category: "Fashion",
              //   numOfBrands: 24,
              //   press: () {},
              // ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
     this.category,
     this.image,
     this.numOfBrands,
     this.press,
  }) : super(key: key);

  final String? category, image;
  final int? numOfBrands;
  final GestureTapCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 360,
          height: 180,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                 decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF343434).withOpacity(0.4),
                          Color(0xFF343434).withOpacity(0.15),
                        ],
                      ),
                    ),
              child: Stack(
                children: [
                  Image.network(
                    image!,
                    fit: BoxFit.cover,
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //       begin: Alignment.topCenter,
                  //       end: Alignment.bottomCenter,
                  //       colors: [
                  //         Color(0xFF343434).withOpacity(0.4),
                  //         Color(0xFF343434).withOpacity(0.15),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: 15.0,
                  //     vertical: 10,
                  //   ),
                  //   child: Text.rich(
                  //     TextSpan(
                  //       style: TextStyle(color: Colors.white),
                  //       children: [
                  //         TextSpan(
                  //           text: "$category\n",
                  //           style: TextStyle(
                  //             fontSize: 18,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //         TextSpan(text: "$numOfBrands Brands")
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
