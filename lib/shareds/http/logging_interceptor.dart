import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_interceptor/interceptor_contract.dart';

class LoggingInterceptor implements InterceptorContract {

  static const _AUTHORIZATION = 'Authorization';

  BuildContext _context;
  Map<String, String> _headers;

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
      //AccessTokenModel model = await new Wso2Service().validarToken(_context);
      //data.headers[_AUTHORIZATION] = model.tokenType + " " + model.token;
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
