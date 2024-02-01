import 'package:film_checker/views/anime_page_view.dart';
import 'package:flutter/material.dart';

class WideBlock extends StatelessWidget {
  final anime;

  const WideBlock({
    super.key,
    required this.anime,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AnimePageView(
              animeImage: Image.network(
                anime.images['jpg']['large_image_url'],
                fit: BoxFit.cover,
              ),
              anime: anime,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            width: MediaQuery.of(context).size.width * .6,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .16,
                  child: //Hero(
                      //tag: 'animeImage${anime.malId}',
                      //child: ClipRRect(
                      ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      anime.images['jpg']['large_image_url'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    anime.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                )
              ],
            ),
          ),
          anime.libriaId != -1
              ? //Hero(
              //tag: 'animeAvailable${anime.malId}',
              //child: Padding(
              Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                    top: 5,
                  ),
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  //),
                )
              : const Center(),
        ],
      ),
    );
  }
}
