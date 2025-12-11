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
    int _asInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is double) return value.toInt();
      return int.tryParse(value.toString()) ?? 0;
    }

    bool _asBool(dynamic value) {
      if (value is bool) return value;
      if (value is num) return value != 0;
      return value?.toString().toLowerCase() == 'true';
    }

    return PaginationModel(
      currentPage: _asInt(json['currentPage']),
      totalPages: _asInt(json['totalPages']),
      totalItems: _asInt(json['totalItems']),
      itemsPerPage: _asInt(json['itemsPerPage']),
      hasNextPage: _asBool(json['hasNextPage']),
      hasPrevPage: _asBool(json['hasPrevPage']),
      nextPage: json['nextPage'] != null ? _asInt(json['nextPage']) : null,
      prevPage: json['prevPage'] != null ? _asInt(json['prevPage']) : null,
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
