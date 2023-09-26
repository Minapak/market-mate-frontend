import 'package:json_annotation/json_annotation.dart';

part 'response_check_wish_model.g.dart';

@JsonSerializable()
class ResponseCheckWishModel {
  final int? id;
  final bool isChecked;

  ResponseCheckWishModel({this.id = 9, required this.isChecked});

  ResponseCheckWishModel copyWith({int? id, bool? isChecked}) {
    return ResponseCheckWishModel(id: id ?? this.id, isChecked: isChecked ?? this.isChecked);
  }

  factory ResponseCheckWishModel.fromJson(Map<String, dynamic> json) => _$ResponseCheckWishModelFromJson(json);
}