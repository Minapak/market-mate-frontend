import 'package:json_annotation/json_annotation.dart';

part 'response_register_expert_model.g.dart';

enum ExpertRegisterType {
  ID,
  THUMBNAIL,
  INTRODUCE_EXPERT,
  INTRODUCE_CONTENT,
  IMAGES,
  MAIN_CATEGORIES,
  MIDDLE_CATEGORIES,
}

@JsonSerializable()
class ResponseRegisterExpertModel {
  final ExpertRegisterType RegiType;

  ResponseRegisterExpertModel({required this.RegiType});


  factory ResponseRegisterExpertModel.fromJson(Map<String, dynamic> json) => _$ResponseRegisterExpertModelFromJson(json);
}