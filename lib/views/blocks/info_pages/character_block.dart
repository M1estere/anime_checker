import 'package:film_checker/models/character.dart';
import 'package:flutter/material.dart';

class CharacterInfoBlock extends StatelessWidget {
  final Character character;

  const CharacterInfoBlock({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .12,
      child: Row(
        children: [
          SizedBox(
            height: double.infinity,
            width: MediaQuery.of(context).size.width * .2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                character.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'ID: ${character.malId.toString()}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}