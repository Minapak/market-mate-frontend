import 'package:json_annotation/json_annotation.dart';
import 'package:sip_app/modules/matching/models/matching_ws_model.dart';

part 'create_matching_ws_model.g.dart';

@JsonSerializable()
class CreateMatchingWSModel {
  final String userUUID;
  final int wholesalerId;
  final MatchingWSStatus matchingWSStatus;
  final bool activate;

  CreateMatchingWSModel({
    required this.userUUID,
    required this.wholesalerId,
    required this.matchingWSStatus,
    required this.activate,
  });

  factory CreateMatchingWSModel.fromJson(Map<String, dynamic> json) => _$CreateMatchingWSModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateMatchingWSModelToJson(this);
}