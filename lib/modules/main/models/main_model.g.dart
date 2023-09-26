// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainModel _$MainModelFromJson(Map<String, dynamic> json) => MainModel(
      banners: (json['banners'] as List<dynamic>)
          .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      mainCategories: (json['mainCategories'] as List<dynamic>)
          .map((e) => MainCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      powerExperts: (json['powerExperts'] as List<dynamic>)
          .map((e) => ExpertModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      markets: (json['markets'] as List<dynamic>)
          .map((e) => MarketModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      // members: (json['members'] as List<dynamic>)
      //     .map((e) => MemberModel.fromJson(e as Map<String, dynamic>))
      //     .toList(),
    );

Map<String, dynamic> _$MainModelToJson(MainModel instance) => <String, dynamic>{
      'banners': instance.banners,
      'mainCategories': instance.mainCategories,
      'powerExperts': instance.powerExperts,
      'markets': instance.markets,
      // 'members': instance.members,
    };
