import 'package:plugdin/core/models/pagination_model.dart';

class StoreMediaResponseModel {
  const StoreMediaResponseModel({
    required this.posts,
    required this.pagination,
  });

  factory StoreMediaResponseModel.fromJson(Map<String, dynamic> json) {
    return StoreMediaResponseModel(
      posts: (json['posts'] as List<dynamic>?)
              ?.map((e) => StorePostModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      pagination:
          PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }

  final List<StorePostModel> posts;
  final PaginationModel pagination;

  Map<String, dynamic> toJson() {
    return {
      'posts': posts.map((post) => post.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }

  @override
  String toString() {
    return 'StoreMediaResponseModel(posts: $posts, pagination: $pagination)';
  }
}

class StorePostModel {
  const StorePostModel({
    required this.id,
    required this.vendorId,
    required this.storeId,
    required this.media,
    required this.status,
    required this.likesCount,
    required this.viewsCount,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory StorePostModel.fromJson(Map<String, dynamic> json) {
    return StorePostModel(
      id: json['_id'] as String,
      vendorId: VendorInfoModel.fromJson(
        json['vendorId'] as Map<String, dynamic>,
      ),
      storeId: json['storeId'] as String,
      media: (json['media'] as List<dynamic>?)
              ?.map((e) => MediaItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      status: json['status'] as String,
      likesCount: json['likesCount'] as int,
      viewsCount: json['viewsCount'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: json['__v'] as int,
    );
  }

  final String id;
  final VendorInfoModel vendorId;
  final String storeId;
  final List<MediaItemModel> media;
  final String status;
  final int likesCount;
  final int viewsCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'vendorId': vendorId.toJson(),
      'storeId': storeId,
      'media': media.map((item) => item.toJson()).toList(),
      'status': status,
      'likesCount': likesCount,
      'viewsCount': viewsCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }

  @override
  String toString() {
    return 'StorePostModel(id: $id, vendorId: $vendorId, storeId: $storeId, media: $media, status: $status, likesCount: $likesCount, viewsCount: $viewsCount, createdAt: $createdAt, updatedAt: $updatedAt, version: $version)';
  }
}

class VendorInfoModel {
  const VendorInfoModel({
    required this.id,
    required this.companyName,
  });

  factory VendorInfoModel.fromJson(Map<String, dynamic> json) {
    return VendorInfoModel(
      id: json['_id'] as String,
      companyName: json['companyName'] as String,
    );
  }

  final String id;
  final String companyName;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'companyName': companyName,
    };
  }

  @override
  String toString() {
    return 'VendorInfoModel(id: $id, companyName: $companyName)';
  }
}

class MediaItemModel {
  const MediaItemModel({
    required this.type,
    required this.fileUrl,
  });

  factory MediaItemModel.fromJson(Map<String, dynamic> json) {
    return MediaItemModel(
      type: json['type'] as String,
      fileUrl: json['fileUrl'] as String,
    );
  }

  final String type;
  final String fileUrl;

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'fileUrl': fileUrl,
    };
  }

  @override
  String toString() {
    return 'MediaItemModel(type: $type, fileUrl: $fileUrl)';
  }
}

