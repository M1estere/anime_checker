import 'package:flutter/material.dart';

class AnimePictureBlock extends StatelessWidget {
  final String path;

  const AnimePictureBlock({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: MediaQuery.of(context).size.width * .5,
      child: SizedBox.expand(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            path,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
