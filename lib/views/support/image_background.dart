import 'dart:ui';

import 'package:flutter/material.dart';

class ImageBackground extends StatelessWidget {
  final Image image;

  const ImageBackground({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SizedBox.expand(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 5,
                sigmaY: 5,
              ),
              child: image,
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.5),
            ),
          ),
        ],
      ),
    );
  }
}
