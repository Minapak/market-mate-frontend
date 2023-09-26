import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

abstract class PaginationBase {}

class PaginationError extends PaginationBase {
  final String message;

  PaginationError({
    required this.message,
  });
}

class PaginationLoading extends PaginationBase {}

@JsonSerializable(genericArgumentFactories: true)
class Pagination<T> extends PaginationBase {
  final bool hasMore;
  final int totalPages;
  final int totalElements;
  final List<T> content;

  Pagination(
      {required this.hasMore,
      required this.totalPages,
      required this.totalElements,
      required this.content});

  Pagination copyWith({
    bool? hasMore,
    int? totalPages,
    int? totalElements,
    List<T>? content,
  }) {
    return Pagination(
        hasMore: hasMore ?? this.hasMore,
        totalPages: totalPages ?? this.totalElements,
        totalElements: totalElements ?? this.totalElements,
        content: content ?? this.content);
  }

  factory Pagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PaginationFromJson(json, fromJsonT);
}

// 새로고침
class PaginationRefetching<T> extends Pagination<T> {
  PaginationRefetching({
    required super.hasMore,
    required super.totalPages,
    required super.totalElements,
    required super.content,
  });
}

// 추가 데이터 요청
class PaginationFetchingMore<T> extends Pagination<T> {
  PaginationFetchingMore({
    required super.hasMore,
    required super.totalPages,
    required super.totalElements,
    required super.content,
  });
}
