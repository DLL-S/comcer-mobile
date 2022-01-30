import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/service/prefs_service.dart';
import 'package:comcer_app/ui/base_screen.dart';
import 'package:comcer_app/ui/home_screen.dart';
import 'package:comcer_app/ui/login_screen.dart';
import 'package:comcer_app/ui/request_screen.dart';
import 'package:comcer_app/ui/splash_page.dart';
import 'package:comcer_app/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PrefsService(),
      child: MaterialApp(
        home: const SplashPage(),
        title: Constant.title,
        theme: ThemeData(
            fontFamily: 'Roboto',
          primaryColor: AppColors.darkRed,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (context) => LoginScreen(),
          '/base': (context) => BasePage(),
          '/home': (context) => HomeScreen(),
          '/pedidos': (context) => RequestScreen(),
        },
      ),
    );
  }
}
