import 'dart:convert';

import 'package:film_checker/models/anime.dart';
import 'package:http/http.dart' as http;

class Api {
  static const _topAnimeUrl = 'https://api.jikan.moe/v4/top/anime';
  static const _randomAnimeUrl = 'https://api.jikan.moe/v4/random/anime';

  static const _libriaAnime =
      'https://api.anilibria.tv/v2.13/getTitle?playlist_type=array&code=';

  Future<List<Anime>> getTopAnimeFiltered(String filterType) async {
    List<Anime> result = [];

    final response =
        await http.get(Uri.parse('$_topAnimeUrl?filter=$filterType'));
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
      return await getRandomAnime(15);
    }
  }

  Future<(int, List)> getLibriaCode(String title) async {
    title = processTitleForLibria(title);

    final libriaResponse = await http.get(Uri.parse(_libriaAnime + title));
    int id = -1;
    List playlist = [];
    if (libriaResponse.statusCode == 200) {
      final decoded = json.decode(libriaResponse.body) as Map;
      if (decoded.containsKey('error')) {
      } else {
        id = decoded['id'];
        playlist = decoded['player']['playlist'];
      }
    }

    return (id, playlist);
  }

  Future<List<Anime>> getRandomAnime(int amount) async {
    List<Anime> result = [];

    for (int i = 0; i < amount; i++) {
      final response = await http.get(Uri.parse(_randomAnimeUrl));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body)['data'] as Map;

        if (decodedData['images']['jpg'] == null ||
            decodedData['synopsis'] == null ||
            decodedData['genres'].isEmpty ||
            decodedData['type'] == null) {
          amount++;
          continue;
        }

        // final libriaResponse = await http.get(Uri.parse(
        //     _libriaAnime + processTitleForLibria(decodedData['title']).trim()));

        // int id = -1;
        // if (libriaResponse.statusCode == 200) {
        //   print(libriaResponse.body);
        //   final decoded = json.decode(libriaResponse.body) as Map;
        //   if (decoded.containsKey('error')) {
        //   } else {
        //     id = decoded['id'];
        //   }
        // }

        int id = -1;
        result.add(Anime.fromJson(decodedData, id));
      } else {
        amount++;
        continue;
      }
    }

    return result;
  }
}

String processTitleForLibria(String title) {
  String result = title.toLowerCase();
  result = result.replaceAll(' ', '-');
  result = result.replaceAll(';', '');
  result = result.replaceAll(':', '');
  result = result.replaceAll('nd-season', '');

  return result;
}
