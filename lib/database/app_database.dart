import 'package:flutter/material.dart';
import 'package:max_process_test/database/dao/usuario_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase {
  static AppDataBase _instance;
  static String table;
  static Database db;

  factory AppDataBase(tableName) {
    table = tableName;
    if (_instance != null) return _instance;
    _instance = new AppDataBase._internal();
    return _instance;
  }

  AppDataBase._internal();

  Future<Database> openDb(BuildContext context) async {
    final String path = join(await getDatabasesPath(), 'max_process.db');
    return openDatabase(path, version: getDatabaseVersion());
  }

  createOrUpdateDatabase(BuildContext context) async {
    final String path = join(await getDatabasesPath(), 'max_process.db');
    await openDatabase(
      path,
      onCreate: (db, version) {
        _getTablesSql().forEach((tableSql) => db.execute(tableSql));
      },
      onUpgrade: (db, oldVersion, newVersion) {
        _dropTables().forEach((tableSql) => db.execute(tableSql));
        _getTablesSql().forEach((tableSql) => db.execute(tableSql));
      },
      version: getDatabaseVersion(),
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  int getDatabaseVersion() {
    return 1;
  }

  List<String> _getTablesSql() {
    List<String> tabelas = List();
    tabelas.add(UsuarioDAO.tbUsuario);

    return tabelas;
  }

  List<String> _dropTables() {
    List<String> tabelas = List();
    tabelas.add(UsuarioDAO.droptb);

    return tabelas;
  }
}
