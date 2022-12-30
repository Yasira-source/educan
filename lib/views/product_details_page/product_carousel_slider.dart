import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:educanapp/views/product_details_page/image_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductCarouselSlider extends StatefulWidget {
  final String img1;
  final String img2;
  final String img3;
  const ProductCarouselSlider(
      {Key? key, required this.img1, required this.img2, required this.img3})
      : super(key: key);

  @override
  State<ProductCarouselSlider> createState() => _ProductCarouselSliderState();
}

class _ProductCarouselSliderState extends State<ProductCarouselSlider> {
  int _currentIndex = 0;
  List<String> images = [];
  @override
  void initState() {
    super.initState();
    images.add(widget.img1);
    images.add(widget.img2);
    images.add(widget.img3);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider(
              items: images
                  .map((e) => GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ImageDetailScreen(
                              link: 'https://educanug.com/Educan/$e',
                            );
                          }));
                        },
                        child: Container(
                          color: Colors.white,
                          child: CachedNetworkImage(
                            imageUrl: 'https://educanug.com/Educan/$e',
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white10,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  image: DecorationImage(image: imageProvider)),
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
                  // height: 00,
                  aspectRatio: 1.5,
                  viewportFraction: 0.70,
                  enlargeCenterPage: true,
                  pageSnapping: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  }),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.map((e) {
            int index = images.indexOf(e);
            return Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? const Color(0xFF1A8F00)
                      : Colors.grey.shade400),
            );
          }).toList(),
        )
      ],
    );
  }
}
