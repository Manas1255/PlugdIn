class CreateBookingResponseModel {
  const CreateBookingResponseModel({
    required this.bookingId,
    required this.packageId,
    required this.location,
    required this.startTime,
    required this.endTime,
    this.notes,
    this.status,
    this.createdAt,
  });

  factory CreateBookingResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateBookingResponseModel(
      bookingId: json['bookingId'] as String? ?? json['_id'] as String? ?? '',
      packageId: json['packageId'] as String? ?? '',
      location: json['location'] as String? ?? '',
      startTime: json['startTime'] as String? ?? '',
      endTime: json['endTime'] as String? ?? '',
      notes: json['notes'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  final String bookingId;
  final String packageId;
  final String location;
  final String startTime;
  final String endTime;
  final String? notes;
  final String? status;
  final String? createdAt;
}

