import 'package:json_annotation/json_annotation.dart';

part 'qna_model.g.dart';

@JsonSerializable()
class QnaModel {
  final int id;
  final String title;
  final String content;
  final bool activate;
  final String createdDateTime;

  QnaModel({
    required this.id,
    required this.title,
    required this.content,
    required this.activate,
    required this.createdDateTime
  });

  factory QnaModel.fromJson(Map<String, dynamic> json) => _$QnaModelFromJson(json);

  Map<String, dynamic> toJson() => _$QnaModelToJson(this);
}