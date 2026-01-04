class CreateBookingRequestModel {
  const CreateBookingRequestModel({
    required this.packageId,
    required this.location,
    required this.startTime,
    required this.endTime,
    this.notes,
  });

  final String packageId;
  final String location;
  final String startTime;
  final String endTime;
  final String? notes;

  Map<String, dynamic> toJson() {
    return {
      'packageId': packageId,
      'location': location,
      'startTime': startTime,
      'endTime': endTime,
      if (notes != null && notes!.isNotEmpty) 'notes': notes,
    };
  }
}

