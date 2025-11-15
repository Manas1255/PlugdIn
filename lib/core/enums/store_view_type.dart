enum StoreViewType {
  storeView,
  detailsView,
  packagesView,
  reviewsView,
}

const Map<StoreViewType, String> _storeViewDisplayNames = {
  StoreViewType.storeView: 'Store',
  StoreViewType.detailsView: 'Details',
  StoreViewType.packagesView: 'Packages',
  StoreViewType.reviewsView: 'Reviews',
};

extension StoreViewTypeParsing on String {
  StoreViewType toEnum() {
    final normalizedValue = trim().toLowerCase();
    try {
      return StoreViewType.values.firstWhere(
        (element) =>
            element.toName().toLowerCase() == normalizedValue ||
            element.toDisplayName().toLowerCase() == normalizedValue,
      );
    } on StateError {
      throw ArgumentError('Invalid StoreViewType value: $this');
    }
  }
}

extension StoreViewTypeFormatting on StoreViewType {
  String toName() => name;

  String toDisplayName() => _storeViewDisplayNames[this] ?? name;
}

