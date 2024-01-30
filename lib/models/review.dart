class Review {
  int malId;
  String date;
  String review;

  int score;
  String nickname;
  String userImagePath;

  Review({
    required this.malId,
    required this.date,
    required this.review,
    required this.score,
    required this.nickname,
    required this.userImagePath,
  });

  factory Review.fromJson(Map json) {
    return Review(
      malId: json['mal_id'],
      date: json['date'],
      review: json['review'],
      score: json['score'],
      nickname: json['user']['username'],
      userImagePath: json['user']['images']['jpg']['image_url'],
    );
  }
}
