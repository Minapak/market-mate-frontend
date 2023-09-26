import 'package:json_annotation/json_annotation.dart';
import 'package:sip_app/modules/wholesaler/models/wholesaler_model.dart';

part 'wishlist_ws_model.g.dart';

@JsonSerializable()
class WishlistWSModel {
  final int id;
  final String? createdDateTime;
  final String userUUID;
  final bool activate;
  final wholesalerModel? wholesaler;
  final int? wholesalerId;

  WishlistWSModel(
      {
        required this.id,
        this.createdDateTime,
        required this.userUUID,
        required this.activate,
        this.wholesaler,
        this.wholesalerId
      });

  factory WishlistWSModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistWSModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistWSModelToJson(this);
}
