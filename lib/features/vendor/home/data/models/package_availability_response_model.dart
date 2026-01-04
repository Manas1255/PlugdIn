class PackageAvailabilityResponseModel {
  const PackageAvailabilityResponseModel({
    required this.packageId,
    required this.slots,
    required this.vendorCount,
    required this.from,
    required this.to,
    required this.message,
  });

  factory PackageAvailabilityResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return PackageAvailabilityResponseModel(
      packageId: json['packageId'] as String? ?? '',
      slots: (json['slots'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      vendorCount: json['vendorCount'] as int? ?? 0,
      from: json['from'] as String? ?? '',
      to: json['to'] as String? ?? '',
      message: json['message'] as String? ?? '',
    );
  }

  final String packageId;
  final List<String> slots;
  final int vendorCount;
  final String from;
  final String to;
  final String message;
}

