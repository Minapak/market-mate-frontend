import 'package:json_annotation/json_annotation.dart';

part 'response_success_model.g.dart';

@JsonSerializable()
class ResponseSuccessModel {
  final bool success;

  ResponseSuccessModel({required this.success});

  factory ResponseSuccessModel.fromJson(Map<String, dynamic> json) => _$ResponseSuccessModelFromJson(json);
}