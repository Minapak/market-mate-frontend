import 'package:json_annotation/json_annotation.dart';

part 'middle_category_model.g.dart';

@JsonSerializable()
class MiddleCategoryModel {
  final int id;
  final String name;

  MiddleCategoryModel({required this.id, required this.name});

  factory MiddleCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$MiddleCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$MiddleCategoryModelToJson(this);
}
