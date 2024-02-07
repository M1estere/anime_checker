import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      showFullscreenButton: true,
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
    return SafeArea(
      child: SizedBox(
        child: YoutubePlayerScaffold(
          backgroundColor: Colors.blue,
          enableFullScreenOnVerticalDrag: true,
          autoFullScreen: true,
          defaultOrientations: const [
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ],
          controller: _controller,
          aspectRatio: 16 / 9,
          builder: (context, player) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [player],
          ),
        ),
      ),
    );
    // ),
    //   ),
    // );
  }
}
