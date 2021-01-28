import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:max_process_test/database/dao/usuario_dao.dart';
import 'package:max_process_test/shareds/exceptions/app_exception.dart';

import 'logging_interceptor.dart';

class AbstractHttpService {
  static const int TEMPO_TIMEOUT = 60;
  static const String URL = "http://treinamento.duckdns.org:45456";

  Client _client;

  Map<String, String> headers = new Map<String, String>();

  createInterceptorContentTypeJson(context, {tempoTimeout}) {
    headers['Content-Type'] = "application/json";
    LoggingInterceptor interceptor =
        LoggingInterceptor(context: context, headers: headers);
    this._client = HttpClientWithInterceptor.build(
        interceptors: [interceptor],
        requestTimeout: Duration(seconds: tempoTimeout ?? TEMPO_TIMEOUT));
    return this;
  }

  Future<dynamic> post(path, body, context) async {
    HttpClient http = new HttpClient();
    http.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => Platform.isAndroid);
    final Response response = await this
        ._client
        .post(URL + path, headers: headers, body: jsonEncode(body));

    return _returnResponse(response);
  }

  Future<dynamic> get(path, context) async {
    HttpClient http = new HttpClient();
    http.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => Platform.isAndroid);
    final response = await this._client.get(URL + path, headers: headers);
    return _returnResponse(response);
  }

  dynamic _returnResponse(Response response) {
    Utf8Codec utf8 = new Utf8Codec();
    switch (response.statusCode) {
      case 200:
        return response.body.toString();
      default:
        throw AppException(
            utf8.decode(response.bodyBytes).toString(), response.statusCode);
    }
  }
}
