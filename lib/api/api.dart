import 'dart:convert';

import 'package:film_checker/models/movie.dart';
import 'package:http/http.dart' as http;

class Api {
  static const _randomAnimeUrl = 'https://api.jikan.moe/v4/random/anime';

  Future<List<Movie>> getRandomAnime(int amount) async {
    List<Movie> result = [];

    for (int i = 0; i < amount; i++) {
      final response = await http.get(Uri.parse(_randomAnimeUrl));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body)['data'] as Map;
        print(decodedData);

        result.add(Movie.fromJson(decodedData));
      } else {
        print('Something happened');
        continue;
      }
    }

    return result;
  }
}
