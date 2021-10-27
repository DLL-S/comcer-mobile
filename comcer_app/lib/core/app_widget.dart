import 'package:comcer_app/core/app_cores.dart';
import 'package:comcer_app/ui/home_page.dart';
import 'package:comcer_app/ui/login_page.dart';
import 'package:comcer_app/ui/splash_page.dart';
import 'package:comcer_app/util/Constantes.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashPage(),
      title: Constantes.titulo,
      theme: ThemeData(
          fontFamily: 'Roboto',
        primaryColor: AppCores.darkRed,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
