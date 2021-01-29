import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:max_process_test/database/app_database.dart';
import 'package:max_process_test/modules/home/home_page.dart';
import 'package:max_process_test/modules/listagem/listagem_page.dart';
import 'package:max_process_test/modules/login/login_page.dart';
import 'package:max_process_test/modules/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(new MyApp());
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
        '/listagem': (BuildContext context) => new ListagemPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Max Procress',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
