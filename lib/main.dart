import 'package:flutter/material.dart';
import 'package:max_process_test/database/app_database.dart';
import 'package:max_process_test/modules/home/home_page.dart';
import 'package:max_process_test/modules/login/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppDataBase appDataBase = new AppDataBase("");
    appDataBase.createOrUpdateDatabase(context);
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new HomePage(),
        '/login': (BuildContext context) => new LoginPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Max Procress',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
