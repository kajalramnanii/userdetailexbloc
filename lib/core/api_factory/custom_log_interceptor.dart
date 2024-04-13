import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class CustomLogInterceptor extends Interceptor {
  final bool? request,
      requestHeader,
      requestBody,
      responseHeader,
      responseBody,
      error;

  CustomLogInterceptor(
      {this.request,
      this.requestHeader,
      this.requestBody,
      this.responseHeader,
      this.responseBody,
      this.error});

  String cURLRepresentation(RequestOptions options) {
    List<String> components = ["curl -i"];
    if (options.method.toUpperCase() == "GET") {
      components.add("-X ${options.method}");
    }

    options.headers.forEach((k, v) {
      if (k != "Cookie") {
        components.add("-H \"$k: $v\"");
      }
    });

    var data = json.encode(options.data);
    data = data.replaceAll('\'', '');
    components.add("-d \"$data\"");

    components.add("\"${options.uri.toString()}\"");

    return components.join('\\\n\t');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('*** Response ***', name: 'dio');
    log(response.toString());
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (error!) {
      log('*** DioError ***:', name: 'dio');
      log('uri: ${err.requestOptions.uri}', name: 'dio');
      log('$err', name: 'dio');
      if (err.response != null) {
        log('${err.response!}');
      }
      log('');
    }

    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('================================ \n \n');
    print(
      """Curl REQUEST:\n
    ${cURLRepresentation(options)}\n
    """,
    );
    log('================================ \n \n');
    handler.next(options);
  }
}
