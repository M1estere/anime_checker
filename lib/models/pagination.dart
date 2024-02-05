class Pagination {
  bool hasNextPage;
  int currentPage;
  int lastPage;

  Pagination({
    required this.hasNextPage,
    required this.currentPage,
    required this.lastPage,
  });

  factory Pagination.fromJson(Map json) {
    return Pagination(
      hasNextPage: json['has_next_page'],
      currentPage: json['current_page'],
      lastPage: json['last_visible_page'],
    );
  }

  factory Pagination.empty() {
    return Pagination(
      hasNextPage: false,
      currentPage: -1,
      lastPage: -1,
    );
  }
}
