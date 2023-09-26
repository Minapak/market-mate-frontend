
import 'package:json_annotation/json_annotation.dart';

part 'faq_model.g.dart';

@JsonSerializable()
class FaqModel {
  final int id;
  final String title;
  final String content;
  final bool activate;
  final String createdDateTime;

  FaqModel({
    required this.id,
    required this.title,
    required this.content,
    required this.activate,
    required this.createdDateTime
  });

  factory FaqModel.fromJson(Map<String ,dynamic> json) => _$FaqModelFromJson(json);

  Map<String, dynamic> toJson() => _$FaqModelToJson(this);
}