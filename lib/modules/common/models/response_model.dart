import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponseModel<T> {
  final String id;
  final String dateTime;
  final bool success;
  final T response;
  final String? error;

  ResponseModel(
      {required this.id,
      required this.dateTime,
      required this.success,
      required this.response,
      this.error});

  ResponseModel copyWith({
    String? id,
    String? dateTime,
    bool? success,
    T? response,
    String? error,
  }) {
    return ResponseModel(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      success: success ?? this.success,
      response: response ?? this.response,
      error: error ?? this.error,
    );
  }

  factory ResponseModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT
  ) =>
    _$ResponseModelFromJson(json, fromJsonT);
}
