import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:max_process_test/shareds/http/abstract_http_service.dart';
import 'package:max_process_test/shareds/models/listagem/listagem_model.dart';
import 'package:max_process_test/shareds/models/login/dados_login_model.dart';
import 'package:max_process_test/shareds/models/login/login_password_model.dart';

class ApiService extends AbstractHttpService {
  Future<DadosLoginModel> login(
      BuildContext context, LoginPasswordModel loginPasswordModel) async {
    try {
      final String response = await this
          .create()
          .postNoAuthorization('/api/Login', loginPasswordModel.toJson(), context);
      return DadosLoginModel.fromJson(jsonDecode(response));
    } catch (err) {
      throw err;
    }
  }

  Future<List<ListagemModel>> listagem(BuildContext context) async {
    try {
      final String path = '/api/weatherforecast/dados';
      //final String path = '/api/weatherforecast';
      final String response = await this.create().get(path, context);
      List<ListagemModel> listagem = List();
      for (Map<String, dynamic> map in jsonDecode(response)) {
        listagem.add(ListagemModel.fromJson(map));
      }
      return listagem;
    } catch (err) {
      throw err;
    }
  }
}
