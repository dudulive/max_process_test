import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_interceptor/interceptor_contract.dart';
import 'package:max_process_test/database/dao/usuario_dao.dart';

class LoggingInterceptor implements InterceptorContract {
  static const _AUTHORIZATION = 'Authorization';

  BuildContext _context;
  Map<String, String> _headers;
  UsuarioDAO usuarioDAO = new UsuarioDAO();

  LoggingInterceptor({context, headers}) {
    _context = context;
    this._headers = headers;
  }

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('##################################################');
    print('################## REQUEST DATA ##################');
    print('${data.method}: ${data.baseUrl}');
    print('BODY: ${data.body}');
    data.headers.addAll(_headers);

    if (_context != null) {
      String token = await usuarioDAO.consultarToken(_context);
      data.headers[_AUTHORIZATION] = token;
    }
    print('HEADERS: ${data.headers}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('################## RESPONSE DATA #################');
    print('${data.method}:  ${data.url}');
    print('STATUS: ${data.statusCode}');
    print('HEADERS: ${data.headers}');
    print('BODY: ${data.body}');
    print('##################################################');

    return data;
  }
}
