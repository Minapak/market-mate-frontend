// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matching_repository.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _MatchingRepository implements MatchingRepository {
  _MatchingRepository(this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ResponseModel<Pagination<MatchingModel>>> paginate({
    paginationParams = const BasicPaginationParams(),
    required id,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(paginationParams.toJson());
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<Pagination<MatchingModel>>>(Options(
          method: 'GET',
          headers: _headers,
          extra: _extra,
        )
            .compose(
          _dio.options,
          '/${id}/matchings',
          queryParameters: queryParameters,
          data: _data,
        )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<Pagination<MatchingModel>>.fromJson(
      _result.data!,
          (json) =>
      Pagination<MatchingModel>.fromJson(
        json as Map<String, dynamic>,
            (json) => MatchingModel.fromJson(json as Map<String, dynamic>),
      ),
    );
    return value;
  }

  @override
  Future<ResponseModel<Pagination<MatchingModel>>> paginatewholesalerMatchings({
    paginationParams = const BasicPaginationParams(),
    required id,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(paginationParams.toJson());
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<Pagination<MatchingModel>>>(Options(
          method: 'GET',
          headers: _headers,
          extra: _extra,
        )
            .compose(
          _dio.options,
          'wholesaler/${id}/matchings',
          queryParameters: queryParameters,
          data: _data,
        )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<Pagination<MatchingModel>>.fromJson(
      _result.data!,
          (json) =>
      Pagination<MatchingModel>.fromJson(
        json as Map<String, dynamic>,
            (json) => MatchingModel.fromJson(json as Map<String, dynamic>),
      ),
    );
    return value;
  }

  @override
  Future<ResponseModel<Pagination<MatchingModel>>> paginateExpertMatchings({
    paginationParams = const BasicPaginationParams(),
    required id,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(paginationParams.toJson());
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<Pagination<MatchingModel>>>(Options(
          method: 'GET',
          headers: _headers,
          extra: _extra,
        )
            .compose(
          _dio.options,
          'experts/${id}/matchings',
          queryParameters: queryParameters,
          data: _data,
        )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<Pagination<MatchingModel>>.fromJson(
      _result.data!,
          (json) =>
      Pagination<MatchingModel>.fromJson(
        json as Map<String, dynamic>,
            (json) => MatchingModel.fromJson(json as Map<String, dynamic>),
      ),
    );
    return value;
  }

  @override
  Future<ResponseModel<MatchingModel>> createMatching({required data}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<MatchingModel>>(Options(
          method: 'POST',
          headers: _headers,
          extra: _extra,
        )
            .compose(
          _dio.options,
          '/users/matchings',
          queryParameters: queryParameters,
          data: _data,
        )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<MatchingModel>.fromJson(
      _result.data!,
          (json) => MatchingModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }


  @override
  Future<ResponseModel<MatchingWSModel>> createWSMatching(
      {required CreateMatchingWSModel data}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamWSType<ResponseModel<MatchingWSModel>>(Options(
          method: 'POST',
          headers: _headers,
          extra: _extra,
        )
            .compose(
          _dio.options,
          '/wholesaler/matchings',
          queryParameters: queryParameters,
          data: _data,
        )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<MatchingWSModel>.fromJson(
      _result.data!,
          (json) => MatchingWSModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  RequestOptions _setStreamWSType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}