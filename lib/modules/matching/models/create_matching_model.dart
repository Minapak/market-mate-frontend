import 'package:json_annotation/json_annotation.dart';
import 'package:sip_app/modules/matching/models/matching_model.dart';

part 'create_matching_model.g.dart';

@JsonSerializable()
class CreateMatchingModel {
  final String userUUID;
  final int expertId;
  final MatchingStatus matchingStatus;
  final bool activate;

  CreateMatchingModel({
    required this.userUUID,
    required this.expertId,
    required this.matchingStatus,
    required this.activate,
  });

  factory CreateMatchingModel.fromJson(Map<String, dynamic> json) => _$CreateMatchingModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateMatchingModelToJson(this);
}