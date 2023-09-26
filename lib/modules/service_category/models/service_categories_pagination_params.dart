import 'package:json_annotation/json_annotation.dart';

part 'service_categories_pagination_params.g.dart';

@JsonSerializable()
class ServiceCategoriesPaginationParams {
  final int? page;
  final String? serviceType;
  final int? limit;

  const ServiceCategoriesPaginationParams({
    this.page,
    this.serviceType,
    this.limit,
  });

  ServiceCategoriesPaginationParams copyWith({
    int? page,
    String? serviceType,
    int? limit,
  }) {
    return ServiceCategoriesPaginationParams(
        page: page ?? this.page,
        serviceType: serviceType ?? this.serviceType,
        limit: limit ?? this.limit);
  }

  factory ServiceCategoriesPaginationParams.fromJson(Map<String, dynamic> json) =>
    _$ServiceCategoriesPaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceCategoriesPaginationParamsToJson(this);
}
