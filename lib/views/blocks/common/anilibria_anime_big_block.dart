import 'package:film_checker/models/anilibria_anime.dart';
import 'package:film_checker/views/pages/anime_page/anime_page_view.dart';
import 'package:film_checker/views/support/custom_network_image.dart';
import 'package:flutter/material.dart';

class AnilibriaAnimeBigBlock extends StatefulWidget {
  final AnilibriaAnime anime;

  const AnilibriaAnimeBigBlock({
    super.key,
    required this.anime,
  });

  @override
  State<AnilibriaAnimeBigBlock> createState() => _AnilibriaAnimeBigBlockState();
}

class _AnilibriaAnimeBigBlockState extends State<AnilibriaAnimeBigBlock> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => AnimePageView(
              anime: widget.anime,
              image: Image.network(
                widget.anime.imagePath,
                fit: BoxFit.cover,
                key: Key(
                  widget.anime.imagePath,
                ),
                width: double.infinity,
                height: double.infinity,
              ),
              path: widget.anime.imagePath,
            ),
          ),
        )
            .then((value) {
          setState(() {});
        });
      },
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .26,
                child: Hero(
                  tag:
                      'animeImage${widget.anime.malId != -1 ? widget.anime.malId : widget.anime.libriaId}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CustomNetworkImage(
                      path: widget.anime.imagePath,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  widget.anime.title,
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
          Padding(
            padding: const EdgeInsets.only(
              left: 5,
              top: 5,
            ),
            child: Hero(
              tag:
                  'animeAvailable${widget.anime.malId != -1 ? widget.anime.malId : widget.anime.libriaId}',
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.blue,
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
            ),
          )
        ],
      ),
    );
  }
}
