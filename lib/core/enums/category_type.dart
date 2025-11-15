enum CategoryType {
  all,
  venue,
  caterer,
  photographer,
  eventPlanner,
  videographer,
  decorator,
  musician,
}

extension CategoryTypeExtension on CategoryType {
  String toName() {
    return toDisplayName().toLowerCase();
  }

  String toDisplayName() {
    switch (this) {
      case CategoryType.venue:
        return 'Venue';
      case CategoryType.caterer:
        return 'Caterer';
      case CategoryType.photographer:
        return 'Photographer';
      case CategoryType.eventPlanner:
        return 'Event Planner';
      case CategoryType.videographer:
        return 'Videographer';
      case CategoryType.decorator:
        return 'Decorator';
      case CategoryType.musician:
        return 'Musician';
      case CategoryType.all:
        return 'All';
    }
  }

  static CategoryType? toEnum(String name) {
    try {
      final normalizedName = name.toLowerCase();
      return CategoryType.values.firstWhere(
        (category) => category.name.toLowerCase() == normalizedName,
      );
    } catch (e) {
      return null;
    }
  }
}
