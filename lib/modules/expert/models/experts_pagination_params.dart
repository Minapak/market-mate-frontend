import 'package:json_annotation/json_annotation.dart';

part 'experts_pagination_params.g.dart';

@JsonSerializable()
class ExpertsPaginationParams {
  final int? page;
  final int? mainCategoryId;
  final int? subCategoryId;
  final int? limit;
  final int? marketId;

  const ExpertsPaginationParams({
    this.page,
    this.mainCategoryId,
    this.subCategoryId,
    this.marketId,
    this.limit,
  });

  ExpertsPaginationParams copyWith({
    int? page,
    int? mainCategoryId,
    int? subCategoryId,
    int? marketId,
    int? limit,
  }) {
    return ExpertsPaginationParams(
        page: page ?? this.page,
        mainCategoryId: mainCategoryId ?? this.mainCategoryId,
        subCategoryId: subCategoryId ?? this.subCategoryId,
        marketId: marketId ?? this.marketId,
        limit: limit ?? this.limit);
  }

factory ExpertsPaginationParams.fromJson(Map<String, dynamic> json) =>
    _$ExpertsPaginationParamsFromJson(json);

Map<String, dynamic> toJson() => _$ExpertsPaginationParamsToJson(this);
}