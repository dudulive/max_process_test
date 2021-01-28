import 'package:flutter/material.dart';
import 'package:max_process_test/resources/values/ui_color.dart';
import 'package:max_process_test/util/screen_util.dart';

class CustomCircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      width: ScreenUtil.screenWidthDp,
      height: ScreenUtil.screenHeightDp,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(UIColor.ACCENT_COLOR),
            strokeWidth: 5.0,
          ),
          Text(
            "Carregando dados...",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: UIColor.ACCENT_COLOR,
                decoration: TextDecoration.none),
          )
        ],
      ),
    );
  }
}
