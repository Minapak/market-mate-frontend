import 'package:json_annotation/json_annotation.dart';

part 'mypage_pagination_params.g.dart';

@JsonSerializable()
class MypagePaginationParams {
  final int? page;
  final int? mainCategoryId;
  final int? subCategoryId;
  final int? limit;

  const MypagePaginationParams({
    this.page,
    this.mainCategoryId,
    this.subCategoryId,
    this.limit,
  });

  MypagePaginationParams copyWith({
    int? page,
    int? mainCategoryId,
    int? subCategoryId,
    int? limit,
  }) {
    return MypagePaginationParams(
        page: page ?? this.page,
        mainCategoryId: mainCategoryId ?? this.mainCategoryId,
        subCategoryId: subCategoryId ?? this.subCategoryId,
        limit: limit ?? this.limit);
  }

factory MypagePaginationParams.fromJson(Map<String, dynamic> json) =>
    _$MypagePaginationParamsFromJson(json);

Map<String, dynamic> toJson() => _$MypagePaginationParamsToJson(this);
}