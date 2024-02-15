import 'package:film_checker/models/season.dart';
import 'package:film_checker/support/string_extension.dart';
import 'package:film_checker/views/pages/genre_season_anime_page_view.dart';
import 'package:flutter/material.dart';

class SeasonBlock extends StatelessWidget {
  final Season season;

  const SeasonBlock({
    super.key,
    required this.season,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).canvasColor.withOpacity(.15),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return GenreSeasonAnimePageView(
                  sectionName: '${season.year} ${season.title}',
                  genreNumber: -1,
                  type: 1,
                  season: season,
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${season.year} - ${season.title.capitalize()}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
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
