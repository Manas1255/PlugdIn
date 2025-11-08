class PaginationModel {
  const PaginationModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.hasNextPage,
    required this.hasPrevPage,
    this.nextPage,
    this.prevPage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
      totalItems: json['totalItems'] as int,
      itemsPerPage: json['itemsPerPage'] as int,
      hasNextPage: json['hasNextPage'] as bool,
      hasPrevPage: json['hasPrevPage'] as bool,
      nextPage: json['nextPage'] as int?,
      prevPage: json['prevPage'] as int?,
    );
  }
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final bool hasNextPage;
  final bool hasPrevPage;
  final int? nextPage;
  final int? prevPage;

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'totalPages': totalPages,
      'totalItems': totalItems,
      'itemsPerPage': itemsPerPage,
      'hasNextPage': hasNextPage,
      'hasPrevPage': hasPrevPage,
      'nextPage': nextPage,
      'prevPage': prevPage,
    };
  }

  @override
  String toString() {
    return 'PaginationModel(currentPage: $currentPage, totalPages: $totalPages, totalItems: $totalItems, itemsPerPage: $itemsPerPage, hasNextPage: $hasNextPage, hasPrevPage: $hasPrevPage, nextPage: $nextPage, prevPage: $prevPage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaginationModel &&
        other.currentPage == currentPage &&
        other.totalPages == totalPages &&
        other.totalItems == totalItems &&
        other.itemsPerPage == itemsPerPage &&
        other.hasNextPage == hasNextPage &&
        other.hasPrevPage == hasPrevPage &&
        other.nextPage == nextPage &&
        other.prevPage == prevPage;
  }

  @override
  int get hashCode {
    return currentPage.hashCode ^
        totalPages.hashCode ^
        totalItems.hashCode ^
        itemsPerPage.hashCode ^
        hasNextPage.hashCode ^
        hasPrevPage.hashCode ^
        nextPage.hashCode ^
        prevPage.hashCode;
  }
}
