import 'package:flutter/material.dart';
import 'package:max_process_test/resources/values/ui_color.dart';
import 'package:max_process_test/services/api_service.dart';
import 'package:max_process_test/shareds/models/listagem/listagem_model.dart';
import 'package:max_process_test/shareds/widget/custom_circular_progress.dart';
import 'package:max_process_test/shareds/widget/max_app_bar.dart';

import 'package:max_process_test/util/screen_util.dart';

class ListagemPage extends StatefulWidget {
  @override
  _ListagemPageState createState() => _ListagemPageState();
}

class _ListagemPageState extends State<ListagemPage> {
  ApiService apiService = new ApiService();

  @override
  Widget build(BuildContext context) {
    ScreenUtil().init(context);
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: UIColor.ACCENT_COLOR,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: MaxAppBar(title: "Listagem").buildAppBar(context),
          body: SafeArea(
            child: Container(
              child: SingleChildScrollView(
                  child: FutureBuilder(
                      future: apiService.listagem(context),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return CustomCircularProgress();
                          default:
                            if (snapshot.hasError && snapshot.data) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return creatBuild(snapshot.data);
                            }
                        }
                      })),
            ),
          ),
        ),
      ],
    );
  }

  Widget creatBuild(List<ListagemModel> list) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Column(
      children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: Container(
              height: ScreenUtil.screenHeightPerc(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(list[0].datePtBr(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(80))),
                  Text(list[0].temperatureC.toString() + "° C",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(100))),
                  clima(list[0].temperatureC, ScreenUtil().setSp(150))
                ],
              ),
            )),
        Padding(
            padding: EdgeInsets.only(top: ScreenUtil.screenHeightPerc(1)),
            child: Container(
              width: ScreenUtil.screenWidthDp,
              height: isPortrait
                  ? ScreenUtil.screenHeightDp
                  : ScreenUtil.screenHeightDp * 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return item(list[index]);
                        }),
                  )
                ],
              ),
            ))
      ],
    );
  }

  Container item(ListagemModel listagemModel) {
    return Container(
      height: ScreenUtil.screenHeightPerc(10),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: UIColor.ACCENT_COLOR,
            width: 1,
          ),
          color: Colors.white),
      child: FlatButton(
        onPressed: () {},
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Text("Data",
                      style: TextStyle(
                          color: UIColor.PRIMARY_COLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(30))),
                ),
                Expanded(
                  flex: 7,
                  child: Text("Temperatura",
                      style: TextStyle(
                          color: UIColor.PRIMARY_COLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(30))),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Text(listagemModel.datePtBr(),
                      style: TextStyle(
                          color: UIColor.PRIMARY_COLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(50))),
                ),
                Expanded(
                  flex: 3,
                  child: Text(listagemModel.temperatureC.toString() + "° C",
                      style: TextStyle(
                          color: UIColor.PRIMARY_COLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(50))),
                ),
                Expanded(
                  flex: 3,
                  child: Text(listagemModel.temperatureF.toString() + "° F",
                      style: TextStyle(
                          color: UIColor.PRIMARY_COLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(50))),
                ),
                Expanded(
                    flex: 1,
                    child: clima(
                        listagemModel.temperatureC, ScreenUtil().setSp(100)))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Icon clima(int temperatureC, size) {
    if (temperatureC <= 0) {
      return Icon(Icons.ac_unit, color: UIColor.PRIMARY_COLOR, size: size);
    } else if (temperatureC > 0 && temperatureC <= 15) {
      return Icon(Icons.cloud, color: UIColor.PRIMARY_COLOR, size: size);
    } else {
      return Icon(Icons.wb_sunny, color: UIColor.PRIMARY_COLOR, size: size);
    }
  }
}
