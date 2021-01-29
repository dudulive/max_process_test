import 'package:flutter/material.dart';
import 'package:max_process_test/services/api_service.dart';
import 'package:max_process_test/shareds/models/listagem/listagem_model.dart';
import 'package:max_process_test/util/http_util.dart';
import 'package:max_process_test/util/modal_util.dart';
import 'package:max_process_test/util/screen_util.dart';
import "package:mobx/mobx.dart";

part "listagem_controller.g.dart";

class ListagemController = ListagemControllerBase with _$ListagemController;

abstract class ListagemControllerBase with Store {
  ApiService _apiService = new ApiService();

  @observable
  List<ListagemModel> lista = new List();

  Future<void> listagem(BuildContext context) async {
    await _apiService.listagem(context).then((value) {
      lista = value;
    }).catchError((error) {
      if (error.getStatusCode() == 401) {
        ModalUtil.openModalBlueWithIcon(
                Icon(
                  Icons.error,
                  color: Colors.white,
                  size: ScreenUtil().setSp(110),
                ),
                "Usuário ou senha inválidos",
                context)
            .then((value) => Navigator.of(context).pushNamed("login"));
      } else {
        ModalUtil.openModalBlueWithIcon(
                Icon(
                  Icons.error,
                  color: Colors.white,
                  size: ScreenUtil().setSp(110),
                ),
                HttpUtil.tratarRetornoComMensagemPadrao(
                    error, error.getMessage()),
                context)
            .then((value) => Navigator.of(context).pushNamed("home"));
      }
    });
  }
}
