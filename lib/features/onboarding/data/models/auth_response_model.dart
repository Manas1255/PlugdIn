import 'package:equatable/equatable.dart';
import 'package:plugdin/core/models/user_model.dart';
import 'package:plugdin/features/onboarding/data/models/tokens_model.dart';
import 'package:plugdin/utils/helpers/json_helper.dart';
import 'package:plugdin/utils/helpers/logger_helper.dart';

class AuthResponseModel extends Equatable {
  const AuthResponseModel({
    required this.user,
    required this.tokens,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      return AuthResponseModel(
        user: UserModel.fromJson(
          JsonHelper.safeMapCast(
            json['user'],
          ),
        ),
        
        tokens: TokensModel.fromJson(json),
      );
    } catch (e, s) {
      AppLogger.error('Error parsing AuthResponseModel:', e, s);
      rethrow;
    }
  }

  final UserModel user;
  final TokensModel tokens;

  Map<String, dynamic> toJson() => {
    'user': user.toJson(),
    // flatten token at the top-level per API shape
    ...tokens.toJson(),
  };

  AuthResponseModel copyWith({
    UserModel? user,
    TokensModel? tokens,
  }) {
    return AuthResponseModel(
      user: user ?? this.user,
      tokens: tokens ?? this.tokens,
    );
  }

  @override
  List<Object?> get props => [user, tokens];

  static AuthResponseModel fromApiResponse(Map<String, dynamic> json) {
    return AuthResponseModel.fromJson(json['data'] as Map<String, dynamic>);
  }
}
