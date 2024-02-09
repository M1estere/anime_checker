import 'package:film_checker/models/anime.dart';
import 'package:film_checker/views/pages/anime_page/anime_page_view.dart';
import 'package:film_checker/views/support/custom_network_image.dart';
import 'package:flutter/material.dart';

class SearchResultBlock extends StatefulWidget {
  final Anime anime;

  const SearchResultBlock({
    super.key,
    required this.anime,
  });

  @override
  State<SearchResultBlock> createState() => _SearchResultBlockState();
}

class _SearchResultBlockState extends State<SearchResultBlock> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => AnimePageView(
              path: widget.anime.imagePath,
              image: Image.network(
                widget.anime.imagePath,
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
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        color: Colors.white.withOpacity(0),
        width: double.infinity,
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CustomNetworkImage(
                      path: widget.anime.imagePath,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.anime.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.anime.originalTitle,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      widget.anime.libriaId != -1
                          ? Text(
                              'Watch'.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : const Center(),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .25,
              child: Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    size: 30,
                    color: Colors.yellow,
                  ),
                  FittedBox(
                    child: Text(
                      '${widget.anime.score}/10',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
