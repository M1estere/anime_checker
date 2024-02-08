import 'package:film_checker/api/anime_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:video_player/video_player.dart';

class AnimeWatchPageView extends StatefulWidget {
  final Map animeLinks;
  final String currentRes;

  const AnimeWatchPageView({
    super.key,
    required this.animeLinks,
    required this.currentRes,
  });

  @override
  State<AnimeWatchPageView> createState() => _AnimeWatchPageViewState();
}

class _AnimeWatchPageViewState extends State<AnimeWatchPageView> {
  Map<String, String> _dataMap = {};

  bool _fullScreenActive = false;

  @override
  void initState() {
    _dataMap = {
      'Full HD': widget.animeLinks['fhd'],
      'HD': widget.animeLinks['hd'],
      'SD': widget.animeLinks['sd'],
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: _fullScreenActive ? 0 : 60,
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
        children: [
          YoYoPlayer(
            autoPlayVideoAfterInit: true,
            url: AnimePlayerController()
                .getFullAnimePath(_dataMap[widget.currentRes]!),
            aspectRatio: 16 / 9,
            videoStyle: VideoStyle(
              qualityOptionWidth: 0,
              qualityOptionStyle: const TextStyle(color: Colors.transparent),
              qualityOptionsBgColor: Colors.transparent,
              videoQualityBgColor: Colors.transparent,
              qualityStyle: const TextStyle(
                color: Colors.transparent,
              ),
              allowScrubbing: true,
              playIcon: const Icon(
                Icons.play_arrow_rounded,
                size: 35,
                color: Colors.white,
              ),
              pauseIcon: const Icon(
                Icons.pause,
                size: 35,
                color: Colors.white,
              ),
              backwardIcon: const Icon(
                Icons.replay_10_outlined,
                size: 30,
                color: Colors.white,
              ),
              forwardIcon: const Icon(
                Icons.forward_10_outlined,
                size: 30,
                color: Colors.white,
              ),
              progressIndicatorColors: VideoProgressColors(
                playedColor: Colors.blue,
                backgroundColor: Colors.grey.withOpacity(.5),
                bufferedColor: Colors.grey,
              ),
            ),
            onFullScreen: (fullScreenTurnedOn) {
              _fullScreenActive = fullScreenTurnedOn;
              if (mounted) {
                setState(() {});
              }
            },
            videoLoadingStyle: VideoLoadingStyle(
              loading: Container(
                color: Colors.black,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text(
                      'Loading',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
