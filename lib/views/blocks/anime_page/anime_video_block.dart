import 'package:flutter/material.dart';

class AnimeVideoBlock extends StatelessWidget {
  final video;

  const AnimeVideoBlock({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      height: MediaQuery.of(context).size.height * .21,
      width: MediaQuery.of(context).size.width * .7,
      child: Stack(
        children: [
          SizedBox.expand(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                video.coverImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Center(
            child: Icon(
              Icons.play_circle_filled_sharp,
              color: Colors.red,
              size: 75,
            ),
          ),
        ],
      ),
    );
  }
}
