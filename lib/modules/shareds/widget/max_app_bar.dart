import 'package:flutter/material.dart';
import 'package:max_process_test/util/screen_util.dart';

class MaxAppBar {
  String title;

  MaxAppBar({this.title}) {
    this.title = title;
  }

  AppBar buildAppBar(context) {
    ScreenUtil().init(context);
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Center(
          child: Text(
        title,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(55),
        ),
      )),
      flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xFF023479), Color(0xFF143465)]))),
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.home,
            size: 25,
          ),
        ),
      ],
    );
  }
}
