import 'package:json_annotation/json_annotation.dart';

part 'server_status_model.g.dart';

abstract class ServerStatusBase {
  const ServerStatusBase();
}

class ServerStatusInitial extends ServerStatusBase {
  const ServerStatusInitial();
}

class ServerStatusLoading extends ServerStatusBase {
  const ServerStatusLoading();
}

class ServerStatusError extends ServerStatusBase {
  final String message;

  ServerStatusError({required this.message});
}

class ServerStatusSuccess extends ServerStatusBase{
  const ServerStatusSuccess();
}

@JsonSerializable(genericArgumentFactories: true)
class ServerStatusDataSuccess<T> extends ServerStatusBase{
  final T data;

  const ServerStatusDataSuccess({required this.data});

  ServerStatusDataSuccess copyWith({T? data}) {
    return ServerStatusDataSuccess(data: data ?? this.data);
  }

  factory ServerStatusDataSuccess.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT
      ) => _$ServerStatusDataSuccessFromJson(json, fromJsonT);
}

