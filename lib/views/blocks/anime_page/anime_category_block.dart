import 'package:flutter/material.dart';

class AnimeCategoryBlock extends StatelessWidget {
  final Map animeGenre;

  const AnimeCategoryBlock({
    super.key,
    required this.animeGenre,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[500]!.withOpacity(.4),
      ),
      child: Text(
        animeGenre['name'],
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
