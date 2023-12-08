  // // GENERATED CODE - DO NOT MODIFY BY HAND
  //
  // part of 'app_api.dart';
  //
  //
  // class AppServiceClient {
  //   _AppServiceClient(
  //       this._dio, {
  //         this.baseUrl,
  //       }) {
  //     baseUrl ??= 'http://www.thecocktaildb.com';
  //   }
  //
  //   final Dio _dio;
  //
  //   String? baseUrl;
  //
  //   @override
  //   Future<Either<Failure, List<DrinksResponse>>> fetchDrink(
  //       String categoryType) async {
  //     const _extra = <String, dynamic>{};
  //     final queryParameters = <String, dynamic>{r'c': categoryType};
  //     final _headers = <String, dynamic>{};
  //     const Map<String, dynamic>? _data = null;
  //     final _result = await _dio.fetch<Map<String, dynamic>>(
  //         _setStreamType<List<DrinksResponse>>(Options(
  //           method: 'GET',
  //           headers: _headers,
  //           extra: _extra,
  //         )
  //             .compose(
  //           _dio.options,
  //           '/api/json/v1/1/filter.php/',
  //           queryParameters: queryParameters,
  //           data: _data,
  //         )
  //             .copyWith(
  //             baseUrl: _combineBaseUrls(
  //               _dio.options.baseUrl,
  //               baseUrl,
  //             ))));
  //     if (_result.statusCode == 200) {
  //       return Right(DrinksListResponse.fromJson(_result.data!).drinks!);
  //     } else {
  //       return Left(Failure(_result.statusCode!, _result.statusMessage!));
  //     }
  //   }
  // }
  //
  //
