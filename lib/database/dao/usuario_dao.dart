import 'package:flutter/material.dart';
import 'package:max_process_test/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

import '../../shareds/models/login/dados_login_model.dart';

class UsuarioDAO {
  AppDataBase appDataBase;

  static const String TB_USUARIO = 'usuario';
  static const String LOGIN = 'login';
  static const String TOKEN = 'token';
  static const String ID_EMPRESA = 'idEmpresa';
  static const String ID_USUARIO = 'idUsuario';
  static const String ID_PESSOA = 'idPessoa';
  static const String DATA_EXEPIRACAO = 'dataExpiracao';

  static const String tbUsuario = "CREATE TABLE $TB_USUARIO (" +
      "$LOGIN text primary key," +
      "$TOKEN text," +
      "$ID_EMPRESA integer," +
      "$ID_USUARIO integer," +
      "$ID_PESSOA integer," +
      "$DATA_EXEPIRACAO text" +
      ")";

  static const String droptb = 'DROP TABLE IF EXISTS $TB_USUARIO';

  UsuarioDAO() {
    appDataBase = new AppDataBase(TB_USUARIO);
  }

  Future<int> salvar(
      BuildContext context, DadosLoginModel dadosLoginModel) async {
    try {
      DadosLoginModel consulta = await consultar(context);
      if (consulta != null) {
        await deletar(context, consulta);
      }
      return (await appDataBase.openDb(context))
          .insert(TB_USUARIO, dadosLoginModel.toJson());
    } catch (err) {
      throw err;
    }
  }

  Future<int> alterar(
      BuildContext context, DadosLoginModel dadosLoginModel) async {
    return (await appDataBase.openDb(context)).update(
        TB_USUARIO, dadosLoginModel.toJson(),
        where: '$LOGIN = ?', whereArgs: [dadosLoginModel.login]);
  }

  Future<int> deletar(
      BuildContext context, DadosLoginModel dadosLoginModel) async {
    return (await appDataBase.openDb(context)).delete(TB_USUARIO,
        where: '$LOGIN = ?', whereArgs: [dadosLoginModel.login]);
  }

  Future<int> deletarTodos(BuildContext context) async {
    return (await appDataBase.openDb(context)).delete(TB_USUARIO);
  }

  Future<DadosLoginModel> consultar(BuildContext context) async {
    try {
      final Database db = await appDataBase.openDb(context);
      final List<Map<String, dynamic>> maps = await db.query(TB_USUARIO);
      if (maps != null && maps.length > 0) {
        return DadosLoginModel.fromJson(maps[0]);
      }
    } catch (err) {
      throw err;
    }
    return null;
  }

  Future<String> consultarToken(BuildContext context) async {
    try {
      final Database db = await appDataBase.openDb(context);
      final List<Map<String, dynamic>> maps = await db.query(TB_USUARIO);
      if (maps != null && maps.length > 0) {
        return DadosLoginModel.fromJson(maps[0]).token;
      }
    } catch (err) {
      throw err;
    }
    return null;
  }

  Future<DateTime> consultarDataExpiracao(BuildContext context) async {
    try {
      final Database db = await appDataBase.openDb(context);
      final List<Map<String, dynamic>> maps = await db.query(TB_USUARIO);
      if (maps != null && maps.length > 0) {
        return DadosLoginModel.fromJson(maps[0]).getDataExpiracao();
      }
    } catch (err) {
      throw err;
    }
    return null;
  }
}
