import 'package:json_annotation/json_annotation.dart';

part 'main_category_model.g.dart';

@JsonSerializable()
class MainCategoryModel {
  final int id;
  final String? path;
  final String name;

  MainCategoryModel({required this.id, this.path, required this.name});

  factory MainCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$MainCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainCategoryModelToJson(this);
}
