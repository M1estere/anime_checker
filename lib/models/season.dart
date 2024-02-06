class Season {
  int year;
  String title;

  Season({
    required this.year,
    required this.title,
  });

  factory Season.fromJson(int year, String season) {
    return Season(year: year, title: season);
  }
}
