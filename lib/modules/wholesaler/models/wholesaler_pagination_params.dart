import 'package:json_annotation/json_annotation.dart';

part 'wholesaler_pagination_params.g.dart';

@JsonSerializable()
class wholesalerPaginationParams {
  final int? page;
  final int? mainCategoryId;
  final int? subCategoryId;
  final int? limit;

  const wholesalerPaginationParams({
    this.page,
    this.mainCategoryId,
    this.subCategoryId,
    this.limit,
  });

  wholesalerPaginationParams copyWith({
    int? page,
    int? mainCategoryId,
    int? subCategoryId,
    int? limit,
  }) {
    return wholesalerPaginationParams(
        page: page ?? this.page,
        mainCategoryId: mainCategoryId ?? this.mainCategoryId,
        subCategoryId: subCategoryId ?? this.subCategoryId,
        limit: limit ?? this.limit);
  }

factory wholesalerPaginationParams.fromJson(Map<String, dynamic> json) =>
    _$wholesalerPaginationParamsFromJson(json);

Map<String, dynamic> toJson() => _$wholesalerPaginationParamsToJson(this);
}