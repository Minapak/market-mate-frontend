import 'package:json_annotation/json_annotation.dart';
import 'package:sip_app/modules/community/models/community_category.dart';

part 'community_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CommunityModel {
  final int id;
  final String title;
  final String content;
  final bool activate;
  final int? goods;
  final int? comments;
  final int? commnets_count;
  final CommunityCategoryModel communityCategory;

  CommunityModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.activate,
      required this.communityCategory,
      this.goods,
      this.comments,
      this.commnets_count});

  factory CommunityModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityModelToJson(this);
}
