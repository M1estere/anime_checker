import 'package:film_checker/models/genre.dart';
import 'package:film_checker/models/season.dart';
import 'package:film_checker/views/genre_season_anime_page_view.dart';
import 'package:flutter/material.dart';

class GenreBlock extends StatelessWidget {
  final int orderNumber;
  final Genre genre;

  const GenreBlock({
    super.key,
    required this.orderNumber,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.withOpacity(.15),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return GenreSeasonAnimePageView(
                  sectionName: genre.name.toLowerCase(),
                  genreNumber: genre.id,
                  type: 0,
                  season: Season(year: 2024, title: ''),
                );
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .07,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width * .1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        orderNumber.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          genre.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${genre.count.toString()} titles',
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
            ),
          ),
        ),
      ),
    );
  }
}
