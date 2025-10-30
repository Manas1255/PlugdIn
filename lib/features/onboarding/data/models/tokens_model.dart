import 'package:equatable/equatable.dart';

class TokensModel extends Equatable {
  const TokensModel({
    required this.accessToken,
  });

  factory TokensModel.fromJson(Map<String, dynamic> json) {
    return TokensModel(
      accessToken: json['token']?.toString() ?? '',
    );
  }

  final String accessToken;

  Map<String, dynamic> toJson() => {
    'token': accessToken,
  };

  TokensModel copyWith({
    String? accessToken,
  }) {
    return TokensModel(
      accessToken: accessToken ?? this.accessToken,
    );
  }

  @override
  List<Object?> get props => [accessToken];

  @override
  String toString() {
    return 'TokensModel(accessToken: ${accessToken.substring(0, 20)}...)';
  }
}
