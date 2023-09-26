// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_repository.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

// _MainRepository 클래스는 MainRepository 인터페이스를 구현한 클래스
class _MainRepository implements MainRepository {
  //생성자가 Dio 클라이언트 인스턴스와 선택적인 baseUrl 파라미터를 받습니다.
  // Dio 클라이언트는 HTTP 요청을 생성하고 보내는 데 사용되며,
  // baseUrl은 API 호출의 기본 URL을 설정합니다.
  _MainRepository(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  // getMainData 메서드는 MainRepository 인터페이스에 정의된 메서드
  // 이 메서드는 Dio를 사용하여 실제 API 호출을 수행, 응답을 ResponseModel<MainModel> 형태로 반환
  @override
  Future<ResponseModel<MainModel>> getMainData() async {
    // 요청은 Options 객체와 경로, 쿼리 파라미터, 데이터를 포함하여 구성
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    // Dio 클라이언트의 fetch 메서드를 호출하여 API 요청을 수행
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<MainModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/main',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<MainModel>.fromJson(
      _result.data!,
      (json) => MainModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }
// 응답 타입에 따라 ResponseOptions를 설정하는 메서드
// 응답 타입에 따라 JSON, 문자열 등의 형태로 응답을 처리
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
}
