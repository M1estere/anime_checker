import 'dart:convert';
import 'dart:io';

import 'package:film_checker/models/anilibria_anime.dart';
import 'package:http/http.dart' as http;

class AnilibriaAnimeController {
  static const _animeUrl =
      'https://api.anilibria.tv/v2.13/getUpdates?limit=180&playlist_type=array&filter=id,code,names.en,posters,player.playlist';

  Future<List<AnilibriaAnime>> getAnilibriaTitles() async {
    List<AnilibriaAnime> result = [];

    try {
      final response = await http.get(Uri.parse(_animeUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;

        for (var obj in data) {
          result.add(AnilibriaAnime.fromJson(obj));
        }
      }
    } on HandshakeException catch (e) {
      print(e);
    }

    return result;
  }
}
