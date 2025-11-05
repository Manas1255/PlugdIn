import 'package:equatable/equatable.dart';
import 'package:plugdin/core/models/customer_model.dart';
import 'package:plugdin/utils/helpers/json_helper.dart';
import 'package:plugdin/utils/helpers/logger_helper.dart';

class VendorProfileResponseModel extends Equatable {
  const VendorProfileResponseModel({
    required this.user,
  });

  factory VendorProfileResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      return VendorProfileResponseModel(
        user: CustomerModel.fromJson(
          JsonHelper.safeMapCast(
            json['user'],
          ),
        ),
      );
    } catch (e, s) {
      AppLogger.error('Error parsing ProfileResponseModel:', e, s);
      rethrow;
    }
  }
  final CustomerModel user;

  Map<String, dynamic> toJson() => {
    'user': {},
  };

  VendorProfileResponseModel copyWith({
    CustomerModel? user,
  }) {
    return VendorProfileResponseModel(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [user];

  static VendorProfileResponseModel fromApiResponse(
    Map<String, dynamic> json,
  ) {
    return VendorProfileResponseModel.fromJson(
      json['data'] as Map<String, dynamic>,
    );
  }
}
