// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_ws_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistWSModel _$WishlistWSModelFromJson(Map<String, dynamic> json) =>
    WishlistWSModel(
      id: json['id'] as int,
      createdDateTime: json['createdDateTime'] as String?,
      userUUID: json['userUUID'] as String,
      activate: json['activate'] as bool,
      wholesaler: json['wholesaler'] == null
          ? null
          : wholesalerModel.fromJson(json['wholesaler'] as Map<String, dynamic>),
      wholesalerId: json['wholesalerId'] as int?,
    );

Map<String, dynamic> _$WishlistWSModelToJson(WishlistWSModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdDateTime': instance.createdDateTime,
      'userUUID': instance.userUUID,
      'activate': instance.activate,
      'wholesaler': instance.wholesaler,
      'wholesalerId': instance.wholesalerId,
    };
