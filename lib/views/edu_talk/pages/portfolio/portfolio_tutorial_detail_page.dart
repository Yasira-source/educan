import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:educanapp/views/features/presentation/components/hero_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class EduTalkDetailPage extends StatefulWidget {
  final Object heroTag;
  final String desc;
  final String title;
  final String videoUrl;

  const EduTalkDetailPage({
    Key? key,
    required this.heroTag,
    required this.desc,
    required this.videoUrl,
    required this.title
  }) : super(key: key);

  @override
  _EduTalkDetailPageState createState() =>
      _EduTalkDetailPageState();
}

class _EduTalkDetailPageState
    extends State<EduTalkDetailPage> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      //* VideoPlayer Network constructor for playing video from internet
      videoPlayerController: VideoPlayerController.network(widget.videoUrl),

      //* VideoPlayer Asset constructor for playing video from application's asset folder
      // videoPlayerController: VideoPlayerController.asset('assets/videos/himdeveIntro.mp4'),

      //* VideoPlayer File constructor for playing video from phone storage
      // videoPlayerController: VideoPlayerController.file(File(widget.videoUrl)),
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      errorBuilder: (context, errorMessage) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Problem Loading Video!\nTry Again",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Educan Talk'),
        backgroundColor:  const Color(0xFF1A8F00),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildHeroWidget(context),
          _buildTitle(),
          _buildDesc(),
        ],
      ),
    );
  }

  HeroWidget _buildHeroWidget(BuildContext context) {
    return HeroWidget(
      heroTag: widget.heroTag,
      width: MediaQuery.of(context).size.width,

      builder: (BuildContext context) {
        return _buildHeroWidgetContent();
      }, onTap: () {  },
    );
  }

  Chewie _buildHeroWidgetContent() {
    return Chewie(
      controller: _chewieController,
    );
  }

  Widget _buildDesc() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        widget.desc,
        style: const TextStyle(fontSize: 17),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      // padding: const EdgeInsets.all(5.0),
      child: Text(
        widget.title,
        style: const TextStyle(fontSize: 17),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  void dispose() {
    _chewieController.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
