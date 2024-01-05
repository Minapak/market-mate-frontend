// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expert_repository.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ExpertRepository implements ExpertRepository {
  _ExpertRepository(this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ResponseModel<Pagination<ExpertModel>>> paginate(
      {paginationParams = const ExpertsPaginationParams()}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(paginationParams?.toJson() ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<Pagination<ExpertModel>>>(Options(
          method: 'GET',
          headers: _headers,
          extra: _extra,
        )
            .compose(
          _dio.options,
          '/',
          queryParameters: queryParameters,
          data: _data,
        )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<Pagination<ExpertModel>>.fromJson(
      _result.data!,
          (json) =>
      Pagination<ExpertModel>.fromJson(
        json as Map<String, dynamic>,
            (json) => ExpertModel.fromJson(json as Map<String, dynamic>),
      ),
    );
    return value;
  }


  @override
  Future<ResponseModel<ExpertModel>> getDetail({required id, required phone}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<ExpertModel>>(Options(
          method: 'GET',
          headers: _headers,
          extra: _extra,
        )
            .compose(
          _dio.options,
          '${id}',
          queryParameters: queryParameters,
          data: _data,
        )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    print('Base URL: ${baseUrl ?? _dio.options.baseUrl}');
    final completeUrl = '${baseUrl ?? _dio.options.baseUrl}${id}';
    print('Complete URL: $completeUrl');
    // 응답 값 로그
    print('Response: $_result');
    final responseData = _result.data as Map<String, dynamic>;
    final resData = responseData['response'] as Map<String, dynamic>;
    final idd = responseData['id'];
    final nameValue = resData['name'];
    print('Name: $nameValue');
    final phoneValue = resData['phone'];
    print('Phone: $phoneValue');
    // final phone = responseData['phone'];
    print('Response Data: ${_result.data}');
    print('ID: $idd');
    print('id???????: $id');
    print('Res Data: $resData');
// SharedPreferences에 저장
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameValue);
    await prefs.setString('phone', phoneValue);
    final value = ResponseModel<ExpertModel>.fromJson(
      _result.data!,

          (json) => ExpertModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }


  @override
  Future<ResponseModel<Pagination<ReviewModel>>> reviewPaginate({
    paginationParams = const BasicPaginationParams(),
    required id,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(paginationParams?.toJson() ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<Pagination<ReviewModel>>>(Options(
          method: 'GET',
          headers: _headers,
          extra: _extra,
        )
            .compose(
          _dio.options,
          '/${id}/reviews',
          queryParameters: queryParameters,
          data: _data,
        )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<Pagination<ReviewModel>>.fromJson(
      _result.data!,
          (json) =>
      Pagination<ReviewModel>.fromJson(
        json as Map<String, dynamic>,
            (json) => ReviewModel.fromJson(json as Map<String, dynamic>),
      ),
    );
    return value;
  }

  @override
  Future<ResponseModel<WishlistModel>> createWishlist({
    required expertId,
    required data,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<WishlistModel>>(Options(
          method: 'POST',
          headers: _headers,
          extra: _extra,
        )
            .compose(
          _dio.options,
          '/experts/${expertId}/wishlists',
          queryParameters: queryParameters,
          data: _data,
        )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<WishlistModel>.fromJson(
      _result.data!,
          (json) => WishlistModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ResponseModel<bool>> deleteWishlist({
    required userId,
    required wishlistId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<bool>>(Options(
          method: 'DELETE',
          headers: _headers,
          extra: _extra,
        )
            .compose(
          _dio.options,
          '/${userId}/experts/wishlists/${wishlistId}',
          queryParameters: queryParameters,
          data: _data,
        )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<bool>.fromJson(
      _result.data!,
          (json) => json as bool,
    );
    return value;
  }

  @override
  Future<ResponseModel<ResponseCheckWishModel>> checkUserWish({
    required userId,
    required expertId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<ResponseCheckWishModel>>(Options(
          method: 'GET',
          headers: _headers,
          extra: _extra,
        )
            .compose(
          _dio.options,
          '/${userId}/experts/${expertId}/wishlist',
          queryParameters: queryParameters,
          data: _data,
        )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<ResponseCheckWishModel>.fromJson(
      _result.data!,
          (json) =>
          ResponseCheckWishModel.fromJson(json as Map<String, dynamic>),
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
  Future<ResponseModel<ImageResponseModel>> updateImage({
    required id,
    required image,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.files.add(MapEntry(
      'image',
      MultipartFile.fromFileSync(
        image.path,
        filename: image.path
            .split(Platform.pathSeparator)
            .last,
      ),
    ));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<ImageResponseModel>>(Options(
          method: 'PUT',
          headers: _headers,
          extra: _extra,
          contentType: 'multipart/form-data',
        )
            .compose(
          _dio.options,
          '/${id}/image',
          queryParameters: queryParameters,
          data: _data,
        )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<ImageResponseModel>.fromJson(
      _result.data!,
          (json) => ImageResponseModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }


  @override
  Future<ResponseModel<ExpertRegisterModel>> ExpertsRegister(
      {required int id, required ExpertRegisterModel data}) {
    // TODO: implement ExpertsRegiser
    throw UnimplementedError();
  }


  @override
  Future<ResponseModel<ExpertRegisterModel>> ExpertsUploadthumbnail(
      {required int id, required File image}) {
    // TODO: implement ExpertsUploadthumbnail
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<ExpertRegisterModel>> ExpertsUploadDetail(
      {required int id, required File thumnail, required String introduceExpert, required String introduceContent}) {
    // TODO: implement ExpertsUploadDetail
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<ExpertRegisterModel>> ExpertsUploadImage(
      {required int id, required List<XFile> images}) {
    // TODO: implement ExpertsUploadImage
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<ExpertModel>> getDetailPhone(
      {required int id, required String phoneNumber}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<ExpertModel>>(Options(
          method: 'GET',
          headers: _headers,
          extra: _extra,
        )
            .compose(
          _dio.options,
          '/${phoneNumber}/',
          queryParameters: queryParameters,
          data: _data,
        )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<ExpertModel>.fromJson(
      _result.data!,

          (json) => ExpertModel.fromJson(json as Map<String, dynamic>),
    );

    return value;
  }

// // 맴버 정보 받아옴
//   final memberFutureProvider = FutureProvider<MemberModel>((ref) async {
//     try {
//       final Dio dio = Dio();
//
//       final MemberRepository repository =
//       MemberRepository(dio, baseUrl: '$SERVER_BASE_URL/members');
//       final authModel = ref.watch(authProvider);
//       print(authModel.userUUID);
//       final ExpertModel = ref.watch(SelectExpertDetail);
//       print(ExpertModel.phone);
//
//       final res = await repository.getMember(id: authModel.userUUID ?? '');
//       final res1 = await repository.getDetailphone(id: authModel.userUUID ?? '');
//       return res.response;
//     } catch (error) {
//       print(error);
//       throw Exception("Failed to fetch User");
//     }
//   });
//
// }
}