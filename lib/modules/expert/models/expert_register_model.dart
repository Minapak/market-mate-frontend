import 'package:json_annotation/json_annotation.dart';
import 'package:sip_app/modules/common/models/image_model.dart';
import 'package:sip_app/modules/category/models/main_category_model.dart';
import 'package:sip_app/modules/category/models/middle_category_model.dart';

part 'expert_register_model.g.dart';

enum ExpertCareer {
  UNTIL_FIVE_YEAR,
  UNTIL_TEN_YEAR,
  UNTIL_TWENTY_YEAR,
  UNTIL_THIRTY_YEAR,
  OVER_THIRTY_YEAR
}

@JsonSerializable()
class ExpertRegisterModel {
  final int id;
  final String? thumbnail;
  final String? introduceExpert;
  final String? introduceContent;
  // final List<ImageModel>? images;
  // final List<MainCategoryModel>? mainCategories;
  // final List<MiddleCategoryModel>? middleCategories;

  ExpertRegisterModel({
    required this.id,
    required this.thumbnail,
    required this.introduceExpert,
    required this.introduceContent,
    // this.images,
    // this.mainCategories,
    // this.middleCategories,
  });

  factory ExpertRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$ExpertRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExpertRegisterModelToJson(this);
}
