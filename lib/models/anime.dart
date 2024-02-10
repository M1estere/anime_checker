class AnimeParent {
  String title;
  String originalTitle = '';

  int malId = -1;
  int libriaId = -1;

  List genres = [];
  List? series;

  double score = 0.0;
  int scoredBy = 0;
  String synopsis = '';

  String status = '';
  String type = '';

  int episodes = 0;
  String midDuration = '';

  bool checkedLibria = false;

  String imagePath;

  AnimeParent({
    required this.title,
    required this.imagePath,
  });
}

class Anime extends AnimeParent {
  Anime({
    required super.title,
    required super.imagePath,
  });

  factory Anime.fromJson(Map json, int libriaId) {
    Anime result = Anime(
      title: json['title'].trim() ?? '',
      imagePath: json['images']['jpg']['large_image_url'] ?? '',
    );

    result.score = json['score'] == null
        ? 0.0
        : double.parse(json['score'].toStringAsFixed(1));
    result.scoredBy = json['scored_by'] ?? 0;
    result.synopsis = json['synopsis'] != null
        ? processSynopsis(json['synopsis'].toString())
        : '';
    result.status = json['status'];
    result.genres = json['rating'] != null
        ? processGenres(json['genres'], json['rating'])
        : json['genres'];
    result.type = json['type'];
    result.episodes = json['episodes'] ?? 0;
    result.midDuration = processMidDuration(json['duration']);

    result.originalTitle = json['title_japanese'] ?? '';
    result.malId = json['mal_id'] ?? 0;
    result.libriaId = libriaId;

    return result;
  }

  factory Anime.createEmpty() {
    return Anime(
      title: '',
      imagePath: '',
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
