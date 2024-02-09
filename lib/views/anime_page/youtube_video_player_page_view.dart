import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeVideoPlayerPageView extends StatefulWidget {
  final String youtubeUrl;
  final String title;

  const YoutubeVideoPlayerPageView({
    super.key,
    required this.youtubeUrl,
    required this.title,
  });

  @override
  State<YoutubeVideoPlayerPageView> createState() =>
      _YoutubeVideoPlayerPageViewState();
}

class _YoutubeVideoPlayerPageViewState
    extends State<YoutubeVideoPlayerPageView> {
  final _controller = YoutubePlayerController(
    params: const YoutubePlayerParams(
      mute: false,
      showControls: true,
      showFullscreenButton: false,
      loop: false,
    ),
  );

  @override
  void initState() {
    _controller.cueVideoById(videoId: widget.youtubeUrl);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: MediaQuery.of(context).size.width * .9,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 35,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          YoutubePlayer(
            controller: _controller,
            aspectRatio: 16 / 9,
          ),
        ],
      ),
    );
    // return SafeArea(
    //   child: SizedBox(
    //     child: YoutubePlayerScaffold(
    //       backgroundColor: Colors.blue,
    //       enableFullScreenOnVerticalDrag: true,
    //       autoFullScreen: true,
    //       defaultOrientations: const [
    //         DeviceOrientation.portraitUp,
    //         DeviceOrientation.portraitDown,
    //       ],
    //       controller: _controller,
    //       aspectRatio: 16 / 9,
    //       builder: (context, player) => Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [player],
    //       ),
    //     ),
    //   ),
    // );
  }
}
