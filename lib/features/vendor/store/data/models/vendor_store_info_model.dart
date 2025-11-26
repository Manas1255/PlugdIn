class VendorStoreInfoResponseModel {
  VendorStoreInfoResponseModel({
    required this.vendor,
  });

  factory VendorStoreInfoResponseModel.fromJson(Map<String, dynamic> json) {
    return VendorStoreInfoResponseModel(
      vendor: VendorStoreInfoModel.fromJson(
        json['vendor'] as Map<String, dynamic>,
      ),
    );
  }

  final VendorStoreInfoModel vendor;

  Map<String, dynamic> toJson() {
    return {
      'vendor': vendor.toJson(),
    };
  }
}

class VendorStoreInfoModel {
  VendorStoreInfoModel({
    required this.pricePerPerson,
    required this.capacity,
    required this.id,
    required this.userId,
    required this.companyName,
    required this.personName,
    required this.address,
    required this.city,
    required this.phoneNumber,
    required this.primaryCategory,
    required this.additionalCategories,
    required this.features,
    required this.links,
    required this.status,
    required this.businessDescription,
    required this.isVerified,
    required this.reviews,
    required this.ratings,
    this.companyLogo,
  });

  factory VendorStoreInfoModel.fromJson(Map<String, dynamic> json) {
    return VendorStoreInfoModel(
      pricePerPerson: json['pricePerPerson'] as int? ?? 0,
      capacity: json['capacity'] as int? ?? 0,
      id: json['_id'] as String,
      userId: UserIdModel.fromJson(json['userId'] as Map<String, dynamic>),
      companyName: json['companyName'] as String,
      companyLogo: json['companyLogo'] as String?,
      personName: json['personName'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      phoneNumber: json['phoneNumber'] as String,
      primaryCategory: json['primaryCategory'] as String,
      additionalCategories:
          (json['additionalCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      features:
          (json['features'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      links:
          (json['links'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [],
      status: json['status'] as String,
      businessDescription: json['businessDescription'] as String,
      isVerified: json['isVerified'] as bool? ?? false,
      reviews: json['reviews'] as int? ?? 0,
      ratings: json['ratings'] as int? ?? 0,
    );
  }
  final int pricePerPerson;
  final int capacity;
  final String id;
  final UserIdModel userId;
  final String companyName;
  final String? companyLogo;
  final String personName;
  final String address;
  final String city;
  final String phoneNumber;
  final String primaryCategory;
  final List<String> additionalCategories;
  final List<String> features;
  final List<String> links;
  final String status;
  final String businessDescription;
  final bool isVerified;
  final int reviews;
  final int ratings;

  Map<String, dynamic> toJson() {
    return {
      'pricePerPerson': pricePerPerson,
      'capacity': capacity,
      '_id': id,
      'userId': userId.toJson(),
      'companyName': companyName,
      'companyLogo': companyLogo,
      'personName': personName,
      'address': address,
      'city': city,
      'phoneNumber': phoneNumber,
      'primaryCategory': primaryCategory,
      'additionalCategories': additionalCategories,
      'features': features,
      'links': links,
      'status': status,
      'businessDescription': businessDescription,
      'isVerified': isVerified,
      'reviews': reviews,
      'ratings': ratings,
    };
  }

  VendorStoreInfoModel copyWith({
    int? pricePerPerson,
    int? capacity,
    String? id,
    UserIdModel? userId,
    String? companyName,
    String? companyLogo,
    String? personName,
    String? address,
    String? city,
    String? phoneNumber,
    String? primaryCategory,
    List<String>? additionalCategories,
    List<String>? features,
    List<String>? links,
    String? status,
    String? businessDescription,
    bool? isVerified,
    int? reviews,
    int? ratings,
  }) {
    return VendorStoreInfoModel(
      pricePerPerson: pricePerPerson ?? this.pricePerPerson,
      capacity: capacity ?? this.capacity,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      companyName: companyName ?? this.companyName,
      companyLogo: companyLogo ?? this.companyLogo,
      personName: personName ?? this.personName,
      address: address ?? this.address,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      primaryCategory: primaryCategory ?? this.primaryCategory,
      additionalCategories: additionalCategories ?? this.additionalCategories,
      features: features ?? this.features,
      links: links ?? this.links,
      status: status ?? this.status,
      businessDescription: businessDescription ?? this.businessDescription,
      isVerified: isVerified ?? this.isVerified,
      reviews: reviews ?? this.reviews,
      ratings: ratings ?? this.ratings,
    );
  }
}

class UserIdModel {
  UserIdModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  factory UserIdModel.fromJson(Map<String, dynamic> json) {
    return UserIdModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      createdAt: json['createdAt'] as String,
    );
  }
  final String id;
  final String name;
  final String username;
  final String email;
  final String role;
  final String createdAt;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'username': username,
      'email': email,
      'role': role,
      'createdAt': createdAt,
    };
  }

  UserIdModel copyWith({
    String? id,
    String? name,
    String? username,
    String? email,
    String? role,
    String? createdAt,
  }) {
    return UserIdModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
