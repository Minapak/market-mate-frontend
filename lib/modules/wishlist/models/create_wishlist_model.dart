import 'package:json_annotation/json_annotation.dart';

part 'create_wishlist_model.g.dart';

@JsonSerializable()
class CreateWishlistModel {
  final String userUUID;
  final bool activate;

  CreateWishlistModel({required this.userUUID, required this.activate});

  factory CreateWishlistModel.fromJson(Map<String, dynamic> json) => _$CreateWishlistModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateWishlistModelToJson(this);
}