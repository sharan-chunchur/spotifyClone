import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../application/app_prefs.dart';
import '../../application/constants.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  // AppPreferences appPreferences;

  DioFactory();

  Future<Dio> getDio() async {
    Dio dio = Dio();

    Duration timeOut = const Duration(minutes: 1);
    String language = "en";

    Map<String, String> headers = {
      'X-RapidAPI-Key': '685f8a8349mshaf203e9afcb9340p13de13jsn35ebb19242dd',
      'X-RapidAPI-Host': 'spotify23.p.rapidapi.com'
    };

    dio.options = BaseOptions(
        contentType: 'application/json',
        baseUrl: Constants.baseUrl,
        connectTimeout: timeOut,
        receiveTimeout: timeOut,
        headers: headers);

    if (kReleaseMode) {
      print("release mode no logs");
    } else {
      dio.interceptors.add(PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        logPrint: (log) {
          debugPrint(log as String);
        },
      ));
    }

    return dio;
  }
}
