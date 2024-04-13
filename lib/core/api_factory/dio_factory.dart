import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../config/app_config.dart';
import 'custom_log_interceptor.dart';

typedef OnError = void Function(String error);
typedef OnResponse<Response> = void Function(Response response);

class DioFactory {
  static final _singleton = DioFactory._instance();

  static Dio? get dio => _singleton._dio;
  static var _authorization = '';

  static void initialiseHeaders(String token) {
    if (token == "") {
      _authorization = "";
    } else {
      _authorization = 'Bearer $token';
    }

    dio!.options.headers[HttpHeaders.authorizationHeader] = _authorization;
  }

  Dio? _dio;

  DioFactory._instance() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '',
        headers: {
          HttpHeaders.authorizationHeader: _authorization,
          HttpHeaders.contentTypeHeader: "application/json"
        },
      ),
    );
    if (!kReleaseMode) {
      _dio!.interceptors.add(
        CustomLogInterceptor(
          request: AppConfig.logNetworkRequest,
          requestHeader: AppConfig.logNetworkRequestHeader,
          requestBody: AppConfig.logNetworkRequestBody,
          responseHeader: AppConfig.logNetworkResponseHeader,
          responseBody: AppConfig.logNetworkResponseBody,
          error: AppConfig.logNetworkError,
        ),
      );
    }
  }
}
