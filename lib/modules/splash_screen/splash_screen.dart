import 'package:flutter/material.dart';
import 'package:max_process_test/database/dao/usuario_dao.dart';
import 'package:max_process_test/util/screen_util.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((value) async {
      UsuarioDAO usuarioDAO = new UsuarioDAO();
      DateTime dataExpiracao = await usuarioDAO.consultarDataExpiracao(context);
      if (DateTime.now().isAfter(dataExpiracao)) {
        usuarioDAO.deletarTodos(context);
        Navigator.pushNamed(context, "/login");
      } else {
        Navigator.pushNamed(context, "/home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil().init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: new BoxDecoration(color: Colors.white),
        child: Center(
            child: Container(
          color: Colors.transparent,
          child: Image.asset("lib/assets/logo_max1.jpg"),
        )),
      ),
    );
  }
}
