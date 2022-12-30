import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:educanapp/views/features/presentation/components/hero_widget.dart';
import 'package:educanapp/views/features/presentation/pages/portfolio/portfolio_tutorial_detail_page.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../../../../controller/sign_in_controller.dart';
import '../../../../../models/all_topic_videos.dart';
import '../../../../success/subs_check_page.dart';

class PortfolioTutorialsSubPage extends StatelessWidget {
  PortfolioTutorialsSubPage(
      {Key? key,
      required this.topid,
      required this.topname,
      required this.limit,
      required this.plan,
      required this.cla,
      required this.uid})
      : super(key: key);
  String topid;
  String topname;
  String limit;
  int plan;
  String cla;
  String uid;

  Future<List<TopicsVideosData>> fetchTopicVideos(String tag) async {
    final response = await http.get(Uri.parse(
        'https://educanug.com/educan_new/educan/api/library/get_topic_videos.php?topic=$tag'));
    // if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    // print(jsonResponse);
    return jsonResponse.map((data) => TopicsVideosData.fromJson(data)).toList();
    // } else {
    //   throw Exception('Unexpected error occured!');
    // }
  }

  final controller = SignInController();
  var result;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            // Add the app bar to the CustomScrollView.

            SliverAppBar(
              snap: false,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("Educan Lessons\n$topname",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ) //TextStyle
                    ), //Text//Images.network
              ), //FlexibleSpaceBar
              expandedHeight: 50,
              backgroundColor: const Color(0xFF1A8F00),
              //IconButton
              // actions: <Widget>[
              //   IconButton(
              //     icon: Icon(Icons.shopping_cart),
              //     tooltip: 'Shopping Icon',
              //     onPressed: () {},
              //   ), //IconButton
              // //IconButton
              // ], //<Widget>[]
            ), //SliverAppBar

            _buildSliverContent(),
          ],
        ),
      ),
    );
  }

  _buildSliverContent() {
    return FutureBuilder<List<TopicsVideosData>>(
        future: fetchTopicVideos(topid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<TopicsVideosData>? data = snapshot.data;
            return SliverFixedExtentList(
              itemExtent: 100,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _buildListItem(context, data![index], limit, plan);
                },
                childCount: data!.length,
              ),
            );
          } else {
            return const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator(),
                ));
          }
        });
  }

  Widget _buildListItem(
      BuildContext context, TopicsVideosData tutorial, String limit, int plan) {
    return Stack(
      children: <Widget>[
        _buildCardView(tutorial.title!, tutorial.logo!),
        _buildRippleEffectNavigation(
            context,
            tutorial.details!,
            tutorial.logo!,
            tutorial.link!,
            tutorial.title!,
            limit,
            plan,
            tutorial.forsubscribe!,
            cla,tutorial.charge!),
      ],
    );
  }

  Widget _buildCardView(String desc, String imageUrl) {
    return Positioned.fill(
      child: Card(
        margin: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeroWidget(imageUrl),
            _buildDesc(desc),
          ],
        ),
      ),
    );
  }

  Expanded _buildDesc(String desc) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
        child: Text(
          desc,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  HeroWidget _buildHeroWidget(String imageUrl) {
    return HeroWidget(
      width: 150,
      heroTag: imageUrl,
      builder: (BuildContext context) {
        return _buildHeroWidgetContent(imageUrl);
      },
      onTap: () {},
    );
  }

  CachedNetworkImage _buildHeroWidgetContent(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildRippleEffectNavigation(
      BuildContext context,
      String desc,
      String imageUrl,
      String videoUrl,
      String tit,
      String limit,
      int plan,
      String fors,
      String cla,
      String chargeAmount) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: const Color(0xFF1A8F00).withOpacity(0.5),
          highlightColor: const Color(0xFF1A8F00).withOpacity(0.5),
          onTap: () async {
            if (int.parse(chargeAmount) > 0) {
              if (plan >= int.parse(chargeAmount)) {
                //  collect the charge amount here
                result = await controller.chargeWallet(
                    uid, chargeAmount, 'Lesson Charge');
                // print(result);
                var got = json.decode(result);
                // print(got['message']);
                if (got['success']) {
                  Navigator.of(context).push(
                    _createTutorialDetailRoute(desc, imageUrl, videoUrl, tit),
                  );
                } else {
                  _showMyDialog(context);
                }
              }
            }else{
                Navigator.of(context).push(
                    _createTutorialDetailRoute(desc, imageUrl, videoUrl, tit),
                  );
            }
          },

          //* FilePicker to get video path from phone storage
          // onTap: () async {
          //   File videoFile = await FilePicker.getFile(type: FileType.video);
          //   if (videoFile != null) {
          //     videoUrl = videoFile.path;

          //     Navigator.of(context).push(
          //       _createTutorialDetailRoute(desc, imageUrl, videoUrl),
          //     );
          //   }
          // },
        ),
      ),
    );
  }

  PageRoute<Object> _createTutorialDetailRoute(desc, imageUrl, videoUrl, tit) {
    return PageRouteBuilder(
      transitionDuration: const Duration(seconds: 1),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.ease))
              .animate(animation),
          child: FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: Curves.ease))
                .animate(animation),
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) =>
          PortfolioTutorialDetailPage(
        heroTag: imageUrl,
        desc: desc,
        videoUrl: videoUrl,
        title: tit,
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ooops!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Something happened '),
                Text('Click again'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
