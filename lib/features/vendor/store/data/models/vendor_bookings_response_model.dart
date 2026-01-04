import 'package:plugdin/core/models/pagination_model.dart';

class VendorBookingsResponseModel {
  const VendorBookingsResponseModel({
    required this.bookings,
    this.pagination,
  });

  factory VendorBookingsResponseModel.fromJson(Map<String, dynamic> json) {
    final bookingsJson = json['bookings'] as List<dynamic>? ?? <dynamic>[];

    return VendorBookingsResponseModel(
      bookings: bookingsJson
          .map((booking) => BookingModel.fromJson(booking as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : PaginationModel.fromJson(
              json['pagination'] as Map<String, dynamic>,
            ),
    );
  }

  final List<BookingModel> bookings;
  final PaginationModel? pagination;

  Map<String, dynamic> toJson() {
    return {
      'bookings': bookings.map((booking) => booking.toJson()).toList(),
      if (pagination != null) 'pagination': pagination?.toJson(),
    };
  }
}

class BookingModel {
  const BookingModel({
    required this.id,
    required this.packageId,
    required this.customerId,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.totalAmount,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['_id']?.toString() ?? '',
      packageId: json['packageId'] == null
          ? PackageInfo.empty()
          : PackageInfo.fromJson(json['packageId'] as Map<String, dynamic>),
      customerId: json['customerId'] == null
          ? CustomerInfo.empty()
          : CustomerInfo.fromJson(json['customerId'] as Map<String, dynamic>),
      location: json['location']?.toString() ?? '',
      startTime: json['startTime']?.toString() ?? '',
      endTime: json['endTime']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      totalAmount: (json['totalAmount'] as num?)?.toInt() ?? 0,
      notes: json['notes']?.toString(),
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }

  final String id;
  final PackageInfo packageId;
  final CustomerInfo customerId;
  final String location;
  final String startTime;
  final String endTime;
  final String status;
  final int totalAmount;
  final String? notes;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'packageId': packageId.toJson(),
      'customerId': customerId.toJson(),
      'location': location,
      'startTime': startTime,
      'endTime': endTime,
      'status': status,
      'totalAmount': totalAmount,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class PackageInfo {
  const PackageInfo({
    required this.id,
    required this.title,
    required this.description,
    required this.totalPrice,
  });

  factory PackageInfo.fromJson(Map<String, dynamic> json) {
    return PackageInfo(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      totalPrice: (json['totalPrice'] as num?)?.toInt() ?? 0,
    );
  }

  factory PackageInfo.empty() {
    return const PackageInfo(
      id: '',
      title: '',
      description: '',
      totalPrice: 0,
    );
  }

  final String id;
  final String title;
  final String description;
  final int totalPrice;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'totalPrice': totalPrice,
    };
  }
}

class CustomerInfo {
  const CustomerInfo({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.profilePicture,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) {
    return CustomerInfo(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      profilePicture: json['profilePicture']?.toString(),
    );
  }

  factory CustomerInfo.empty() {
    return const CustomerInfo(
      id: '',
      name: '',
      username: '',
      email: '',
    );
  }

  final String id;
  final String name;
  final String username;
  final String email;
  final String? profilePicture;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'username': username,
      'email': email,
      if (profilePicture != null) 'profilePicture': profilePicture,
    };
  }
}
