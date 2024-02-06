import 'package:film_checker/models/anime.dart';
import 'package:film_checker/views/anime_page_view.dart';
import 'package:film_checker/views/support/custom_network_image.dart';
import 'package:flutter/material.dart';

class AnimeBigBlock extends StatefulWidget {
  final Anime anime;

  const AnimeBigBlock({
    super.key,
    required this.anime,
  });

  @override
  State<AnimeBigBlock> createState() => _AnimeBigBlockState();
}

class _AnimeBigBlockState extends State<AnimeBigBlock> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => AnimePageView(
              animeImage: Image.network(
                widget.anime.images['jpg']['large_image_url'],
                fit: BoxFit.cover,
              ),
              anime: widget.anime,
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
                  tag: 'animeImage${widget.anime.malId}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CustomNetworkImage(
                        path: widget.anime.images['jpg']['large_image_url']),
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
          widget.anime.libriaId != -1
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                    top: 5,
                  ),
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
                )
              : const Center(),
        ],
      ),
    );
  }
}