import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class AdsCarouselSlider extends StatefulWidget {
  final String img1;
  final String img2;
  final String img3;
  final String img4;
  final String img5;

  final String l1;
  final String l2;
  final String l3;
  final String l4;
  final String l5;
  const AdsCarouselSlider({
    Key? key,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.img5,
    required this.l1,
    required this.l2,
    required this.l3,
    required this.l4,
    required this.l5,
  }) : super(key: key);

  @override
  State<AdsCarouselSlider> createState() => _AdsCarouselSliderState();
}

class _AdsCarouselSliderState extends State<AdsCarouselSlider> {
  List<String> images = [];
  List<String> links = [];
  int _current = 0;
  dynamic _selectedIndex = {};
 var url = "https://educanug.com/";
  CarouselController _carouselController = new CarouselController();
  @override
  void initState() {
    super.initState();
    images.add(widget.img1);
    images.add(widget.img2);
    images.add(widget.img3);
    images.add(widget.img4);
    images.add(widget.img5);

    links.add(widget.l1);
    links.add(widget.l2);
    links.add(widget.l3);
    links.add(widget.l4);
    links.add(widget.l5);
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        carouselController: _carouselController,
        options: CarouselOptions(
            autoPlay: true,
            height: 450.0,
            aspectRatio: 16 / 9,
            viewportFraction: 0.70,
            enlargeCenterPage: true,
            pageSnapping: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
        items: images.map((movie) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                   
                    if (movie == widget.img1) {
                      url = widget.l1;
                    }else if (movie == widget.img2) {
                      url = widget.l2;
                    }else if (movie == widget.img3) {
                      url = widget.l3;
                    }else if (movie == widget.img4) {
                      url = widget.l4;
                    }else if (movie == widget.img5) {
                      url = widget.l5;
                    }

                    if (canLaunch(url) != null) {
                      launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: movie,
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius: BorderRadius.circular(5),
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
                            color: Colors.white,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.fill)),
                      ),
                    ),
                    placeholder: (context, url) => Shimmer.fromColors(
                      highlightColor: Colors.white,
                      baseColor: Colors.grey.shade300,
                      child: Container(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }).toList());
  }
}
