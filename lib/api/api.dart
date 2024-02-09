import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:film_checker/models/anime.dart';
import 'package:http/http.dart' as http;

class Api {
  static const _topAnimeUrl = 'https://api.jikan.moe/v4/top/anime';
  static const _randomAnimeUrl = 'https://api.jikan.moe/v4/random/anime';

  static const _libriaAnime =
      'https://api.anilibria.tv/v2.13/getTitle?filter=id,code,player&playlist_type=array&code=';

  Future<List<Anime>> getTopAnimeFiltered(String filterType) async {
    List<Anime> result = [];

    final response = await http.get(Uri.parse(
        '$_topAnimeUrl?filter=$filterType&page=${Random().nextInt(40) + 1}'));
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
      print('test 2');
      return await getRandomAnime(15);
    }
  }

  Future<(int, List)> getLibriaCode(String title) async {
    title = processTitleForLibria(title);

    try {
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

      print('Libria id: $id');
      return (id, playlist);
    } on HandshakeException catch (e) {
      print('Error: $e');
      return (-1, []);
    }
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
  result = result.replaceAll('!', '');
  result = result.replaceAll(',', '');
  result = result.replaceAll('.', '');
  result = result.replaceAll('`', '');

  result = result.replaceAll('nd-season', '');

  return result;
}

String getSeason(DateTime date) {
  const List<String> seasons = ['Winter', 'Spring', 'Summer', 'Autumn'];
  int month = date.month;
  return seasons[(month % 12 ~/ 3)];
}
