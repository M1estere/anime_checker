import 'dart:convert';

import 'package:film_checker/models/anilibria_anime.dart';
import 'package:film_checker/models/anime.dart';
import 'package:film_checker/models/character.dart';
import 'package:film_checker/models/picture.dart';
import 'package:film_checker/models/review.dart';
import 'package:film_checker/models/video.dart';

import 'package:http/http.dart' as http;

class AnimeController {
  static const _animeUrl = 'https://api.jikan.moe/v4/anime';

  static const _searchUrl = 'https://api.jikan.moe/v4/anime?q=';

  Future setupAnimeFields(AnilibriaAnime anime) async {
    final response = await http.get(Uri.parse(_searchUrl + anime.title));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;

      if (data.isNotEmpty) {
        anime.malId = data[0]['mal_id'];
        anime.originalTitle = data[0]['title_japanese'];
        anime.score = data[0]['score'];
        anime.scoredBy = data[0]['scored_by'];
        anime.synopsis = data[0]['synopsis'] != null
            ? processSynopsis(data[0]['synopsis'].toString())
            : '';
        anime.status = data[0]['status'];
        anime.genres = data[0]['rating'] != null
            ? processGenres(data[0]['genres'], data[0]['rating'])
            : data[0]['genres'];
        anime.type = data[0]['type'];
        anime.episodes = data[0]['episodes'] ?? 0;
        anime.midDuration = processMidDuration(data[0]['duration']);
      }
    }
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

  Future<List<Video>> getVideos(int id) async {
    List<Video> result = [];

    final response = await http.get(Uri.parse('$_animeUrl/$id/videos'));
    if (response.statusCode == 200) {
      final promoData = json.decode(response.body)['data']['promo'] as List;
      final musicVideosData =
          json.decode(response.body)['data']['music_videos'] as List;

      for (var obj in promoData) {
        if (obj['trailer']['youtube_id'] == null) {
          continue;
        }

        result.add(
          Video.fromJson(obj, true),
        );
      }

      for (var obj in musicVideosData) {
        if (obj['video']['youtube_id'] == null) {
          continue;
        }

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
