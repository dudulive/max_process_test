import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:max_process_test/modules/home/home_controller.dart';
import 'package:max_process_test/resources/values/ui_color.dart';
import 'package:max_process_test/shareds/widget/max_bottom_navigation_bar_menu.dart';
import '../../util/screen_util.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil().init(context);
    return new WillPopScope(
        onWillPop: () => exit(0),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(child: creatBuild()),
                bottomNavigationBar: MaxBottomNavigationBarMenu(
                  context: context,
                )),
          ],
        ));
  }

  Widget creatBuild() {
    return Column(
      children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(
                  left: 50,
                  right: 50,
                  top: ScreenUtil.screenHeightPerc(40),
                  bottom: 20),
              child: Image.asset("lib/assets/logo_max1.jpg"),
            )),
        labelDadosUsuario(),
      ],
    );
  }

  Align labelDadosUsuario() {
    return Align(
        alignment: Alignment.center,
        child: FutureBuilder(
            future: controller.consultarUsuario(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  );
                default:
                  if (snapshot.hasError && snapshot.data == null) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return Text(
                      "Bem Vindo, ${snapshot.data.login}!",
                      style: TextStyle(
                          color: UIColor.PRIMARY_COLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(60)),
                    );
                  }
              }
            }));
  }
}
