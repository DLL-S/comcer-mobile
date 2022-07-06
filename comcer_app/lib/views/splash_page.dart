import 'dart:ui';

import 'package:comcer_app/core/app_imagens.dart';
import 'package:comcer_app/service/prefs_service.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.wait(
            [PrefsService.isAuth(), Future.delayed(const Duration(seconds: 3))])
        .then((value) => value[0]
            ? Navigator.pushReplacementNamed(context, '/base')
            : Navigator.pushReplacementNamed(context, '/login'));

    // Future.delayed(const Duration(seconds: 3)).then((_) => Navigator.pushReplacementNamed(
    //     context, '/login'));
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.background),
                    fit: BoxFit.cover)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(AppImages.whiteLogo))),
          ),
        ],
      ),
    );
  }
}
