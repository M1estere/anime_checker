import 'dart:convert';

import 'package:film_checker/api/api.dart';
import 'package:film_checker/models/anime.dart';
import 'package:film_checker/models/pagination.dart';
import 'package:film_checker/models/season.dart';

import 'package:http/http.dart' as http;

class SeasonsController {
  static const _seasonalAnimeUrl = 'https://api.jikan.moe/v4/seasons/';

  Future<List<Anime>> getSeasonalAnime(int pageNum, Season season) async {
    List<Anime> result = [];

    print(Uri.parse(
        '$_seasonalAnimeUrl${season.year}/${season.title.toLowerCase()}?page=$pageNum'));
    final response = await http.get(Uri.parse(
        '$_seasonalAnimeUrl${season.year}/${season.title.toLowerCase()}?page=$pageNum'));
    if (response.statusCode == 200) {
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

      return result;
    } else {
      return await Api().getRandomAnime(15);
    }
  }

  Future<List<Season>> getAllSeasons() async {
    List<Season> result = [];

    final response = await http.get(Uri.parse(_seasonalAnimeUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List;

      for (var obj in data) {
        for (var element in obj['seasons']) {
          result.add(Season.fromJson(obj['year'], element));
        }
      }
    }

    return result;
  }

  Future<Pagination> getCurrentSeasonPagination(
      Season season, int pageNum) async {
    Pagination result = Pagination.empty();

    final response = await http.get(Uri.parse(
        '$_seasonalAnimeUrl${season.year}/${season.title.toLowerCase()}?page=$pageNum'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['pagination'];

      result = Pagination.fromJson(data);
    }

    return result;
  }
}
