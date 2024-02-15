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
      color: 'red',
      mute: false,
      showControls: true,
      showFullscreenButton: false,
      loop: false,
    ),
  );

  @override
  void initState() {
    super.initState();

    _controller.cueVideoById(videoId: widget.youtubeUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 50,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: Theme.of(context).appBarTheme.actionsIconTheme!.size,
            color: Theme.of(context).appBarTheme.actionsIconTheme!.color,
          ),
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
  }
}
