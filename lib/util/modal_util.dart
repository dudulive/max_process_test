import 'package:flutter/material.dart';
import 'package:max_process_test/resources/values/ui_color.dart';
import 'package:max_process_test/util/screen_util.dart';

class ModalUtil {

  static Future<void> openModalBlueWithIcon(
      Widget icon, String mensagem, context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: icon,
          backgroundColor: UIColor.PRIMARY_COLOR,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  mensagem,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(50)),
                ),
                SizedBox(
                  height: ScreenUtil.screenHeightPerc(2),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: ScreenUtil.screenWidthPerc(30),
                      height: ScreenUtil.screenHeightPerc(6),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: UIColor.ACCENT_COLOR, width: 2),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        colorBrightness: Brightness.dark,
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Entendi',
                              style: TextStyle(
                                color: UIColor.ACCENT_COLOR,
                                fontSize: ScreenUtil().setSp(50),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}