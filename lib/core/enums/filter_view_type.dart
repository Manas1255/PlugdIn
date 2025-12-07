enum FilterViewType {
  venuesFilterView,
  caterersFilterView,
  photographersFilterView,
  eventPlannersFilterView,
  videographersFilterView,
  decoratorsFilterView,
  musiciansFilterView,
  normalDisplayView,
}

const Map<FilterViewType, String> _filterViewDisplayNames = {
  FilterViewType.venuesFilterView: 'Venues',
  FilterViewType.caterersFilterView: 'Caterers',
  FilterViewType.photographersFilterView: 'Photographers',
  FilterViewType.eventPlannersFilterView: 'Event Planners',
  FilterViewType.videographersFilterView: 'Videographers',
  FilterViewType.decoratorsFilterView: 'Decorators',
  FilterViewType.musiciansFilterView: 'Musicians',
  FilterViewType.normalDisplayView: 'Normal Display',
};

extension FilterViewTypeParsing on String {
  FilterViewType toEnum() {
    final normalizedValue = trim().toLowerCase();
    try {
      return FilterViewType.values.firstWhere(
        (element) =>
            element.toName().toLowerCase() == normalizedValue ||
            element.toDisplayName().toLowerCase() == normalizedValue,
      );
    } on StateError {
      throw ArgumentError('Invalid FilterViewType value: $this');
    }
  }
}

extension FilterViewTypeFormatting on FilterViewType {
  String toName() => name;

  String toDisplayName() => _filterViewDisplayNames[this] ?? name;
}

