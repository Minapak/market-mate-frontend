import 'package:json_annotation/json_annotation.dart';
import 'package:sip_app/modules/member/models/member_model.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  final int id;
  final String content;
  final int star;
  final bool activate;
  final String? createdDateTime;
  final MemberModel user;

  ReviewModel(
      {required this.id,
      required this.content,
      required this.star,
      required this.activate,
      required this.user,
      this.createdDateTime});

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
