import 'package:max_process_test/database/dao/usuario_dao.dart';
import 'package:max_process_test/shareds/models/login/dados_login_model.dart';
import "package:mobx/mobx.dart";

part "home_controller.g.dart";

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {

  UsuarioDAO _usuarioDAO = new UsuarioDAO();

  @action
  Future<DadosLoginModel> consultarUsuario(context) {
    _usuarioDAO.consultar(context);
  }
}