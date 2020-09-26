import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import 'http_config.dart';

class HTTPClient {
  final HTTPConfig config;
  final Dio client;
  final Logger _logger = Logger("HTTPClient");

  HTTPClient(this.config, this.client) {
    client.options.connectTimeout = config.connectTimeOut;
    client.options.receiveTimeout = config.receiveTimeout;
    client.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      //TODO: Hide sensitive data
      _logger.fine(
          "Request: path:${options?.path} | query: ${options?.queryParameters} | data: ${options?.data}");
      return options; //continue
    }, onResponse: (Response response) async {
      //TODO: Hide sensitive data
      _logger.fine(
          "Response: status code:${response?.statusCode} | body: ${response?.data}");
      return response; // continue
    }, onError: (DioError e) async {
      _logger.severe("Error on WS Call: ${e?.error}", e);
      return e; //continue
    }));
  }
}
