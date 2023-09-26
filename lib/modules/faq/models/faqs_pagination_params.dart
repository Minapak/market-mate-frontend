import 'package:json_annotation/json_annotation.dart';

part 'faqs_pagination_params.g.dart';

@JsonSerializable()
class FaqsPaginationParams {
  final int? page;
  final int? categoryId;
  final int? limit;

  const FaqsPaginationParams({
    this.page,
    this.categoryId,
    this.limit,
  });

  FaqsPaginationParams copyWith({
    int? page,
    int? categoryId,
    int? limit,
  }) {
    return FaqsPaginationParams(
        page: page ?? this.page,
        categoryId: categoryId ?? this.categoryId,
        limit: limit ?? this.limit);
  }

  factory FaqsPaginationParams.fromJson(Map<String, dynamic> json) =>
      _$FaqsPaginationParamsFromJson(json);


  Map<String, dynamic> toJson() => _$FaqsPaginationParamsToJson(this);
}
