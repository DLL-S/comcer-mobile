import 'package:comcer_app/controller/order_resume_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/service/prefs_service.dart';
import 'package:comcer_app/ui/base_screen.dart';
import 'package:comcer_app/ui/home_screen.dart';
import 'package:comcer_app/ui/login_screen.dart';
import 'package:comcer_app/ui/order_resume_screen.dart';
import 'package:comcer_app/ui/request_screen.dart';
import 'package:comcer_app/ui/splash_page.dart';
import 'package:comcer_app/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
          ChangeNotifierProvider(create: (_) => PrefsService(), lazy: false,),
          ListenableProvider<OrderResumeController>(create: (_) => OrderResumeController(), lazy: false,),
      ],
        child:  MaterialApp(
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
          '/resumo': (context) => OrderResumeScreen(),
        },
      ),
    );
  }
}
