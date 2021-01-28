import 'dart:convert';
import 'dart:io';
import 'package:max_process_test/database/dao/usuario_dao.dart';
import 'package:max_process_test/shareds/exceptions/app_exception.dart';

class AbstractHttpService {
  static const String URL = "https://treinamento.duckdns.org:45456";
  static const _AUTHORIZATION = 'Authorization';

  HttpClient _client;
  UsuarioDAO usuarioDAO = new UsuarioDAO();

  create() {
    _client = new HttpClient();
    _client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => Platform.isAndroid);
    return this;
  }

  Future<dynamic> post(path, body, context) async {
    HttpClientRequest request = await _client.postUrl(Uri.parse(URL + path));
    request.headers.set('content-type', 'application/json');
    String token = await usuarioDAO.consultarToken(context);
    request.headers.set(_AUTHORIZATION, "Bearer " + token);
    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();
    return _returnResponse(response);
  }

  Future<dynamic> postNoAuthorization(path, body, context) async {
    HttpClientRequest request = await _client.postUrl(Uri.parse(URL + path));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();
    return _returnResponse(response);
  }

  Future<dynamic> get(path, context) async {
    HttpClientRequest request = await _client.getUrl(Uri.parse(URL + path));
    request.headers.set('content-type', 'application/json');
    String token = await usuarioDAO.consultarToken(context);
    request.headers.set(_AUTHORIZATION, "Bearer " + token);
    HttpClientResponse response = await request.close();
    return _returnResponse(response);
  }

  dynamic _returnResponse(HttpClientResponse response) async {
    Utf8Codec utf8 = new Utf8Codec();
    switch (response.statusCode) {
      case 200:
        return await response.transform(utf8.decoder).join();
      default:
        throw AppException(
            await response.transform(utf8.decoder).join(), response.statusCode);
    }
  }
}
