import 'dart:convert';

import 'package:film_checker/models/anime.dart';
import 'package:film_checker/models/genre.dart';
import 'package:film_checker/models/pagination.dart';

import 'package:http/http.dart' as http;

class GenresController {
  static const _genresAnimeUrl = 'https://api.jikan.moe/v4/genres/anime';
  static const _animeListByGenre =
      'https://api.jikan.moe/v4/anime?order_by=popularity&limit=25&genres=';

  Future<List<Genre>> getAllGenres() async {
    List<Genre> result = [];

    final response = await http.get(Uri.parse(_genresAnimeUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List;

      for (var obj in data) {
        result.add(Genre.fromJson(obj));
      }
    }

    return result;
  }

  Future<List<Anime>> getAnimeListByGenre(String genre, int pageNum) async {
    List<Anime> result = [];

    final response =
        await http.get(Uri.parse('$_animeListByGenre$genre&page=$pageNum'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List;

      for (var obj in data) {
        if (obj['images']['jpg'] == null ||
            obj['synopsis'] == null ||
            obj['genres'].isEmpty ||
            obj['type'] == null) {
          continue;
        }

        result.add(Anime.fromJson(obj, -1));
      }
    }

    return result;
  }

  Future<Pagination> getCurrentGenrePagination(
      String genre, int pageNum) async {
    Pagination result = Pagination.empty();

    final response =
        await http.get(Uri.parse('$_animeListByGenre$genre&page=$pageNum'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['pagination'];

      result = Pagination.fromJson(data);
    }

    return result;
  }
}
