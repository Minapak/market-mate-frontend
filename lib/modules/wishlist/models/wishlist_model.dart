import 'package:json_annotation/json_annotation.dart';
import 'package:sip_app/modules/expert/models/expert_model.dart';

part 'wishlist_model.g.dart';

@JsonSerializable()
class WishlistModel {
  final int id;
  final String? createdDateTime;
  final String userUUID;
  final bool activate;
  final ExpertModel? expert;
  final int? expertId;

  WishlistModel(
    {
      required this.id,
      this.createdDateTime,
      required this.userUUID,
      required this.activate,
      this.expert,
      this.expertId
    });

  factory WishlistModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistModelToJson(this);
}
