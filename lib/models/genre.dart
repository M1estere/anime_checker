class Genre {
  int id;
  String name;
  int count;

  Genre({
    required this.id,
    required this.name,
    required this.count,
  });

  factory Genre.fromJson(Map json) {
    return Genre(
      id: json['mal_id'],
      name: json['name'],
      count: json['count'],
    );
  }
}
