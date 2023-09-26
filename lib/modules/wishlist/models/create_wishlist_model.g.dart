// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_wishlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateWishlistModel _$CreateWishlistModelFromJson(Map<String, dynamic> json) =>
    CreateWishlistModel(
      userUUID: json['userUUID'] as String,
      activate: json['activate'] as bool,
    );

Map<String, dynamic> _$CreateWishlistModelToJson(
        CreateWishlistModel instance) =>
    <String, dynamic>{
      'userUUID': instance.userUUID,
      'activate': instance.activate,
    };
