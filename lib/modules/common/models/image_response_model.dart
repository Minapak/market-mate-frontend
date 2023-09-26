import 'package:json_annotation/json_annotation.dart';

part 'image_response_model.g.dart';

@JsonSerializable()
class ImageResponseModel {
  final String uuid;
  final String thumbnail;

  ImageResponseModel({required this.uuid, required this.thumbnail});

  factory ImageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageResponseModelToJson(this);
}
