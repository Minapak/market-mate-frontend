import 'package:json_annotation/json_annotation.dart';

part 'basic_pagination_params_model.g.dart';

@JsonSerializable()
class BasicPaginationParams {
  final int? id;
  final int? page;
  final int? limit;

  const BasicPaginationParams({this.id, this.page, this.limit});

  BasicPaginationParams copyWith({
    int? id,
    int? page,
    int? limit,
  }) {
    return BasicPaginationParams(
        id: id ?? this.id, limit: limit ?? this.limit, page: page ?? this.page);
  }

  factory BasicPaginationParams.fromJson(Map<String, dynamic> json) =>
      _$BasicPaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$BasicPaginationParamsToJson(this);
}
