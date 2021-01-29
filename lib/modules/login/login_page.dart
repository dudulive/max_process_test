import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:max_process_test/modules/login/login_controller.dart';
import 'package:max_process_test/resources/values/ui_color.dart';
import 'package:max_process_test/shareds/models/login/login_password_model.dart';
import 'package:max_process_test/util/screen_util.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final controller = LoginController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil().init(context);
    return WillPopScope(
        onWillPop: () => exit(0),
        child: Scaffold(
          body: Container(
            height: ScreenUtil.screenHeightPerc(100),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                    margin: EdgeInsets.only(
                        top: 100, bottom: 10, left: 20, right: 20),
                    width: ScreenUtil.screenWidthDp,
                    height: ScreenUtil.screenHeightPerc(80),
                    child: viewNewUser()),
              ),
            ),
          ),
        ));
  }

  Container loading() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(UIColor.ACCENT_COLOR),
            strokeWidth: 5,
          ),
          Text(
            "Carregando",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: UIColor.ACCENT_COLOR,
                decoration: TextDecoration.none),
          )
        ],
      ),
    );
  }

  Container viewNewUser() {
    return Container(
      child: Column(
        children: <Widget>[
          logo(),
          loginFormField(),
          senhaFormField(),
          buttons(),
        ],
      ),
    );
  }

  Container logo() {
    return Container(
      margin: EdgeInsets.only(left: 50, right: 50, top: 10),
      child: Image.asset("lib/assets/logo_max1.jpg"),
    );
  }

  Container loginFormField() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.transparent, width: 5),
            borderRadius: BorderRadius.circular(50)),
        child: Observer(
            builder: (_) => TextFormField(
                  controller: controller.login,
                  enabled: true,
                  minLines: 1,
                  maxLines: 1,
                  autofocus: false,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Campo Obrigatório.';
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  decoration: getOutlineInputBorderDecorationPrefixIcon(
                      'LOGIN',
                      UIColor.ACCENT_COLOR,
                      Icon(
                        Icons.person,
                        color: UIColor.ACCENT_COLOR,
                      )),
                )));
  }

  InputDecoration getOutlineInputBorderDecorationPrefixIcon(
      String labelText, Color color, Widget prefixIcon) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      hintStyle: TextStyle(fontSize: 13.0, color: color),
      labelText: labelText,
      alignLabelWithHint: true,
      labelStyle: TextStyle(color: Colors.black),
      errorStyle: TextStyle(color: Colors.red),
      prefixIcon: prefixIcon,
    );
  }

  Widget whiteFlatButton(Function onPressed, String label) {
    return Container(
      width: ScreenUtil.screenWidthPerc(30),
      height: ScreenUtil.screenHeightPerc(6),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: UIColor.ACCENT_COLOR, width: 2),
      ),
      child: FlatButton(
        onPressed: onPressed,
        colorBrightness: Brightness.dark,
        child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              label,
              style: TextStyle(
                color: UIColor.ACCENT_COLOR,
                fontSize: ScreenUtil().setSp(50),
              ),
            )),
      ),
    );
  }

  InputDecoration getOutlineInputBorderDecorationPassword(
      String labelText, Color color, Widget prefixIcon, Widget sufixIcon) {
    return InputDecoration(
      counterText: "",
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      hintStyle: TextStyle(fontSize: 13.0, color: color),
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.grey[800]),
      errorStyle: TextStyle(color: Colors.red, fontSize: 15),
      prefixIcon: prefixIcon,
      prefixIconConstraints: BoxConstraints(
          minHeight: 30, minWidth: 30, maxHeight: 40, maxWidth: 40),
      suffixIcon: sufixIcon,
      suffixIconConstraints: BoxConstraints(
          minHeight: 30, minWidth: 30, maxHeight: 40, maxWidth: 40),
    );
  }

  Container senhaFormField() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Container(
          height: 50,
          width: ScreenUtil.screenWidthDp,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.transparent, width: 5),
              borderRadius: BorderRadius.circular(50)),
          child: Observer(
              builder: (_) => TextFormField(
                    controller: controller.senha,
                    maxLength: 15,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    keyboardType: TextInputType.text,
                    enableInteractiveSelection: true,
                    autofocus: false,
                    obscureText: controller.passwordVisitibility,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Campo Obrigatório.';
                      }
                      return null;
                    },
                    decoration: getOutlineInputBorderDecorationPassword(
                        "SENHA",
                        UIColor.ACCENT_COLOR,
                        new Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.lock_outline,
                            color: UIColor.ACCENT_COLOR,
                          ),
                        ),
                        GestureDetector(
                          dragStartBehavior: DragStartBehavior.down,
                          onTap: () {
                            setState(() {
                              controller.passwordVisitibility =
                                  !controller.passwordVisitibility;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: controller.passwordVisitibility
                                  ? Icon(
                                      Icons.visibility,
                                      color: UIColor.ACCENT_COLOR,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: UIColor.ACCENT_COLOR,
                                    )),
                        )),
                  )),
        ));
  }

  Container buttons() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: whiteFlatButton(
                  () {
                    controller.limparCampos();
                  },
                  "Limpar",
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: whiteFlatButton(() {
                  if (_formKey.currentState.validate()) {
                    LoginPasswordModel loginPasswordModel =
                        new LoginPasswordModel();
                    loginPasswordModel.login = controller.login.text.trim();
                    loginPasswordModel.password = controller.senha.text.trim();
                    controller.avancar(loginPasswordModel, context);
                  }
                }, "Avancar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
