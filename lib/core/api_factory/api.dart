import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'dio_factory.dart';

enum HttpMethod { delete, get, patch, post, put }

extension HttpMethods on HttpMethod {
  String? get value {
    switch (this) {
      case HttpMethod.delete:
        return 'DELETE';
      case HttpMethod.get:
        return 'GET';
      case HttpMethod.patch:
        return 'PATCH';
      case HttpMethod.post:
        return 'POST';
      case HttpMethod.put:
        return 'PUT';
      default:
        return null;
    }
  }
}

class Api {
  static Future<void> request({
    bool hideLoadingIndicator = false,
    HttpMethod method = HttpMethod.get,
    required String path,
    required Map<String, dynamic> params,
    required OnResponse onResponse,
    required OnError onError,
  }) async {
    try {
      dio.Response response;
      switch (method) {
        case HttpMethod.post:
          response = await DioFactory.dio!.post(
            path,
            options: Options(
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
              },
            ),
            data: params,
          );
          break;
        case HttpMethod.delete:
          response = await DioFactory.dio!.delete(path,
              data: params,
              options: Options(
                headers: {
                  HttpHeaders.contentTypeHeader: "application/json",
                },
              ));
          break;
        case HttpMethod.get:
          response = await DioFactory.dio!.get(path, queryParameters: params);
          break;
        case HttpMethod.patch:
          response = await DioFactory.dio!.patch(
            path,
            data: params,
          );
          break;
        case HttpMethod.put:
          response = await DioFactory.dio!.put(
            path,
            options: Options(
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
              },
            ),
            data: params,
          );
          break;
        default:
          return;
      }

      onResponse.call(response.data);
    } catch (e) {
      log('message L : $e');
      String errorMessage = "";

      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.unknown) {
          errorMessage = 'Server unreachable';
        } else if (e.type == DioExceptionType.badResponse) {
          if (e.response!.statusCode == 401) {
            DioFactory.initialiseHeaders('');
            // Get.off(const SignUpPage());
            return;
          } else {
            errorMessage = e.response!.data['message'];
          }

          //errorMessage = e.response!.data['detail'];
        } else {
          errorMessage = "Request cancelled";
        }
      } else {
        errorMessage = "Something went wrong! Please try again.";
      }

      /// onError(errorMessage);
      onError.call(errorMessage);
    }
  }
}
