class SetAvailabilityRequestModel {
  const SetAvailabilityRequestModel({
    required this.effectiveFrom,
    required this.effectiveTo,
  });

  final String effectiveFrom;
  final String effectiveTo;

  Map<String, dynamic> toJson() {
    return {
      'effectiveFrom': effectiveFrom,
      'effectiveTo': effectiveTo,
    };
  }
}

