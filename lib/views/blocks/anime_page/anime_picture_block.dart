import 'package:film_checker/views/fullscreen_gallery_page_view.dart';
import 'package:film_checker/views/support/custom_network_image.dart';
import 'package:flutter/material.dart';

class AnimePictureBlock extends StatelessWidget {
  final String path;
  final int imageIndex;
  final List<String> imagePaths;

  const AnimePictureBlock({
    super.key,
    required this.path,
    required this.imageIndex,
    required this.imagePaths,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return FullScreenGalleryPageView(
                currentIndex: imageIndex,
                imagePaths: imagePaths,
              );
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        width: MediaQuery.of(context).size.width * .5,
        child: SizedBox.expand(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CustomNetworkImage(path: path),
          ),
        ),
      ),
    );
  }
}
