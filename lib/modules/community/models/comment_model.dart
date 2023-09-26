import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  final int id;
  final int communityId;
  final String authorUUID;
  final bool activate;
  final String createdDateTime;
  final String content;

  CommentModel(
      {required this.id,
      required this.communityId,
      required this.authorUUID,
      required this.activate,
      required this.content,
      required this.createdDateTime});

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
