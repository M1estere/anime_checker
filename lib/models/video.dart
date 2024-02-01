class Video {
  String title;
  String youtubeId;
  String url;
  String coverImage;

  Video({
    required this.title,
    required this.youtubeId,
    required this.url,
    required this.coverImage,
  });

  factory Video.fromJson(Map json, bool checkTrailer) {
    return Video(
      title: json['title'],
      youtubeId: checkTrailer
          ? json['trailer']['youtube_id']
          : json['video']['youtube_id'],
      url: checkTrailer ? json['trailer']['url'] : json['video']['url'],
      coverImage: checkTrailer
          ? json['trailer']['images']['large_image_url']
          : json['video']['images']['large_image_url'],
    );
  }
}
