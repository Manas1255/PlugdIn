import 'package:equatable/equatable.dart';
import 'package:plugdin/core/models/customer_model.dart';
import 'package:plugdin/utils/helpers/json_helper.dart';
import 'package:plugdin/utils/helpers/logger_helper.dart';

class CustomerProfileResponseModel extends Equatable {
  const CustomerProfileResponseModel({
    required this.user,
  });

  factory CustomerProfileResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      return CustomerProfileResponseModel(
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

  CustomerProfileResponseModel copyWith({
    CustomerModel? user,
  }) {
    return CustomerProfileResponseModel(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [user];

  static CustomerProfileResponseModel fromApiResponse(
    Map<String, dynamic> json,
  ) {
    return CustomerProfileResponseModel.fromJson(
      json['data'] as Map<String, dynamic>,
    );
  }
}
