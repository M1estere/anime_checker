import 'package:film_checker/api/anime_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:video_player/video_player.dart';

class AnimeWatchPageView extends StatefulWidget {
  final Map animeLinks;

  const AnimeWatchPageView({
    super.key,
    required this.animeLinks,
  });

  @override
  State<AnimeWatchPageView> createState() => _AnimeWatchPageViewState();
}

class _AnimeWatchPageViewState extends State<AnimeWatchPageView> {
  Map<String, String> _dataMap = {};
  String _currentRes = 'HD';

  bool _fullScreenActive = false;

  @override
  void initState() {
    _dataMap = {
      'Full HD': widget.animeLinks['fhd'] ?? '',
      'HD': widget.animeLinks['hd'] ?? '',
      'SD': widget.animeLinks['sd'] ?? '',
    };

    if (widget.animeLinks['fhd'] == null) {
      _currentRes = 'HD';
    } else if (widget.animeLinks['hd'] == null) {
      _currentRes = 'SD';
    } else if (widget.animeLinks['sd'] == null) {
      _currentRes = '';
    }

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
          _currentRes.isNotEmpty
              ? YoYoPlayer(
                  autoPlayVideoAfterInit: true,
                  url: AnimePlayerController()
                      .getFullAnimePath(_dataMap[_currentRes]!),
                  aspectRatio: 16 / 9,
                  videoStyle: VideoStyle(
                    progressIndicatorPadding:
                        const EdgeInsets.symmetric(vertical: 10),
                    qualityOptionWidth: 0,
                    qualityOptionStyle:
                        const TextStyle(color: Colors.transparent),
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
                          SizedBox(
                            height: 5,
                          ),
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
                )
              : const Center(
                  child: Text(
                    'Sorry, video is unavailable',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
