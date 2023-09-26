import 'package:json_annotation/json_annotation.dart';
import 'package:sip_app/modules/common/models/image_model.dart';
import 'package:sip_app/modules/category/models/main_category_model.dart';
import 'package:sip_app/modules/category/models/middle_category_model.dart';

part 'wholesaler_model.g.dart';

enum wholesalerCareer {
  UNTIL_FIVE_YEAR,
  UNTIL_TEN_YEAR,
  UNTIL_TWENTY_YEAR,
  UNTIL_THIRTY_YEAR,
  OVER_THIRTY_YEAR
}

@JsonSerializable()
class wholesalerModel {
  final int id;
  final String name;
  final String? marketName;
  final String? content;
  final String? thumbnail;
  final wholesalerCareer? career;
  final List<ImageModel>? images;
  final List<MainCategoryModel>? mainCategories;
  final List<MiddleCategoryModel>? middleCategories;

  wholesalerModel({
    required this.id,
    required this.name,
    required this.content,
    this.thumbnail,
    this.marketName,
    this.career,
    this.images,
    this.mainCategories,
    this.middleCategories,
  });

  factory wholesalerModel.fromJson(Map<String, dynamic> json) =>
      _$wholesalerModelFromJson(json);

  Map<String, dynamic> toJson() => _$wholesalerModelToJson(this);
}
