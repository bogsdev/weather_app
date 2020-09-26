import 'package:dio/dio.dart';

import 'http_constants.dart';

class HTTPConfig {
  final String host;
  final int connectTimeOut;
  final int receiveTimeout;

  HTTPConfig(this.host,
      {this.connectTimeOut: defaultConnectTimeOut,
      this.receiveTimeout: defaultReadTimeOut});
}
