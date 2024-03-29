import 'package:film_checker/models/character.dart';
import 'package:film_checker/views/pages/anime_page/fullscreen_gallery_page_view.dart';
import 'package:film_checker/views/support/custom_network_image.dart';
import 'package:flutter/material.dart';

class CharacterInfoBlock extends StatelessWidget {
  final Character character;

  const CharacterInfoBlock({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .12,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return FullScreenGalleryPageView(
                      currentIndex: 0,
                      imagePaths: [
                        character.imagePath,
                      ],
                    );
                  },
                ));
              },
              child: SizedBox(
                height: double.infinity,
                width: MediaQuery.of(context).size.width * .2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CustomNetworkImage(path: character.imagePath),
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
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'ID: ${character.malId.toString()}',
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
