class Picture {
  String path;

  Picture({
    required this.path,
  });

  factory Picture.fromJson(Map json) {
    return Picture(path: json['jpg']['large_image_url']);
  }
}
