class Pagination {
  bool hasNextPage;
  int currentPage;
  int lastPage;

  int wholeAmount;

  Pagination({
    required this.hasNextPage,
    required this.currentPage,
    required this.lastPage,
    required this.wholeAmount,
  });

  factory Pagination.fromJson(Map json) {
    return Pagination(
      hasNextPage: json['has_next_page'],
      currentPage: json['current_page'],
      lastPage: json['last_visible_page'],
      wholeAmount: json['items']['total'],
    );
  }

  factory Pagination.empty() {
    return Pagination(
      hasNextPage: false,
      currentPage: -1,
      lastPage: -1,
      wholeAmount: 0,
    );
  }
}
