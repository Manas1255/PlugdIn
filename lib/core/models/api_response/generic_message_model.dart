import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:plugdin/core/models/api_response/api_response_model.dart';
import 'package:plugdin/core/models/api_response/base_api_response.dart';

class GenericMessageModel extends Equatable {
  const GenericMessageModel({required this.message});

  factory GenericMessageModel.fromJson(Map<String, dynamic> json) {
    return GenericMessageModel(
      message: json['message'] as String,
    );
  }

  static ResponseModel<BaseApiResponse<GenericMessageModel>> parseResponse(
    Response<dynamic> response,
  ) {
    return ResponseModel.fromApiResponse<BaseApiResponse<GenericMessageModel>>(
      response,
      (json) => BaseApiResponse<GenericMessageModel>.fromJson(
        json,
        GenericMessageModel.fromJson,
      ),
    );
  }

  final String message;

  @override
  List<Object?> get props => [message];
}
