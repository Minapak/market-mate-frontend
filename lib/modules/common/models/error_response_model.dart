import 'package:json_annotation/json_annotation.dart';

part 'error_response_model.g.dart';

@JsonSerializable()
class ErrorResponseModel {
  final String? timestamp;
  final int? status;
  final String? error;
  final String? path;
  final String? timeStamp;
  final String? message;

  ErrorResponseModel({
    this.timestamp,
    this.status,
    this.path,
    this.timeStamp,
    this.message,
    this.error,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) => _$ErrorResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseModelToJson(this);
}