import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:educanapp/views/features/presentation/components/hero_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:video_player/video_player.dart';

class PortfolioTutorialDetailPage extends StatefulWidget {
  final Object heroTag;
  final String desc;
  final String title;
  final String videoUrl;

  const PortfolioTutorialDetailPage({
    Key? key,
    required this.heroTag,
    required this.desc,
    required this.videoUrl,
    required this.title
  }) : super(key: key);

  @override
  _PortfolioTutorialDetailPageState createState() =>
      _PortfolioTutorialDetailPageState();
}

class _PortfolioTutorialDetailPageState
    extends State<PortfolioTutorialDetailPage> {

  late ChewieController _chewieController;
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  void secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    await FlutterWindowManager.addFlags(
        FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_FULLSCREEN);
  }
  @override
  void initState() {

    _controller  =VideoPlayerController.network(widget.videoUrl);
    super.initState();
    _chewieController = ChewieController(
      //* VideoPlayer Network constructor for playing video from internet
      videoPlayerController: _controller,
      // Initialize the controller and store the Future for later use.

      //* VideoPlayer Asset constructor for playing video from application's asset folder
      // videoPlayerController: VideoPlayerController.asset('assets/videos/himdeveIntro.mp4'),
      // startAt: Duration(seconds: timeWatched),
      //* VideoPlayer File constructor for playing video from phone storage
      // videoPlayerController: VideoPlayerController.file(File(widget.videoUrl)),
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: true,
      looping: true,
        // placeholder:const Center(child: CircularProgressIndicator(),),
      errorBuilder: (context, errorMessage) {
        return  Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
        showControls: true,
        allowFullScreen: true,
        fullScreenByDefault: false,
        customControls: const CupertinoControls(
          backgroundColor: Color(0xFF1A8F00),
          iconColor: Colors.white,
        ),
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    secureScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Educan Lessons'),
        backgroundColor:  const Color(0xFF1A8F00),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return _buildHeroWidget(context);
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(child: const CircularProgressIndicator()),
                );
              }
            },
          ),

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
