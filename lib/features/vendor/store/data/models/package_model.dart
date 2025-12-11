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
    final creatorVendor = json['creatorVendorId'];
    final subpriceValue = json['subprice'];
    final totalPriceValue = json['totalPrice'];
    final bookingCountValue = json['bookingCount'];

    final mediaList = (json['media'] as List<dynamic>?) ?? [];
    final parsedMedia = mediaList
        .map((e) {
          if (e is Map<String, dynamic>) {
            final fileUrl = e['fileUrl']?.toString();
            if (fileUrl != null && fileUrl.isNotEmpty) return fileUrl;
          }
          return e.toString();
        })
        .where((url) => url.isNotEmpty)
        .toList();

    return PackageModel(
      id: json['_id']?.toString() ?? '',
      creatorVendorId: creatorVendor is Map<String, dynamic>
          ? CreatorVendorModel.fromJson(creatorVendor)
          : CreatorVendorModel.fallback(id: creatorVendor?.toString() ?? ''),
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      media: parsedMedia,
      subprice: (subpriceValue as num?)?.toInt() ?? 0,
      totalPrice: (totalPriceValue as num?)?.toInt() ?? 0,
      vendorEmails: (json['vendorEmails'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      vendorRequests: (json['vendorRequests'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      approvedVendors: (json['approvedVendors'] as List<dynamic>?)
              ?.map((e) => ApprovedVendorModel.fromJson(
                    e as Map<String, dynamic>? ?? <String, dynamic>{},
                  ))
              .toList() ??
          [],
      status: json['status']?.toString() ?? '',
      bookingCount: (bookingCountValue as num?)?.toInt() ?? 0,
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      version: (json['__v'] as num?)?.toInt() ?? 0,
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
    this.companyLogo,
  });

  factory CreatorVendorModel.fromJson(Map<String, dynamic> json) {
    return CreatorVendorModel(
      id: json['_id']?.toString() ?? '',
      companyName: json['companyName']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      companyLogo: json['companyLogo']?.toString(),
    );
  }

  factory CreatorVendorModel.fallback({required String id}) {
    return CreatorVendorModel(
      id: id,
      companyName: '',
      city: '',
    );
  }

  final String id;
  final String companyName;
  final String city;
  final String? companyLogo;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'companyName': companyName,
      'city': city,
      if (companyLogo != null) 'companyLogo': companyLogo,
    };
  }
}

class ApprovedVendorModel {
  ApprovedVendorModel({
    required this.id,
    required this.companyName,
    required this.city,
    this.companyLogo,
  });

  factory ApprovedVendorModel.fromJson(Map<String, dynamic> json) {
    return ApprovedVendorModel(
      id: json['_id']?.toString() ?? '',
      companyName: json['companyName']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      companyLogo: json['companyLogo']?.toString(),
    );
  }

  final String id;
  final String companyName;
  final String city;
  final String? companyLogo;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'companyName': companyName,
      'city': city,
      if (companyLogo != null) 'companyLogo': companyLogo,
    };
  }
}

