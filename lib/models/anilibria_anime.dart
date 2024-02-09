import 'package:film_checker/models/anime.dart';

class AnilibriaAnime extends AnimeParent {
  static const _posterStartUrl = 'https://static-libria.weekstorm.one';

  AnilibriaAnime({
    required super.title,
    required super.imagePath,
  });

  factory AnilibriaAnime.fromJson(Map json) {
    AnilibriaAnime result = AnilibriaAnime(
      title: json['names']['en'],
      imagePath: _posterStartUrl + json['posters']['original']['url'],
    );

    result.series = json['player']['playlist'];
    result.libriaId = json['id'];
    result.title = json['names']['en'];

    return result;
  }
}
