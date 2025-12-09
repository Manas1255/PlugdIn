class CreatePackageResponseModel {
  CreatePackageResponseModel({
    required this.message,
    required this.package,
  });

  factory CreatePackageResponseModel.fromJson(Map<String, dynamic> json) {
    return CreatePackageResponseModel(
      message: json['message'] as String,
      package: PackageModel.fromJson(
        json['package'] as Map<String, dynamic>,
      ),
    );
  }

  final String message;
  final PackageModel package;

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'package': package.toJson(),
    };
  }
}

class PackageModel {
  PackageModel({
    required this.id,
    required this.creatorVendorId,
    required this.title,
    required this.description,
    required this.media,
    required this.subprice,
    required this.totalPrice,
    required this.vendorEmails,
    required this.vendorRequests,
    required this.approvedVendors,
    required this.status,
    required this.bookingCount,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['_id'] as String,
      creatorVendorId: CreatorVendorModel.fromJson(
        json['creatorVendorId'] as Map<String, dynamic>,
      ),
      title: json['title'] as String,
      description: json['description'] as String,
      media: (json['media'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      subprice: json['subprice'] as int,
      totalPrice: json['totalPrice'] as int,
      vendorEmails: (json['vendorEmails'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      vendorRequests: (json['vendorRequests'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      approvedVendors: (json['approvedVendors'] as List<dynamic>?)
              ?.map((e) => ApprovedVendorModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      status: json['status'] as String,
      bookingCount: json['bookingCount'] as int? ?? 0,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      version: json['__v'] as int? ?? 0,
    );
  }

  final String id;
  final CreatorVendorModel creatorVendorId;
  final String title;
  final String description;
  final List<String> media;
  final int subprice;
  final int totalPrice;
  final List<String> vendorEmails;
  final List<String> vendorRequests;
  final List<ApprovedVendorModel> approvedVendors;
  final String status;
  final int bookingCount;
  final String createdAt;
  final String updatedAt;
  final int version;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'creatorVendorId': creatorVendorId.toJson(),
      'title': title,
      'description': description,
      'media': media,
      'subprice': subprice,
      'totalPrice': totalPrice,
      'vendorEmails': vendorEmails,
      'vendorRequests': vendorRequests,
      'approvedVendors': approvedVendors.map((e) => e.toJson()).toList(),
      'status': status,
      'bookingCount': bookingCount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': version,
    };
  }
}

class CreatorVendorModel {
  CreatorVendorModel({
    required this.id,
    required this.companyName,
    required this.city,
  });

  factory CreatorVendorModel.fromJson(Map<String, dynamic> json) {
    return CreatorVendorModel(
      id: json['_id'] as String,
      companyName: json['companyName'] as String,
      city: json['city'] as String,
    );
  }

  final String id;
  final String companyName;
  final String city;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'companyName': companyName,
      'city': city,
    };
  }
}

class ApprovedVendorModel {
  ApprovedVendorModel({
    required this.id,
    required this.companyName,
    required this.city,
  });

  factory ApprovedVendorModel.fromJson(Map<String, dynamic> json) {
    return ApprovedVendorModel(
      id: json['_id'] as String,
      companyName: json['companyName'] as String,
      city: json['city'] as String,
    );
  }

  final String id;
  final String companyName;
  final String city;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'companyName': companyName,
      'city': city,
    };
  }
}

