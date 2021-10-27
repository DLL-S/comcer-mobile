import 'dart:ui';

import 'package:comcer_app/core/app_gradientes.dart';
import 'package:comcer_app/core/app_imagens.dart';
import 'package:comcer_app/ui/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((_) => Navigator.pushReplacementNamed(
        context, '/login'));
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                 image: DecorationImage(
                   image: AssetImage(AppImagens.background),
                   fit: BoxFit.cover
                 )
                ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0 ),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
            ),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImagens.logoBranco)
                )
            ),
          ),

        ],
        ),
    );
  }
}
