import 'package:flutter/material.dart';

class AppConfig {
  /// API Config
  static const Duration timeout = Duration(seconds: 60);
  static const logNetworkRequest = true;
  static const logNetworkRequestHeader = true;
  static const logNetworkRequestBody = true;
  static const logNetworkResponseHeader = false;
  static const logNetworkResponseBody = true;
  static const logNetworkError = true;

  static init() async {}
}
