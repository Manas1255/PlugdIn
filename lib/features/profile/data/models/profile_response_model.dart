import 'package:equatable/equatable.dart';
import 'package:plugdin/core/models/user_model.dart';
import 'package:plugdin/utils/helpers/json_helper.dart';
import 'package:plugdin/utils/helpers/logger_helper.dart';

class ProfileResponseModel extends Equatable {
  const ProfileResponseModel({
    required this.user,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      return ProfileResponseModel(
        user: UserModel.fromJson(
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
  final UserModel user;

  Map<String, dynamic> toJson() => {
    'user': {},
  };

  ProfileResponseModel copyWith({
    UserModel? user,
  }) {
    return ProfileResponseModel(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [user];

  static ProfileResponseModel fromApiResponse(Map<String, dynamic> json) {
    return ProfileResponseModel.fromJson(json['data'] as Map<String, dynamic>);
  }
}
