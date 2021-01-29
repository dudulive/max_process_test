import 'package:flutter/material.dart';
import 'package:max_process_test/database/dao/usuario_dao.dart';
import 'package:max_process_test/services/api_service.dart';
import 'package:max_process_test/shareds/models/login/login_password_model.dart';
import 'package:max_process_test/util/http_util.dart';
import 'package:max_process_test/util/modal_util.dart';
import 'package:max_process_test/util/screen_util.dart';
import "package:mobx/mobx.dart";

part "login_controller.g.dart";

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  ApiService _apiService = new ApiService();
  UsuarioDAO _usuarioDAO = new UsuarioDAO();

  @observable
  TextEditingController login = new TextEditingController();
  @observable
  TextEditingController senha = new TextEditingController();
  @observable
  bool passwordVisitibility = false;

  @action
  limparCampos() {
    senha.clear();
    login.clear();
  }

  @action
  Future<void> avancar(LoginPasswordModel loginPasswordModel, context) async {
    await _apiService.login(context, loginPasswordModel).then((value) async {
      await _usuarioDAO.deletarTodos(context);
      await _usuarioDAO.salvar(context, value);
      Navigator.of(context).pushNamed('/home');
    }).catchError((error) {
      if (error.getStatusCode() == 401) {
        ModalUtil.openModalBlueWithIcon(
            Icon(
              Icons.error,
              color: Colors.white,
              size: ScreenUtil().setSp(110),
            ),
            "Usuário ou senha inválidos",
            context);
      } else {
        ModalUtil.openModalBlueWithIcon(
            Icon(
              Icons.error,
              color: Colors.white,
              size: ScreenUtil().setSp(110),
            ),
            HttpUtil.tratarRetornoComMensagemPadrao(error, error.getMessage()),
            context);
      }
    });
  }
}
