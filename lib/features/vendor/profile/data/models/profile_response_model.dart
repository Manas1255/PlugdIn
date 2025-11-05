import 'package:equatable/equatable.dart';
import 'package:plugdin/core/models/vendor_model.dart';
import 'package:plugdin/utils/helpers/json_helper.dart';
import 'package:plugdin/utils/helpers/logger_helper.dart';

class VendorProfileResponseModel extends Equatable {
  const VendorProfileResponseModel({
    required this.vendor,
  });

  factory VendorProfileResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      return VendorProfileResponseModel(
        vendor: VendorModel.fromJson(
          JsonHelper.safeMapCast(
            json['vendor'],
          ),
        ),
      );
    } catch (e, s) {
      AppLogger.error('Error parsing ProfileResponseModel:', e, s);
      rethrow;
    }
  }
  final VendorModel vendor;

  Map<String, dynamic> toJson() => {
    'user': {},
  };

  VendorProfileResponseModel copyWith({
    VendorModel? vendor,
  }) {
    return VendorProfileResponseModel(
      vendor: vendor ?? this.vendor,
    );
  }

  @override
  List<Object?> get props => [vendor];

  static VendorProfileResponseModel fromApiResponse(
    Map<String, dynamic> json,
  ) {
    return VendorProfileResponseModel.fromJson(
      json['data'] as Map<String, dynamic>,
    );
  }
}
