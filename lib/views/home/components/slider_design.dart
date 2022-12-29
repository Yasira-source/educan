import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AdsCarouselSlider extends StatefulWidget {
  final String img1;
  final String img2;
  final String img3;
  final String img4;
  final String img5;
  const AdsCarouselSlider(
      {Key? key, required this.img1, required this.img2, required this.img3,required this.img4,required this.img5})
      : super(key: key);

  @override
  State<AdsCarouselSlider> createState() => _AdsCarouselSliderState();
}

class _AdsCarouselSliderState extends State<AdsCarouselSlider> {
  int _currentIndex = 0;
  List<String> images = [];
  @override
  void initState() {
    super.initState();
    images.add(widget.img1);
    images.add(widget.img2);
    images.add(widget.img3);
    images.add(widget.img4);
    images.add(widget.img5);
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images
          .map((e) => Padding(
               padding: const EdgeInsets.only(left:5.0,right: 5.0),
            child: Container(
              
              // height: 100,
                  color: Colors.white,
                  child: CachedNetworkImage(
                    imageUrl:  e,
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
                            image: DecorationImage(image: imageProvider,fit: BoxFit.cover)),
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
          ))
          .toList(),
      options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 2.0,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}
