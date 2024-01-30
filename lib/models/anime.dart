import 'package:film_checker/api/api.dart';

class Anime {
  int malId;
  String title;
  int episodes;
  String originalTitle;
  String synopsis;

  Map images;
  Map trailer;

  double score;
  int scoredBy;

  int libriaId;

  Anime({
    required this.malId,
    required this.title,
    required this.episodes,
    required this.originalTitle,
    required this.synopsis,
    required this.images,
    required this.trailer,
    required this.score,
    required this.scoredBy,
    required this.libriaId,
  });

  factory Anime.fromJson(Map json, int libriaId) {
    return Anime(
      malId: json['mal_id'] ?? 0,
      title: json['title'] ?? '',
      originalTitle: json['title_japanese'] ?? '',
      episodes: json['episodes'] ?? 0,
      synopsis: json['synopsis'] != null ? json['synopsis'].toString() : '',
      images: json['images'] ?? Map,
      trailer: json['trailer'] ?? Map,
      score: json['score'] != null ? json['score'].toDouble() : 0.0,
      scoredBy: json['scored_by'] ?? 0,
      libriaId: libriaId,
    );
  }
}

String processSynopsis(String synopsis) {
  String result = synopsis.substring(0, synopsis.lastIndexOf('.') + 1);

  return result;
}
