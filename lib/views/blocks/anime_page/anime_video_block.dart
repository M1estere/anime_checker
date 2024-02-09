import 'package:film_checker/models/video.dart';
import 'package:film_checker/views/pages/anime_page/youtube_video_player_page_view.dart';
import 'package:film_checker/views/support/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnimeVideoBlock extends StatelessWidget {
  final Video video;

  const AnimeVideoBlock({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return YoutubeVideoPlayerPageView(
                youtubeUrl: video.youtubeId,
                title: video.title,
              );
            },
          ),
        ).then(
          (value) => SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        height: MediaQuery.of(context).size.height * .21,
        width: MediaQuery.of(context).size.width * .7,
        child: Stack(
          children: [
            SizedBox.expand(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CustomNetworkImage(path: video.coverImage),
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
                width: 80,
                height: 50,
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
