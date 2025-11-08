enum CategoryType {
  none,
  venues,
  caterers,
  photographers,
  eventPlanners,
  videographers,
  decorators,
  musicians,
}

extension CategoryTypeExtension on CategoryType {
  String toName() {
    return name;
  }

  String toDisplayName() {
    switch (this) {
      case CategoryType.venues:
        return 'Venues';
      case CategoryType.caterers:
        return 'Caterers';
      case CategoryType.photographers:
        return 'Photographers';
      case CategoryType.eventPlanners:
        return 'Event Planners';
      case CategoryType.videographers:
        return 'Videographers';
      case CategoryType.decorators:
        return 'Decorators';
      case CategoryType.musicians:
        return 'Musicians';
      case CategoryType.none:
        return 'None';
    }
  }

  static CategoryType? toEnum(String name) {
    try {
      return CategoryType.values.firstWhere(
        (category) => category.name == name,
      );
    } catch (e) {
      return null;
    }
  }
}
