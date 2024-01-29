class Movie {
  String title;
  int episodes;
  String originalTitle;
  String synopsis;

  Map images;
  Map trailer;

  double score;
  int scoredBy;

  Movie({
    required this.title,
    required this.episodes,
    required this.originalTitle,
    required this.synopsis,
    required this.images,
    required this.trailer,
    required this.score,
    required this.scoredBy,
  });

  factory Movie.fromJson(Map json) {
    return Movie(
      title: json['title'] ?? '',
      originalTitle: json['title_japanese'] ?? '',
      episodes: json['episodes'] ?? 0,
      synopsis: json['synopsis'] ?? '',
      images: json['images'] ?? Map,
      trailer: json['trailer'] ?? Map,
      score: json['score'] ?? 0.0,
      scoredBy: json['scored_by'] ?? 0,
    );
  }
}
