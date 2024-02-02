import 'dart:convert';

import 'package:film_checker/models/anime.dart';
import 'package:film_checker/models/character.dart';
import 'package:film_checker/models/review.dart';
import 'package:film_checker/models/picture.dart';
import 'package:film_checker/models/video.dart';
import 'package:http/http.dart' as http;

class Api {
  static const _topAnimeUrl = 'https://api.jikan.moe/v4/top/anime';
  static const _randomAnimeUrl = 'https://api.jikan.moe/v4/random/anime';
  static const _seasonalAnimeUrl = 'https://api.jikan.moe/v4/seasons/';

  static const _libriaAnime = 'https://api.anilibria.tv/v2.13/getTitle?code=';

  static const _animeUrl = 'https://api.jikan.moe/v4/anime';

  Future<List<Anime>> getTopAnimeFiltered(int limit, String filterType) async {
    List<Anime> result = [];

    final response = await http
        .get(Uri.parse('$_topAnimeUrl?filter=$filterType&limit=$limit'));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['data'] as List;

      for (var data in decodedData) {
        if (data['images']['jpg'] == null ||
            data['synopsis'] == null ||
            data['genres'].isEmpty ||
            data['type'] == null) {
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
        result.add(Anime.fromJson(data, id));
        print('took');
      }

      return result;
    } else {
      return await getRandomAnime(limit);
    }
  }

  Future<List<Anime>> getSeasonalAnime(int limit) async {
    List<Anime> result = [];

    final response = await http
        .get(Uri.parse('$_seasonalAnimeUrl${DateTime.now().year}/winter'));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['data'] as List;

      for (var data in decodedData) {
        if (data['images']['jpg'] == null ||
            data['synopsis'] == null ||
            data['genres'].isEmpty ||
            data['type'] == null) {
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
        result.add(Anime.fromJson(data, id));
        print('took');
      }

      return result;
    } else {
      return await getRandomAnime(limit);
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
        print('took');
      } else {
        amount++;
        print('skipped');
        continue;
      }
    }

    return result;
  }

  Future<List<Character>> getCharacters(int id) async {
    List<Character> result = [];

    final response = await http.get(Uri.parse('$_animeUrl/$id/characters'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;

      for (var obj in data) {
        result.add(Character.fromJson(obj));
      }

      return result;
    } else {
      return [];
    }
  }

  Future<List<Review>> getReviews(int id) async {
    List<Review> result = [];

    final response = await http.get(Uri.parse('$_animeUrl/$id/reviews'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;

      for (var obj in data) {
        result.add(Review.fromJson(obj));
      }

      return result;
    } else {
      return [];
    }
  }

  Future<List> getRecommendations(int id) async {
    final response =
        await http.get(Uri.parse('$_animeUrl/$id/recommendations'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;

      return data;
    } else {
      return [];
    }
  }

  Future<List<Video>> getVideos(int id) async {
    List<Video> result = [];

    final response = await http.get(Uri.parse('$_animeUrl/$id/videos'));
    if (response.statusCode == 200) {
      final promoData = json.decode(response.body)['data']['promo'] as List;
      final musicVideosData =
          json.decode(response.body)['data']['music_videos'] as List;

      for (var obj in promoData) {
        result.add(
          Video.fromJson(obj, true),
        );
      }

      for (var obj in musicVideosData) {
        result.add(
          Video.fromJson(obj, false),
        );
      }

      return result;
    } else {
      return [];
    }
  }

  Future<List<Picture>> getPictures(int id) async {
    List<Picture> result = [];

    final response = await http.get(Uri.parse('$_animeUrl/$id/pictures'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List;

      for (var obj in data) {
        if (obj['jpg'] != null) {
          result.add(Picture.fromJson(obj));
        }
      }
    }

    return result;
  }
}

String processTitleForLibria(String title) {
  String result = title.toLowerCase();
  result = result.replaceAll(' ', '-');
  result = result.replaceAll(';', '');

  return result;
}
