import 'package:json_annotation/json_annotation.dart';

part 'service_category_model.g.dart';

@JsonSerializable()
class ServiceCategoryModel {
  final int id;
  final String name;

  ServiceCategoryModel({required this.id, required this.name});

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceCategoryModelToJson(this);
}