import 'dart:ui';

import 'package:comcer_app/dependency_injector/cc_module.dart';
import 'package:comcer_app/service/prefs_service.dart';
import 'package:comcer_app/splash/contract/splash_contract.dart';
import 'package:flutter/material.dart';

import '../../design/cc_images.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> implements SplashContractView {

  late SplashContractPresenter _presenter;

  _SplashViewState() {
    CCModule.init();
    _presenter = getIt(param1: this);
  }

  @override
  Future<bool> login() async {
    if (await PrefsService.isAuth()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void redirectToHome() {
    Navigator.pushReplacementNamed(context, '/base');
  }

  @override
  void redirectToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    Future.wait([_presenter.login(), Future.delayed(const Duration(seconds: 3))]).then((value) => value[0] ? redirectToHome() : redirectToLogin());
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(CCImages.background),
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
                image: DecorationImage(image: AssetImage(CCImages.whiteLogo))),
          ),
        ],
      ),
    );
  }
}
