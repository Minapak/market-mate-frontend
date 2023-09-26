import 'package:json_annotation/json_annotation.dart';

part 'community_category.g.dart';

@JsonSerializable()
class CommunityCategoryModel {
  final int id;
  final String name;

  CommunityCategoryModel({required this.id, required this.name});

  factory CommunityCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityCategoryModelToJson(this);
}
