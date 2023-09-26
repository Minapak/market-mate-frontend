import 'package:json_annotation/json_annotation.dart';
import 'package:sip_app/modules/wholesaler/models/wholesaler_model.dart';

part 'matching_ws_model.g.dart';

enum MatchingWSStatus {
  MATCHING_STANDBY,
  MATCHING_ACCEPT,
  MANAGER_CONNECT,
  MATCHING_COMPLETE,
  MATCHING_CANCEL,
}

@JsonSerializable()
class MatchingWSModel {
  final int id;
  final String userUUId;
  final wholesalerModel wholesaler;
  final MatchingWSStatus matchingWSStatus;
  final bool activate;
  final String createdDateTime;

  MatchingWSModel({
    required this.id,
    required this.userUUId,
    required this.wholesaler,
    required this.matchingWSStatus,
    required this.activate,
    required this.createdDateTime,
  });

  factory MatchingWSModel.fromJson(Map<String, dynamic> json) =>
      _$MatchingWSModelFromJson(json);

  Map<String, dynamic> toJson() => _$MatchingWSModelToJson(this);
}
