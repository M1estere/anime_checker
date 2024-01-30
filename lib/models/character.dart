class Character {
  int malId;
  String imagePath;
  String name;

  Character({
    required this.malId,
    required this.imagePath,
    required this.name,
  });

  factory Character.fromJson(Map json) {
    return Character(
      malId: json['character']['mal_id'],
      imagePath: json['character']['images']['jpg']['image_url'],
      name: json['character']['name'],
    );
  }
}
