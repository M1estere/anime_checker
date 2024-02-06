import 'package:film_checker/models/character.dart';
import 'package:film_checker/views/support/custom_network_image.dart';
import 'package:flutter/material.dart';

class AnimeCharacterBlock extends StatelessWidget {
  final Character character;

  const AnimeCharacterBlock({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      height: MediaQuery.of(context).size.height * .15,
      width: MediaQuery.of(context).size.height * .12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .11,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CustomNetworkImage(path: character.imagePath),
            ),
          ),
          FittedBox(
            child: Text(
              character.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
