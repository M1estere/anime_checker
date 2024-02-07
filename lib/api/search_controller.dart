import 'dart:convert';

import 'package:film_checker/models/anime.dart';
import 'package:film_checker/models/pagination.dart';
import 'package:http/http.dart' as http;

class SearchController {
  static const _searchAnimeUrl = 'https://api.jikan.moe/v4/anime?';

  Future<(List<Anime>, Pagination)> getAnimeBySearch(
    List<String> incGenreIdList,
    List<String> excGenreIdList,
    String query,
    int numPage,
  ) async {
    List<Anime> result = [];
    Pagination pagination = Pagination.empty();

    final response = await http.get(Uri.parse(
        '${_searchAnimeUrl}genres=${incGenreIdList.join(',')}&genres_exclude=${excGenreIdList.join(',')}&q=$query&page=$numPage'));

    if (response.statusCode == 200) {
      final decodedPagination = json.decode(response.body)['pagination'] as Map;
      final decodedData = json.decode(response.body)['data'] as List;

      for (var data in decodedData) {
        if (data['images']['jpg'] == null ||
            data['synopsis'] == null ||
            data['genres'].isEmpty ||
            data['type'] == null) {
          continue;
        }

        int id = -1;
        result.add(Anime.fromJson(data, id));
      }

      pagination = Pagination.fromJson(decodedPagination);
    }

    return (result, pagination);
  }
}
