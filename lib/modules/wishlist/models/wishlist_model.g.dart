// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistModel _$WishlistModelFromJson(Map<String, dynamic> json) =>
    WishlistModel(
      id: json['id'] as int,
      createdDateTime: json['createdDateTime'] as String?,
      userUUID: json['userUUID'] as String,
      activate: json['activate'] as bool,
      expert: json['expert'] == null
          ? null
          : ExpertModel.fromJson(json['expert'] as Map<String, dynamic>),
      expertId: json['expertId'] as int?,
    );

Map<String, dynamic> _$WishlistModelToJson(WishlistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdDateTime': instance.createdDateTime,
      'userUUID': instance.userUUID,
      'activate': instance.activate,
      'expert': instance.expert,
      'expertId': instance.expertId,
    };
