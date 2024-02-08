class Anime {
  int malId;
  String title;
  int episodes;
  String originalTitle;
  String synopsis;

  String status;
  String type;
  String midDuration;

  Map images;
  Map trailer;

  double score;
  int scoredBy;

  int libriaId;

  List genres;

  List? series;

  bool checked = false;

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
    required this.genres,
    required this.status,
    required this.midDuration,
    required this.type,
  });

  factory Anime.fromJson(Map json, int libriaId) {
    return Anime(
      malId: json['mal_id'] ?? 0,
      title: json['title'].trim() ?? '',
      originalTitle: json['title_japanese'] ?? '',
      episodes: json['episodes'] ?? 0,
      synopsis: json['synopsis'] != null
          ? processSynopsis(json['synopsis'].toString())
          : '',
      images: json['images'] ?? Map,
      trailer: json['trailer'] ?? Map,
      score: json['score'] != null ? json['score'].toDouble() : 0.0,
      scoredBy: json['scored_by'] ?? 0,
      libriaId: libriaId,
      genres: json['rating'] != null
          ? processGenres(json['genres'], json['rating'])
          : json['genres'],
      status: json['status'],
      midDuration: processMidDuration(json['duration']),
      type: json['type'],
    );
  }

  factory Anime.createEmpty() {
    return Anime(
      malId: -1,
      title: '',
      episodes: -1,
      originalTitle: '',
      synopsis: '',
      images: {},
      trailer: {},
      score: -1,
      scoredBy: -1,
      libriaId: -1,
      genres: List.empty(),
      status: '',
      midDuration: '',
      type: '',
    );
  }
}

List processGenres(List genres, String toAdd) {
  Map add = {'name': toAdd.split(' ')[0]};

  List result = genres;
  result.add(add);

  return result;
}

String processSynopsis(String synopsis) {
  String result = synopsis.substring(0, synopsis.lastIndexOf('.') + 1);

  return result;
}

String processMidDuration(String duration) {
  String result = duration;

  List<String> temp = result.split(' ');
  if (temp.length > 2) {
    result = ' | ${temp.sublist(0, 2).join(' ')}';
  } else {
    result = '';
  }

  return result;
}
