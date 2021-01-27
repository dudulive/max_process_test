import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:max_process_test/shareds/http/abstract_http_service.dart';
import 'package:max_process_test/shareds/models/login/dados_login_model.dart';
import 'package:max_process_test/shareds/models/login/login_password_model.dart';

class ApiService extends AbstractHttpService {

  Future<DadosLoginModel> login(
      BuildContext context, LoginPasswordModel loginPasswordModel) async {
    try {
      final String response = await this
          .createInterceptorContentTypeJson(context)
          .post('/api/Login',
          loginPasswordModel.toJson(), context);
      return DadosLoginModel.fromJson(jsonDecode(response));
    } catch (err) {
      throw err;
    }
  }



}