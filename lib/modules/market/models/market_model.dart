import 'package:json_annotation/json_annotation.dart';
import 'package:sip_app/modules/category/models/main_category_model.dart';
import 'package:sip_app/modules/category/models/middle_category_model.dart';
import 'package:sip_app/modules/common/models/image_model.dart';

part 'market_model.g.dart';

@JsonSerializable()
class MarketModel {
  final int id;
  final String name;
  final String? thumbnail;
  final String? address;
  final String? content;
  final int? latitude;
  final int? longitude;
  final List<MainCategoryModel>? mainCategories;
  final List<MiddleCategoryModel>? middleCategories;
  final List<ImageModel>? images;


  MarketModel({
    required this.id,
    required this.name,
    this.address,
    this.thumbnail,
    this.content,
    this.latitude,
    this.longitude,
    this.mainCategories,
    this.middleCategories,
    this.images,
  });

  factory MarketModel.fromJson(Map<String, dynamic> json) =>
      _$MarketModelFromJson(json);

  Map<String, dynamic> toJson() => _$MarketModelToJson(this);
}
