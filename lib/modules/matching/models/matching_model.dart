import 'package:json_annotation/json_annotation.dart';
import 'package:sip_app/modules/expert/models/expert_model.dart';

part 'matching_model.g.dart';

enum MatchingStatus {
  MATCHING_STANDBY,
  MATCHING_ACCEPT,
  MANAGER_CONNECT,
  MATCHING_COMPLETE,
  MATCHING_CANCEL,
}

@JsonSerializable()
class MatchingModel {
  final int id;
  final String userUUId;
  final ExpertModel expert;
  final MatchingStatus matchingStatus;
  final bool activate;
  final String createdDateTime;

  MatchingModel({
    required this.id,
    required this.userUUId,
    required this.expert,
    required this.matchingStatus,
    required this.activate,
    required this.createdDateTime,
  });

  factory MatchingModel.fromJson(Map<String, dynamic> json) =>
      _$MatchingModelFromJson(json);

  Map<String, dynamic> toJson() => _$MatchingModelToJson(this);
}
