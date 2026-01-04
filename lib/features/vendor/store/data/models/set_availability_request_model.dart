class SetAvailabilityRequestModel {
  const SetAvailabilityRequestModel({
    required this.effectiveFrom,
    this.effectiveTo,
    required this.weekly,
  });

  final String effectiveFrom;
  final String? effectiveTo;
  final List<WeeklyAvailabilityModel> weekly;

  Map<String, dynamic> toJson() {
    return {
      'effectiveFrom': effectiveFrom,
      if (effectiveTo != null) 'effectiveTo': effectiveTo,
      'weekly': weekly.map((e) => e.toJson()).toList(),
    };
  }
}

class WeeklyAvailabilityModel {
  const WeeklyAvailabilityModel({
    required this.dayOfWeek,
  });

  final String dayOfWeek;

  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
    };
  }
}

