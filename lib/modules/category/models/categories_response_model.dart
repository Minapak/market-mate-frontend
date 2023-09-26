import 'package:json_annotation/json_annotation.dart';
import 'package:sip_app/modules/category/models/main_category_model.dart';
import 'package:sip_app/modules/category/models/middle_category_model.dart';

part 'categories_response_model.g.dart';

abstract class CategoriesResponseBase {}

@JsonSerializable()
class CategoriesResponseModel extends CategoriesResponseBase {
  final List<MainCategoryModel> mainCategories;
  final List<MiddleCategoryModel> middleCategories;

  CategoriesResponseModel(
      {required this.mainCategories, required this.middleCategories});

  factory CategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseModelToJson(this);
}

@JsonSerializable()
class MainCategoriesResponseModel extends CategoriesResponseBase {
  final List<MainCategoryModel> mainCategories;

  MainCategoriesResponseModel({required this.mainCategories});

  MainCategoriesResponseModel copyWith(
      {List<MainCategoryModel>? mainCategories}) {
    return MainCategoriesResponseModel(
        mainCategories: mainCategories ?? this.mainCategories);
  }

  factory MainCategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MainCategoriesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainCategoriesResponseModelToJson(this);
}

@JsonSerializable()
class MiddleCategoriesResponseModel extends CategoriesResponseBase {
  final List<MiddleCategoryModel> middleCategories;

  MiddleCategoriesResponseModel({required this.middleCategories});

  MiddleCategoriesResponseModel copyWith(
      {List<MiddleCategoryModel>? middleCategories}) {
    return MiddleCategoriesResponseModel(
        middleCategories: middleCategories ?? this.middleCategories);
  }

  factory MiddleCategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MiddleCategoriesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MiddleCategoriesResponseModelToJson(this);
}

class MiddleCategoriesResposeLoading extends CategoriesResponseBase {}

class MiddleCategoriesResponseError extends CategoriesResponseBase {}

class CategoriesReponseLoading extends CategoriesResponseBase {}

class CategoriesResponseError extends CategoriesResponseBase {}
